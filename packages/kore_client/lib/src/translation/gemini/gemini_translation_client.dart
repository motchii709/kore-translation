import 'package:kore_client/src/translation/translation_client.dart';
import 'package:kore_client/src/translation/translation_delta.dart';
import 'package:kore_client/src/translation/translation_models.dart';
import 'package:llm_clients/llm_clients.dart';

/// [TranslationClient] backed by the Google AI (Gemini) API.
final class GeminiTranslationClient implements TranslationClient {
  GeminiTranslationClient({required this.llm});

  final GeminiLlmClient llm;

  @override
  Stream<TranslationEvent> streamTranslation({
    required String systemPrompt,
    required String text,
    bool thinking = true,
  }) {
    final chunks = llm.streamGenerateContent(
      systemPrompt: systemPrompt,
      userText: text,
      responseMimeType: 'application/json',
      // Thoughts are only included in the response when explicitly requested.
      thinkingConfig: thinking ? const {'includeThoughts': true} : null,
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
