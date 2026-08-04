import 'package:llm_sdk_acp/llm_sdk_acp.dart';
import 'package:test/test.dart';

void main() {
  test('open() spawns and handshakes; the system prompt travels inside the turn text', () async {
    final session = await AcpClient(command: 'dart test/fixtures/fake_acp_agent.dart').open();
    addTearDown(session.close);

    final snapshots = await session
        .streamObject(
          system: 'Translate into English.',
          user: 'hello',
          thinking: true,
          decoder: (thinking, reply) => (thinking, reply?['translation']),
        )
        .toList();

    expect(session.isAlive, isTrue);
    expect(snapshots.first, ('considering', null));
    // The fake agent echoes the turn's text block back as the translation,
    // proving the system prompt arrived inside it (ACP has no system slot).
    const turnText = 'Translate into English.\n\nhello';
    expect(snapshots.last, ('considering', turnText));
  });
}
