import 'package:kore_client/src/translation/translation_client.dart';
import 'package:kore_client/src/translation/translation_delta.dart';
import 'package:kore_client/src/translation/translation_models.dart';
import 'package:llm_clients/llm_clients.dart';

/// [TranslationClient] backed by the Codex app-server.
final class CodexTranslationClient implements TranslationClient {
  CodexTranslationClient({required this.llm});

  final CodexLlmClient llm;

  @override
  Stream<TranslationEvent> streamTranslation({
    required String systemPrompt,
    required String text,
  }) {
    final events = llm.streamTurn(
      systemPrompt: systemPrompt,
      userText: text,
      // Codex models always reason; the summary setting only controls
      // whether the reasoning streams back as text.
      reasoningSummary: llm.config.thinking ? 'auto' : 'none',
    );
    return assembleTranslationEvents(events.expand(_deltasOf));
  }

  Iterable<TranslationDelta> _deltasOf(CodexTurnEvent event) sync* {
    switch (event) {
      case CodexAgentMessageDelta(:final delta):
        yield TranslationTextDelta(delta);
      case CodexReasoningSummaryTextDelta(:final delta) || CodexReasoningTextDelta(:final delta):
        yield TranslationThinkingDelta(delta);
    }
  }
}
