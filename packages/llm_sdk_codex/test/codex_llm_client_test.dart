import 'dart:async';
import 'dart:convert';

import 'package:llm_sdk_codex/src/codex_llm_client.dart';
import 'package:llm_sdk_codex/src/codex_stream_models.dart';
import 'package:llm_sdk_core/llm_sdk_core.dart';
import 'package:stream_channel/stream_channel.dart';
import 'package:test/test.dart';

/// A minimal in-memory Codex app-server: answers the handshake and delegates
/// `turn/start` to [onTurn]. Like the real server (observed on the wire), it
/// omits the `jsonrpc` field from everything it sends.
final class _FakeAppServer {
  _FakeAppServer(StreamChannelController<String> transport, {required this.onTurn}) : _transport = transport {
    transport.foreign.stream.listen(_onMessage);
  }

  final StreamChannelController<String> _transport;
  final void Function(_FakeAppServer server, Map<String, dynamic> params) onTurn;

  final receivedMethods = <String>[];
  final interruptReceived = Completer<Map<String, dynamic>>();
  Map<String, dynamic>? threadStartParams;
  Map<String, dynamic>? turnStartParams;

  void send(Map<String, Object?> message) => _transport.foreign.sink.add(jsonEncode(message));

  void notify(String method, Map<String, Object?> params) => send({'method': method, 'params': params});

  void _onMessage(String line) {
    final message = jsonDecode(line) as Map<String, dynamic>;
    final method = message['method'] as String?;
    if (method == null) {
      return;
    }
    receivedMethods.add(method);
    final params = message['params'] as Map<String, dynamic>?;
    switch (method) {
      case 'initialize':
        send({
          'id': message['id'],
          'result': {'userAgent': 'fake/1.0'},
        });
      case 'thread/start':
        threadStartParams = params;
        send({
          'id': message['id'],
          'result': {
            'thread': {'id': 'thread-1'},
            'model': 'gpt-test',
          },
        });
      case 'turn/start':
        turnStartParams = params;
        send({
          'id': message['id'],
          'result': {
            'turn': {'id': 'turn-1', 'items': <Object?>[], 'status': 'inProgress'},
          },
        });
        onTurn(this, params!);
      case 'turn/interrupt':
        interruptReceived.complete(params);
        send({'id': message['id'], 'result': <String, Object?>{}});
    }
  }

  void completeTurn({String status = 'completed', Map<String, Object?>? error}) {
    notify('turn/completed', {
      'threadId': 'thread-1',
      'turn': {'id': 'turn-1', 'items': <Object?>[], 'status': status, 'error': error},
    });
  }
}

void main() {
  test('streams reasoning and message deltas of one turn', () async {
    final transport = StreamChannelController<String>();
    final server = _FakeAppServer(
      transport,
      onTurn: (server, params) {
        expect(params['input'], [
          {'type': 'text', 'text': 'こんにちは'},
        ]);
        expect(params['summary'], 'auto');
        server.notify('thread/started', {
          'thread': {'id': 'thread-1'},
        });
        server.notify('item/reasoning/summaryTextDelta', {
          'threadId': 'thread-1',
          'turnId': 'turn-1',
          'itemId': 'r-1',
          'summaryIndex': 0,
          'delta': 'considering',
        });
        server.notify('item/agentMessage/delta', {
          'threadId': 'thread-1',
          'turnId': 'turn-1',
          'itemId': 'm-1',
          'delta': '{"translation":',
        });
        server.notify('item/agentMessage/delta', {
          'threadId': 'thread-1',
          'turnId': 'turn-1',
          'itemId': 'm-1',
          'delta': ' "Hi"}',
        });
        server.completeTurn();
      },
    );

    final client = await CodexLlmClient.connect(transport.local, model: 'gpt-test-mini');
    final events = await client
        .streamTurn(systemPrompt: 'Translate.', userText: 'こんにちは', reasoningSummary: 'auto')
        .toList();

    expect(events, const [
      CodexTurnEvent.reasoningSummaryTextDelta(delta: 'considering'),
      CodexTurnEvent.agentMessageDelta(delta: '{"translation":'),
      CodexTurnEvent.agentMessageDelta(delta: ' "Hi"}'),
    ]);
    expect(server.receivedMethods, ['initialize', 'initialized', 'thread/start', 'turn/start']);
    expect(server.threadStartParams, containsPair('baseInstructions', 'Translate.'));
    expect(server.threadStartParams, containsPair('ephemeral', true));
    expect(server.threadStartParams, containsPair('approvalPolicy', 'never'));
    expect(server.threadStartParams, containsPair('model', 'gpt-test-mini'));
  });

  test('a non-JSON line on the wire fails the turn instead of hanging it', () async {
    final transport = StreamChannelController<String>();
    _FakeAppServer(
      transport,
      // The channel contract (StdioAgentProcess) is one JSON-RPC message
      // per event, so this is corruption; without an error the turn would
      // wait for its turn/completed notification forever.
      onTurn: (server, params) => transport.foreign.sink.add('corrupted line'),
    );

    final client = await CodexLlmClient.connect(transport.local, model: '');
    await expectLater(
      client.streamTurn(systemPrompt: 's', userText: 'u').drain<void>(),
      throwsA(isA<LlmApiException>()),
    );
  });

  test('a failed turn surfaces the turn error as LlmApiException', () async {
    final transport = StreamChannelController<String>();
    _FakeAppServer(
      transport,
      onTurn: (server, params) {
        server.completeTurn(status: 'failed', error: {'message': 'Usage limit exceeded'});
      },
    );

    final client = await CodexLlmClient.connect(transport.local, model: '');
    await expectLater(
      client.streamTurn(systemPrompt: 's', userText: 'u').drain<void>(),
      throwsA(
        isA<LlmApiException>().having((e) => e.message, 'message', 'Usage limit exceeded'),
      ),
    );
  });

  test('cancelling the subscription interrupts the turn', () async {
    final transport = StreamChannelController<String>();
    final firstDelta = Completer<CodexTurnEvent>();
    final server = _FakeAppServer(
      transport,
      onTurn: (server, params) {
        server.notify('item/agentMessage/delta', {
          'threadId': 'thread-1',
          'turnId': 'turn-1',
          'itemId': 'm-1',
          'delta': 'partial',
        });
      },
    );

    final client = await CodexLlmClient.connect(transport.local, model: '');
    late final StreamSubscription<CodexTurnEvent> subscription;
    subscription = client.streamTurn(systemPrompt: 's', userText: 'u').listen((event) {
      firstDelta.complete(event);
      unawaited(subscription.cancel());
    });

    expect(await firstDelta.future, const CodexTurnEvent.agentMessageDelta(delta: 'partial'));
    expect(await server.interruptReceived.future, {'threadId': 'thread-1', 'turnId': 'turn-1'});
  });

  test('omits the model override when the client has none', () async {
    final transport = StreamChannelController<String>();
    final server = _FakeAppServer(transport, onTurn: (server, params) => server.completeTurn());

    final client = await CodexLlmClient.connect(transport.local, model: '');
    await client.streamTurn(systemPrompt: 's', userText: 'u').drain<void>();

    expect(server.threadStartParams, isNot(contains('model')));
    expect(server.turnStartParams, isNot(contains('summary')));
  });
}
