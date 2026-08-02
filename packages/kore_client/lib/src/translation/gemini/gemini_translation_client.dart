import 'package:kore_client/src/llm/http/gemini/gemini_llm_client.dart';
import 'package:kore_client/src/llm/http/gemini/gemini_stream_models.dart';
import 'package:kore_client/src/translation/translation_client.dart';
import 'package:kore_client/src/translation/translation_delta.dart';
import 'package:kore_client/src/translation/translation_models.dart';
import 'package:kore_client/src/translation/translation_prompt_builder.dart';

/// [TranslationClient] backed by the Google AI (Gemini) API.
final class GeminiTranslationClient implements TranslationClient {
  GeminiTranslationClient({required this.llm});

  final GeminiLlmClient llm;

  @override
  Stream<TranslationEvent> streamTranslation(TranslationRequest request) {
    final chunks = llm.streamGenerateContent(
      systemPrompt: TranslationPromptBuilder(request).build(),
      userText: request.text,
      // Thoughts are only included in the response when explicitly requested.
      thinkingConfig: request.thinking ? const {'includeThoughts': true} : null,
    );
    return assembleTranslationEvents(chunks.expand(_deltasOf));
  }

  Iterable<TranslationDelta> _deltasOf(GeminiStreamChunk chunk) sync* {
    final parts = chunk.candidates.isEmpty
        ? const <GeminiPart>[]
        : chunk.candidates.first.content?.parts ?? const <GeminiPart>[];
    for (final part in parts) {
      final text = part.text;
      if (text == null) {
        continue;
      }
      yield part.thought ? TranslationThinkingDelta(text) : TranslationTextDelta(text);
    }
  }
}
