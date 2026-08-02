import 'package:kore_client/src/translation/translation_client.dart';
import 'package:kore_client/src/translation/translation_delta.dart';
import 'package:kore_client/src/translation/translation_models.dart';
import 'package:llm_clients/llm_clients.dart';

/// [TranslationClient] backed by an Agent Client Protocol agent.
final class AcpTranslationClient implements TranslationClient {
  AcpTranslationClient({required this.llm});

  final AcpLlmClient llm;

  // ACP has no thinking switch — agents reason at their own discretion, and
  // thought chunks stream whenever the agent emits them. Accordingly,
  // `AcpConfig` carries no thinking field.
  @override
  Stream<TranslationEvent> streamTranslation({
    required String systemPrompt,
    required String text,
  }) {
    // ACP has no system-prompt slot either: the prompt is prepended to the
    // turn's text block here, where that translation-specific composition
    // belongs.
    final updates = llm.streamPrompt(text: '$systemPrompt\n\n$text');
    return assembleTranslationEvents(updates.expand(_deltasOf));
  }

  Iterable<TranslationDelta> _deltasOf(AcpSessionUpdate update) sync* {
    switch (update) {
      case AcpAgentMessageChunk(content: AcpTextContent(:final text)):
        yield TranslationTextDelta(text);
      case AcpAgentThoughtChunk(content: AcpTextContent(:final text)):
        yield TranslationThinkingDelta(text);
      default:
        break;
    }
  }
}
