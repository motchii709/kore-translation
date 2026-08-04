import 'package:llm_sdk_codex/llm_sdk_codex.dart';
import 'package:test/test.dart';

void main() {
  test('open() spawns and handshakes; reasoning summaries stream as thinking', () async {
    final session = await CodexClient(
      command: 'dart test/fixtures/fake_codex_app_server.dart',
      model: '',
    ).open();
    addTearDown(session.close);

    final snapshots = await session
        .streamObject(
          system: 'Translate.',
          user: 'hello',
          thinking: true,
          decoder: (thinking, reply) => (thinking, reply?['translation']),
        )
        .toList();

    expect(session.isAlive, isTrue);
    expect(snapshots, [
      ('considering', null),
      ('considering', 'Hello'),
    ]);
  });
}
