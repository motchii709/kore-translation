// A minimal stand-in for an ACP agent, spoken over stdio JSONL. Answers the
// handshake, then one prompt turn: a thought chunk, an update outside the
// schema (must be skipped), and a message that echoes the received turn text
// back as the translation — letting the test assert the prompt composition
// end-to-end. Exits when stdin closes (EOF), like a well-behaved agent.
import 'dart:convert';
import 'dart:io';

void send(Map<String, Object?> message) => stdout.writeln(jsonEncode(message));

void update(Map<String, Object?> update) => send({
  'jsonrpc': '2.0',
  'method': 'session/update',
  'params': {'sessionId': 'sess-1', 'update': update},
});

Future<void> main() async {
  await for (final line in stdin.transform(utf8.decoder).transform(const LineSplitter())) {
    final message = jsonDecode(line) as Map<String, dynamic>;
    final id = message['id'];
    switch (message['method']) {
      case 'initialize':
        send({
          'jsonrpc': '2.0',
          'id': id,
          'result': {'protocolVersion': 1, 'agentCapabilities': <String, Object?>{}, 'authMethods': <Object?>[]},
        });
      case 'session/new':
        send({
          'jsonrpc': '2.0',
          'id': id,
          'result': {'sessionId': 'sess-1'},
        });
      case 'session/prompt':
        final blocks = (message['params'] as Map<String, dynamic>)['prompt'] as List<dynamic>;
        final text = (blocks.single as Map<String, dynamic>)['text'] as String;
        update({
          'sessionUpdate': 'agent_thought_chunk',
          'content': {'type': 'text', 'text': 'considering'},
        });
        update({'sessionUpdate': 'usage_update', 'used': 1, 'size': 2});
        update({
          'sessionUpdate': 'agent_message_chunk',
          'content': {'type': 'text', 'text': '{"translation": '},
        });
        update({
          'sessionUpdate': 'agent_message_chunk',
          'content': {'type': 'text', 'text': '${jsonEncode(text)}}'},
        });
        send({
          'jsonrpc': '2.0',
          'id': id,
          'result': {'stopReason': 'end_turn'},
        });
    }
  }
}
