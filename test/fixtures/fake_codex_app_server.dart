// A minimal stand-in for `codex app-server`, spoken over stdio JSONL.
// Like the real server, it omits the `jsonrpc` field from its messages.
// Every turn answers with one fixed translation JSON.
import 'dart:convert';
import 'dart:io';

void send(Map<String, Object?> message) => stdout.writeln(jsonEncode(message));

Future<void> main() async {
  await for (final line in stdin.transform(utf8.decoder).transform(const LineSplitter())) {
    final message = jsonDecode(line) as Map<String, dynamic>;
    final id = message['id'];
    switch (message['method']) {
      case 'initialize':
        send({
          'id': id,
          'result': {'userAgent': 'fake-codex/1.0'},
        });
      case 'thread/start':
        send({
          'id': id,
          'result': {
            'thread': {'id': 'thread-1'},
          },
        });
      case 'turn/start':
        final threadId = (message['params'] as Map<String, dynamic>)['threadId'];
        send({
          'id': id,
          'result': {
            'turn': {'id': 'turn-1', 'items': <Object?>[], 'status': 'inProgress'},
          },
        });
        send({
          'method': 'item/agentMessage/delta',
          'params': {
            'threadId': threadId,
            'turnId': 'turn-1',
            'itemId': 'm-1',
            'delta': '{"translation": "Hello"}',
          },
        });
        send({
          'method': 'turn/completed',
          'params': {
            'threadId': threadId,
            'turn': {'id': 'turn-1', 'items': <Object?>[], 'status': 'completed'},
          },
        });
    }
  }
}
