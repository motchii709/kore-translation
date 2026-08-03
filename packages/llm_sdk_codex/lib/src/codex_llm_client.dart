import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:json_rpc_2/json_rpc_2.dart';
import 'package:llm_sdk_codex/src/codex_stream_models.dart';
import 'package:llm_sdk_core/llm_sdk_core.dart';
import 'package:stream_channel/stream_channel.dart';

/// Thin wrapper over the Codex app-server protocol (`codex app-server`,
/// the v2 thread/turn API spoken by the official IDE extensions).
///
/// Constructed only through [connect], which completes the `initialize`
/// handshake — a client in hand is always ready, and each [streamTurn]
/// call runs one `thread/start` + `turn/start` turn. The channel carries
/// one JSON-RPC message per string event — see `StdioAgentProcess`.
/// Authentication and default model come from the Codex CLI itself
/// (`codex login`, `~/.codex/config.toml`).
final class CodexLlmClient {
  CodexLlmClient._(this.model, StreamChannel<String> channel) : _peer = Peer.withoutJson(_messages(channel)) {
    _peer.registerMethod('item/agentMessage/delta', (Parameters params) {
      _routeDelta(params, (delta) => CodexTurnEvent.agentMessageDelta(delta: delta));
    });
    _peer.registerMethod('item/reasoning/summaryTextDelta', (Parameters params) {
      _routeDelta(params, (delta) => CodexTurnEvent.reasoningSummaryTextDelta(delta: delta));
    });
    _peer.registerMethod('item/reasoning/textDelta', (Parameters params) {
      _routeDelta(params, (delta) => CodexTurnEvent.reasoningTextDelta(delta: delta));
    });
    _peer.registerMethod('turn/completed', _onTurnCompleted);
    // A running turn has no pending request (deltas and completion arrive
    // as notifications), so a connection dying mid-turn would leave the
    // live turn waiting forever: fail the survivors when the connection
    // ends. Unregistered notifications (thread/started, tokenUsage, ...)
    // are dropped by json_rpc_2.
    unawaited(
      _peer.listen().then<void>((_) {}, onError: (Object error) => _connectionError = error).whenComplete(() {
        for (final events in [..._eventsByThread.values]) {
          if (!events.isClosed) {
            events.addError(_connectionClosed('mid-turn'));
            unawaited(events.close());
          }
        }
      }),
    );
  }

  /// Connects over [channel] and performs the `initialize` handshake. A
  /// broken server (wrong command, something that is not an app-server)
  /// fails here — never inside a turn. An empty [model] uses the Codex
  /// configuration's default.
  static Future<CodexLlmClient> connect(StreamChannel<String> channel, {required String model}) async {
    final client = CodexLlmClient._(model, channel);
    await client._request('initialize', {
      'clientInfo': {'name': 'kore translation', 'version': '0.1.1'},
    });
    client._peer.sendNotification('initialized');
    return client;
  }

  /// The model override sent with every thread; empty means the server's
  /// own default.
  final String model;

  final Peer _peer;

  final _eventsByThread = <String, StreamController<CodexTurnEvent>>{};

  /// The error that ended the connection (the agent process dying with its
  /// stderr trail, wire corruption), if any: json_rpc_2 reports closure to
  /// requesters as a bare StateError, so the cause is kept here for
  /// [_connectionClosed].
  Object? _connectionError;

  /// codex app-server omits the `jsonrpc` field (observed on the wire),
  /// and json_rpc_2 drops responses without it, so decode here and patch
  /// the field in before the peer sees the message. The channel carries
  /// one JSON-RPC message per event, so a line that fails to decode is
  /// corruption: the decode error ends the connection loudly rather than
  /// leaving the turn waiting for a `turn/completed` that never comes.
  static StreamChannel<Object?> _messages(StreamChannel<String> channel) => StreamChannel(
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

  Future<Map<String, dynamic>> _request(String method, Map<String, Object?> params) async {
    try {
      return await _peer.sendRequest(method, params) as Map<String, dynamic>;
      // json_rpc_2 reports a connection that died mid-request (typically a
      // crashed or misconfigured server) with a StateError; normalizing it
      // here at the source keeps callers on the Exception hierarchy.
      // ignore: avoid_catching_errors
    } on StateError {
      throw _connectionClosed('during $method');
    }
  }

  LlmApiException _connectionClosed(String context) {
    final error = _connectionError;
    // The transport's own exception (agent death with its stderr trail)
    // already says everything; only wrap causes that are not ours.
    if (error is LlmApiException) {
      return error;
    }
    return LlmApiException(
      'The Codex app-server connection closed $context${error == null ? '' : ': $error'}',
    );
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
      if (model.isNotEmpty) 'model': model,
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
          // Best-effort: the consumer is gone, so the response (or its
          // error) has no audience.
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
