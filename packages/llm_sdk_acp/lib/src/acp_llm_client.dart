import 'dart:async';
import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:json_rpc_2/json_rpc_2.dart';
import 'package:llm_sdk_acp/src/acp_stream_models.dart';
import 'package:llm_sdk_core/llm_sdk_core.dart';
import 'package:stream_channel/stream_channel.dart';

/// Thin wrapper over the client side of the Agent Client Protocol
/// (https://agentclientprotocol.com, protocol version 1).
///
/// Constructed only through [connect], which completes the `initialize`
/// handshake — a client in hand is always ready to prompt, and each
/// [streamPrompt] call runs one `session/new` + `session/prompt` turn.
/// The channel carries one JSON-RPC message per string event — see
/// `StdioAgentProcess`.
final class AcpLlmClient {
  AcpLlmClient._(StreamChannel<String> channel) : _peer = Peer(channel) {
    _peer.registerMethod('session/update', _onSessionUpdate);
    _peer.registerMethod('session/request_permission', _onRequestPermission);
    // A turn always has its session/prompt request pending, so a dying
    // connection reaches the consumer through that request's error.
    unawaited(_peer.listen().then<void>((_) {}, onError: (Object error) => _connectionError = error));
  }

  /// Connects over [channel] and performs the `initialize` handshake. A
  /// broken agent (wrong command, something that is not an ACP agent)
  /// fails here — never inside a prompt.
  static Future<AcpLlmClient> connect(StreamChannel<String> channel) async {
    final client = AcpLlmClient._(channel);
    await client._request('initialize', {
      'protocolVersion': _protocolVersion,
      // Capabilities omitted here are unsupported: no file system access,
      // no terminal.
      'clientCapabilities': <String, Object?>{},
      'clientInfo': {'name': 'kore translation', 'version': '0.1.1'},
    });
    return client;
  }

  static const _protocolVersion = 1;

  final Peer _peer;

  final _updatesBySession = <String, StreamController<AcpSessionUpdate>>{};

  /// The error that ended the connection (the agent process dying with its
  /// stderr trail), if any: json_rpc_2 reports closure to requesters as a
  /// bare StateError, so the cause is kept here for [_connectionClosed].
  Object? _connectionError;

  Future<Map<String, dynamic>> _request(String method, Map<String, Object?> params) async {
    try {
      return await _peer.sendRequest(method, params) as Map<String, dynamic>;
      // json_rpc_2 reports a connection that died mid-request (typically a
      // crashed or misconfigured agent) with a StateError; normalizing it
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
      'The ACP agent connection closed $context${error == null ? '' : ': $error'}',
    );
  }

  /// Streams the session updates of one prompt turn.
  ///
  /// [text] becomes the turn's single text block, sent verbatim — ACP has no
  /// further prompt structure, so any composition is the caller's business.
  /// The turn ends when the agent reports a stop reason; anything but
  /// `end_turn` becomes an [LlmApiException]. Cancelling the subscription
  /// cancels the turn.
  Stream<AcpSessionUpdate> streamPrompt({required String text}) async* {
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
            // After cancellation the agent's stop reason is 'cancelled' and
            // nobody is listening; surfacing either would be noise.
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
