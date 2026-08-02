import 'package:kore_client/src/translation/translation_client.dart';
import 'package:kore_client/src/translation/translation_delta.dart';
import 'package:kore_client/src/translation/translation_models.dart';
import 'package:llm_clients/llm_clients.dart';

/// [TranslationClient] backed by an Agent Client Protocol agent.
final class AcpTranslationClient implements TranslationClient {
  AcpTranslationClient({required this.llm});

  final AcpLlmClient llm;

  @override
  Stream<TranslationEvent> streamTranslation({
    required String systemPrompt,
    required String text,
    // ACP has no thinking switch — agents reason at their own discretion,
    // and thought chunks stream whenever the agent emits them.
    bool thinking = true,
  }) {
    final updates = llm.streamPrompt(systemPrompt: systemPrompt, userText: text);
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
