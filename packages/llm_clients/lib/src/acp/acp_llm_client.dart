import 'dart:async';
import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:json_rpc_2/json_rpc_2.dart';
import 'package:llm_clients/src/acp/acp_stream_models.dart';
import 'package:llm_clients/src/exceptions.dart';
import 'package:stream_channel/stream_channel.dart';

/// Thin wrapper over the client side of the Agent Client Protocol
/// (https://agentclientprotocol.com, protocol version 1).
///
/// [channel] carries one JSON-RPC message per string event — see
/// `StdioAgentProcess`. The connection is initialized once, then each
/// [streamPrompt] call runs one `session/new` + `session/prompt` turn.
final class AcpLlmClient {
  AcpLlmClient({required this.channel});

  static const _protocolVersion = 1;

  final StreamChannel<String> channel;

  final _updatesBySession = <String, StreamController<AcpSessionUpdate>>{};

  late final Peer _peer = _connect();
  late final Future<void> _initialized = _initialize();

  Peer _connect() {
    final peer = Peer(channel);
    peer.registerMethod('session/update', _onSessionUpdate);
    peer.registerMethod('session/request_permission', _onRequestPermission);
    // Connection failures also complete every in-flight request, so the
    // done future's error adds nothing.
    peer.listen().ignore();
    return peer;
  }

  Future<void> _initialize() async {
    await _request('initialize', {
      'protocolVersion': _protocolVersion,
      // Capabilities omitted here are unsupported: no file system access,
      // no terminal.
      'clientCapabilities': <String, Object?>{},
      'clientInfo': {'name': 'kore translation', 'version': '0.1.0'},
    });
  }

  Future<Map<String, dynamic>> _request(String method, Map<String, Object?> params) async {
    try {
      return await _peer.sendRequest(method, params) as Map<String, dynamic>;
      // json_rpc_2 reports a connection that died mid-request (typically a
      // crashed or misconfigured agent) with a StateError; normalizing it
      // here at the source keeps callers on the Exception hierarchy. The
      // agent's stderr carries the actual cause.
      // ignore: avoid_catching_errors
    } on StateError {
      throw LlmApiException('The ACP agent connection closed during $method');
    }
  }

  /// Streams the session updates of one prompt turn.
  ///
  /// [text] becomes the turn's single text block, sent verbatim — ACP has no
  /// further prompt structure, so any composition is the caller's business.
  /// The turn ends when the agent reports a stop reason; anything but
  /// `end_turn` becomes an [LlmApiException]. Cancelling the subscription
  /// cancels the turn.
  Stream<AcpSessionUpdate> streamPrompt({required String text}) async* {
    await _initialized;
    final session = await _request('session/new', {
      // A session requires a working directory even though translation
      // touches no files; the system temp directory is the neutral choice.
      'cwd': Directory.systemTemp.path,
      'mcpServers': <Object?>[],
    });
    final sessionId = session['sessionId'] as String;

    final updates = StreamController<AcpSessionUpdate>();
    _updatesBySession[sessionId] = updates;
    var turnDone = false;
    var cancelled = false;
    unawaited(
      _request('session/prompt', {
            'sessionId': sessionId,
            'prompt': [
              {'type': 'text', 'text': text},
            ],
          })
          .then(
            (result) {
              final stopReason = result['stopReason'];
              if (stopReason != 'end_turn' && !cancelled) {
                updates.addError(LlmApiException('ACP agent stopped: $stopReason'));
              }
            },
            onError: (Object error, StackTrace stackTrace) {
              if (!cancelled) {
                updates.addError(error, stackTrace);
              }
            },
          )
          .whenComplete(() {
            turnDone = true;
            unawaited(updates.close());
          }),
    );
    try {
      yield* updates.stream;
    } finally {
      cancelled = true;
      _updatesBySession.remove(sessionId);
      // Disposal may kill the agent before this subscription is cancelled;
      // a closed connection cannot deliver the cancellation anyway.
      if (!turnDone && !_peer.isClosed) {
        _peer.sendNotification('session/cancel', {'sessionId': sessionId});
      }
    }
  }

  void _onSessionUpdate(Parameters params) {
    final message = params.value as Map<String, dynamic>;
    // The controller is created, owned, and closed by streamPrompt.
    // ignore: close_sinks
    final updates = _updatesBySession[message['sessionId']];
    // Agents keep sending updates after the turn's result (observed with
    // claude-agent-acp's `session_info_update`), so the controller may
    // already be gone or closed.
    if (updates == null || updates.isClosed) {
      return;
    }
    try {
      updates.add(AcpSessionUpdate.fromJson(message['update'] as Map<String, dynamic>));
    } on CheckedFromJsonException {
      return; // Skip updates outside the schema.
    }
  }

  Map<String, Object?> _onRequestPermission(Parameters params) {
    // Translation needs no tools, so every permission request is refused and
    // the agent falls back to answering in plain text. Prefer an explicit
    // reject option; cancel the request when the agent offers none.
    final message = params.value as Map<String, dynamic>;
    for (final option in (message['options'] as List<dynamic>).cast<Map<String, dynamic>>()) {
      if ((option['kind'] as String).startsWith('reject')) {
        return {
          'outcome': {'outcome': 'selected', 'optionId': option['optionId']},
        };
      }
    }
    return {
      'outcome': {'outcome': 'cancelled'},
    };
  }
}
