import 'package:kore_client/src/translation/translation_client.dart';
import 'package:kore_client/src/translation/translation_delta.dart';
import 'package:kore_client/src/translation/translation_models.dart';
import 'package:llm_clients/llm_clients.dart';

/// [TranslationClient] backed by an OpenAI-compatible API.
final class OpenAiTranslationClient implements TranslationClient {
  OpenAiTranslationClient({required this.llm});

  final OpenAiLlmClient llm;

  @override
  Stream<TranslationEvent> streamTranslation({
    required String systemPrompt,
    required String text,
  }) {
    final chunks = llm.streamChatCompletions(
      systemPrompt: systemPrompt,
      userText: text,
      responseFormat: const {'type': 'json_object'},
    );
    return assembleTranslationEvents(chunks.expand(_deltasOf));
  }

  Iterable<TranslationDelta> _deltasOf(OpenAiChatChunk chunk) sync* {
    final delta = chunk.choices.isEmpty ? null : chunk.choices.first.delta;
    // The first chunk arrives with `content: ""`; drop empty deltas here.
    if (delta?.content case final String text when text.isNotEmpty) {
      yield TranslationTextDelta(text);
    }
  }
}
