import 'package:kore_client/src/translation/translation_client.dart';
import 'package:kore_client/src/translation/translation_delta.dart';
import 'package:kore_client/src/translation/translation_models.dart';
import 'package:llm_clients/llm_clients.dart';

/// [TranslationClient] backed by a generic OpenAI-compatible endpoint.
final class OpenAiCompatibleTranslationClient implements TranslationClient {
  OpenAiCompatibleTranslationClient({required this.llm});

  final OpenAiCompatibleLlmClient llm;

  @override
  Stream<TranslationEvent> streamTranslation({
    required String systemPrompt,
    required String text,
    bool thinking = true,
  }) {
    final chunks = llm.streamChatCompletions(
      systemPrompt: systemPrompt,
      userText: text,
      responseFormat: const {'type': 'json_object'},
    );
    return assembleTranslationEvents(chunks.expand(_deltasOf));
  }

  Iterable<TranslationDelta> _deltasOf(OpenAiCompatibleChatChunk chunk) sync* {
    final delta = chunk.choices.isEmpty ? null : chunk.choices.first.delta;
    // The first chunk arrives with `content: ""`; drop empty deltas here.
    if (delta?.content case final String text when text.isNotEmpty) {
      yield TranslationTextDelta(text);
    }
  }
}
