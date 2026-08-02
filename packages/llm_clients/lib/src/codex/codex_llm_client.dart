import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:json_rpc_2/json_rpc_2.dart';
import 'package:llm_clients/src/codex/codex_stream_models.dart';
import 'package:llm_clients/src/exceptions.dart';
import 'package:llm_clients/src/llm_client_config.dart';
import 'package:stream_channel/stream_channel.dart';

/// Thin wrapper over the Codex app-server protocol (`codex app-server`,
/// the v2 thread/turn API spoken by the official IDE extensions).
///
/// [channel] carries one JSON-RPC message per string event — see
/// `StdioAgentProcess`. The connection is initialized once, then each
/// [streamTurn] call runs one `thread/start` + `turn/start` turn.
/// Authentication and default model come from the Codex CLI itself
/// (`codex login`, `~/.codex/config.toml`).
final class CodexLlmClient {
  CodexLlmClient({required this.config, required this.channel});

  final CodexConfig config;
  final StreamChannel<String> channel;

  final _eventsByThread = <String, StreamController<CodexTurnEvent>>{};

  late final Peer _peer = _connect();
  late final Future<void> _initialized = _initialize();

  Peer _connect() {
    // codex app-server omits the `jsonrpc` field (observed on the wire),
    // and json_rpc_2 drops responses without it, so decode here and patch
    // the field in before the peer sees the message.
    final messages = StreamChannel<Object?>(
      channel.stream.map((line) {
        final message = jsonDecode(line);
        if (message is Map<String, dynamic>) {
          message.putIfAbsent('jsonrpc', () => '2.0');
        }
        return message;
      }),
      StreamSinkTransformer<Object?, String>.fromHandlers(
        handleData: (message, sink) => sink.add(jsonEncode(message)),
      ).bind(channel.sink),
    );
    final peer = Peer.withoutJson(messages);
    peer.registerMethod('item/agentMessage/delta', (Parameters params) {
      _routeDelta(params, (delta) => CodexTurnEvent.agentMessageDelta(delta: delta));
    });
    peer.registerMethod('item/reasoning/summaryTextDelta', (Parameters params) {
      _routeDelta(params, (delta) => CodexTurnEvent.reasoningSummaryTextDelta(delta: delta));
    });
    peer.registerMethod('item/reasoning/textDelta', (Parameters params) {
      _routeDelta(params, (delta) => CodexTurnEvent.reasoningTextDelta(delta: delta));
    });
    peer.registerMethod('turn/completed', _onTurnCompleted);
    // Connection failures also complete every in-flight request, so the
    // done future's error adds nothing. Unregistered notifications
    // (thread/started, tokenUsage, ...) are dropped by json_rpc_2.
    peer.listen().ignore();
    return peer;
  }

  Future<void> _initialize() async {
    await _request('initialize', {
      'clientInfo': {'name': 'kore', 'version': '0.1.0'},
    });
    _peer.sendNotification('initialized');
  }

  Future<Map<String, dynamic>> _request(String method, Map<String, Object?> params) async {
    try {
      return await _peer.sendRequest(method, params) as Map<String, dynamic>;
      // json_rpc_2 reports a connection that died mid-request (typically a
      // crashed or misconfigured server) with a StateError; normalizing it
      // here at the source keeps callers on the Exception hierarchy. The
      // server's stderr carries the actual cause.
      // ignore: avoid_catching_errors
    } on StateError {
      throw LlmApiException('The Codex app-server connection closed during $method');
    }
  }

  /// Streams the events of one turn, run on a fresh ephemeral thread so
  /// nothing lands in Codex's thread history.
  ///
  /// [systemPrompt] replaces Codex's base (coding) instructions.
  /// [reasoningSummary] is passed through as the turn's `summary` parameter
  /// (`auto` / `none`, ...); null keeps the server default. The turn ends
  /// with the `turn/completed` notification; a failed turn becomes an
  /// [LlmApiException]. Cancelling the subscription interrupts the turn.
  Stream<CodexTurnEvent> streamTurn({
    required String systemPrompt,
    required String userText,
    String? reasoningSummary,
  }) async* {
    await _initialized;
    final started = await _request('thread/start', {
      // A thread requires a working directory even though translation
      // touches no files; the system temp directory is the neutral choice.
      'cwd': Directory.systemTemp.path,
      'ephemeral': true,
      // Translation needs no tools: never ask for approvals and keep the
      // sandbox read-only, so no server request ever needs answering.
      'approvalPolicy': 'never',
      'sandbox': 'read-only',
      'baseInstructions': systemPrompt,
      if (config.model.isNotEmpty) 'model': config.model,
    });
    final threadId = ((started['thread'] as Map<String, dynamic>)['id']) as String;

    final events = StreamController<CodexTurnEvent>();
    _eventsByThread[threadId] = events;
    String? turnId;
    try {
      final turn = await _request('turn/start', {
        'threadId': threadId,
        'input': [
          {'type': 'text', 'text': userText},
        ],
        'summary': ?reasoningSummary,
      });
      turnId = ((turn['turn'] as Map<String, dynamic>)['id']) as String;
      yield* events.stream;
    } finally {
      _eventsByThread.remove(threadId);
      // An open controller here means the consumer cancelled mid-turn
      // (completion closes it): interrupt so the agent stops spending
      // tokens. Disposal may kill the server before this subscription is
      // cancelled, hence the closed-connection check.
      if (!events.isClosed) {
        unawaited(events.close());
        if (turnId != null && !_peer.isClosed) {
          _peer.sendRequest('turn/interrupt', {'threadId': threadId, 'turnId': turnId}).ignore();
        }
      }
    }
  }

  void _routeDelta(Parameters params, CodexTurnEvent Function(String delta) toEvent) {
    final message = params.value as Map<String, dynamic>;
    // The controller is created, owned, and closed by streamTurn; a missing
    // or closed one means nobody consumes this turn anymore.
    // ignore: close_sinks
    final events = _eventsByThread[message['threadId']];
    if (events == null || events.isClosed) {
      return;
    }
    events.add(toEvent(message['delta'] as String));
  }

  void _onTurnCompleted(Parameters params) {
    final message = params.value as Map<String, dynamic>;
    final events = _eventsByThread[message['threadId']];
    if (events == null || events.isClosed) {
      return;
    }
    final turn = message['turn'] as Map<String, dynamic>;
    // `interrupted` only happens when we cancelled; `completed` ends the
    // stream normally.
    if (turn['status'] == 'failed') {
      final error = turn['error'] as Map<String, dynamic>?;
      events.addError(
        LlmApiException((error?['message'] as String?) ?? 'The Codex turn failed'),
      );
    }
    unawaited(events.close());
  }
}
