import 'dart:convert';

import 'package:llm_sdk_acp/llm_sdk_acp.dart';
import 'package:llm_sdk_core/llm_sdk_core.dart';
import 'package:test/test.dart';

void main() {
  test('open() spawns and handshakes; the system prompt travels inside the turn text', () async {
    final session = await AcpClient(command: 'dart test/fixtures/fake_acp_agent.dart').open();
    addTearDown(session.close);

    final events = await session.streamText(system: 'Translate into English.', user: 'hello').toList();

    expect(session.isAlive, isTrue);
    expect(events.first, isA<LlmThinkingDelta>().having((e) => e.text, 'text', 'considering'));
    // The fake agent echoes the turn's text block back as the translation,
    // proving the system prompt arrived inside it (ACP has no system slot).
    const turnText = 'Translate into English.\n\nhello';
    expect(
      events.whereType<LlmTextDelta>().map((e) => e.text).join(),
      '{"translation": ${jsonEncode(turnText)}}',
    );
  });
}
