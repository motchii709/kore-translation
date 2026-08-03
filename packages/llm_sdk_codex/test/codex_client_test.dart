import 'package:llm_sdk_codex/llm_sdk_codex.dart';
import 'package:llm_sdk_core/llm_sdk_core.dart';
import 'package:test/test.dart';

void main() {
  test('open() spawns and handshakes; reasoning summaries stream as thinking', () async {
    final session = await CodexClient(
      command: 'dart test/fixtures/fake_codex_app_server.dart',
      model: '',
      thinking: true,
    ).open();
    addTearDown(session.close);

    final events = await session.streamText(system: 'Translate.', user: 'hello').toList();

    expect(session.isAlive, isTrue);
    expect(events, [
      isA<LlmThinkingDelta>().having((e) => e.text, 'text', 'considering'),
      isA<LlmTextDelta>().having((e) => e.text, 'text', '{"translation": "Hello"}'),
    ]);
  });
}
