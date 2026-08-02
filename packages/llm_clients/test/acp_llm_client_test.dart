import 'dart:async';

import 'package:json_rpc_2/json_rpc_2.dart';
import 'package:llm_clients/llm_clients.dart';
import 'package:stream_channel/stream_channel.dart';
import 'package:test/test.dart';

/// A minimal in-memory ACP agent: answers the handshake and delegates
/// `session/prompt` to [onPrompt].
Peer _fakeAgent(
  StreamChannelController<String> transport, {
  required Future<Map<String, Object?>> Function(Peer agent, Map<String, dynamic> params) onPrompt,
}) {
  final agent = Peer(transport.foreign);
  agent.registerMethod(
    'initialize',
    (Parameters params) => {
      'protocolVersion': 1,
      'agentCapabilities': <String, Object?>{},
      'authMethods': <Object?>[],
    },
  );
  agent.registerMethod('session/new', (Parameters params) => {'sessionId': 'sess-1'});
  agent.registerMethod(
    'session/prompt',
    (Parameters params) => onPrompt(agent, params.value as Map<String, dynamic>),
  );
  agent.listen().ignore();
  return agent;
}

void _sendUpdate(Peer agent, Map<String, Object?> update) {
  agent.sendNotification('session/update', {'sessionId': 'sess-1', 'update': update});
}

Map<String, Object?> _messageChunk(String text) => {
  'sessionUpdate': 'agent_message_chunk',
  'content': {'type': 'text', 'text': text},
};

void main() {
  test('streams thought and message chunks of one prompt turn', () async {
    final transport = StreamChannelController<String>();
    Map<String, dynamic>? promptParams;
    _fakeAgent(
      transport,
      onPrompt: (agent, params) async {
        promptParams = params;
        _sendUpdate(agent, {
          'sessionUpdate': 'agent_thought_chunk',
          'content': {'type': 'text', 'text': 'considering'},
        });
        _sendUpdate(agent, {'sessionUpdate': 'usage_update', 'used': 1, 'size': 2});
        _sendUpdate(agent, _messageChunk('{"translation":'));
        _sendUpdate(agent, {
          'sessionUpdate': 'agent_message_chunk',
          'content': {'type': 'image', 'data': '...', 'mimeType': 'image/png'},
        });
        _sendUpdate(agent, _messageChunk(' "Hi"}'));
        return {'stopReason': 'end_turn'};
      },
    );

    final client = AcpLlmClient(channel: transport.local);
    final updates = await client.streamPrompt(text: 'こんにちは').toList();

    expect(promptParams, {
      'sessionId': 'sess-1',
      'prompt': [
        {'type': 'text', 'text': 'こんにちは'},
      ],
    });
    expect(updates, const [
      AcpSessionUpdate.agentThoughtChunk(content: AcpContentBlock.text(text: 'considering')),
      AcpSessionUpdate.unknown(),
      AcpSessionUpdate.agentMessageChunk(content: AcpContentBlock.text(text: '{"translation":')),
      AcpSessionUpdate.agentMessageChunk(content: AcpContentBlock.unknown()),
      AcpSessionUpdate.agentMessageChunk(content: AcpContentBlock.text(text: ' "Hi"}')),
    ]);
  });

  test('refuses permission requests, preferring an explicit reject option', () async {
    final transport = StreamChannelController<String>();
    Object? rejectOutcome;
    Object? cancelOutcome;
    _fakeAgent(
      transport,
      onPrompt: (agent, params) async {
        rejectOutcome = await agent.sendRequest('session/request_permission', {
          'sessionId': 'sess-1',
          'toolCall': {'toolCallId': 'call-1', 'title': 'Read a file'},
          'options': [
            {'optionId': 'allow', 'name': 'Allow', 'kind': 'allow_once'},
            {'optionId': 'reject', 'name': 'Reject', 'kind': 'reject_once'},
          ],
        });
        cancelOutcome = await agent.sendRequest('session/request_permission', {
          'sessionId': 'sess-1',
          'toolCall': {'toolCallId': 'call-2', 'title': 'Read a file'},
          'options': [
            {'optionId': 'allow', 'name': 'Allow', 'kind': 'allow_once'},
          ],
        });
        _sendUpdate(agent, _messageChunk('done'));
        return {'stopReason': 'end_turn'};
      },
    );

    final client = AcpLlmClient(channel: transport.local);
    await client.streamPrompt(text: 'u').drain<void>();

    expect(rejectOutcome, {
      'outcome': {'outcome': 'selected', 'optionId': 'reject'},
    });
    expect(cancelOutcome, {
      'outcome': {'outcome': 'cancelled'},
    });
  });

  test('a stop reason other than end_turn surfaces as LlmApiException', () async {
    final transport = StreamChannelController<String>();
    _fakeAgent(transport, onPrompt: (agent, params) async => {'stopReason': 'refusal'});

    final client = AcpLlmClient(channel: transport.local);
    await expectLater(
      client.streamPrompt(text: 'u').drain<void>(),
      throwsA(
        isA<LlmApiException>().having((e) => e.message, 'message', contains('refusal')),
      ),
    );
  });

  test('an RPC error of the turn propagates raw', () async {
    final transport = StreamChannelController<String>();
    _fakeAgent(
      transport,
      onPrompt: (agent, params) async => throw RpcException(-32000, 'Authentication required'),
    );

    final client = AcpLlmClient(channel: transport.local);
    await expectLater(
      client.streamPrompt(text: 'u').drain<void>(),
      throwsA(
        isA<RpcException>().having((e) => e.message, 'message', 'Authentication required'),
      ),
    );
  });

  test('cancelling the subscription cancels the turn', () async {
    final transport = StreamChannelController<String>();
    final cancelParams = Completer<Map<String, dynamic>>();
    late final Peer agent;
    agent = _fakeAgent(
      transport,
      onPrompt: (_, promptParams) async {
        _sendUpdate(agent, _messageChunk('partial'));
        expect(await cancelParams.future, {'sessionId': 'sess-1'});
        return {'stopReason': 'cancelled'};
      },
    );
    agent.registerMethod(
      'session/cancel',
      (Parameters params) => cancelParams.complete(params.value as Map<String, dynamic>),
    );

    final client = AcpLlmClient(channel: transport.local);
    final firstUpdate = Completer<AcpSessionUpdate>();
    late final StreamSubscription<AcpSessionUpdate> subscription;
    subscription = client.streamPrompt(text: 'u').listen((update) {
      firstUpdate.complete(update);
      unawaited(subscription.cancel());
    });

    expect(
      await firstUpdate.future,
      const AcpSessionUpdate.agentMessageChunk(content: AcpContentBlock.text(text: 'partial')),
    );
    await cancelParams.future; // The agent actually received session/cancel.
  });

  group('splitCommandLine', () {
    test('splits on whitespace runs', () {
      expect(
        splitCommandLine('npx  -y\t@agentclientprotocol/claude-agent-acp '),
        ['npx', '-y', '@agentclientprotocol/claude-agent-acp'],
      );
    });

    test('quotes group words and backslashes stay literal', () {
      expect(
        splitCommandLine(r'"C:\Program Files\Agent\agent.exe" --acp'),
        [r'C:\Program Files\Agent\agent.exe', '--acp'],
      );
      expect(splitCommandLine("sh -c 'echo hi'"), ['sh', '-c', 'echo hi']);
      expect(splitCommandLine('a"b c"d'), ['ab cd']);
    });
  });
}
