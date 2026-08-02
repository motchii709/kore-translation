import 'package:kore_client/src/llm/http/deep_seek/deep_seek_llm_client.dart';
import 'package:kore_client/src/llm/http/deep_seek/deep_seek_stream_models.dart';
import 'package:kore_client/src/translation/translation_client.dart';
import 'package:kore_client/src/translation/translation_delta.dart';
import 'package:kore_client/src/translation/translation_models.dart';
import 'package:kore_client/src/translation/translation_prompt_builder.dart';

/// [TranslationClient] backed by the DeepSeek API. Reasoning models
/// (deepseek-reasoner) stream their thinking via `reasoning_content`.
final class DeepSeekTranslationClient implements TranslationClient {
  DeepSeekTranslationClient({required this.llm});

  final DeepSeekLlmClient llm;

  @override
  Stream<TranslationEvent> streamTranslation(TranslationRequest request) {
    final chunks = llm.streamChatCompletions(
      systemPrompt: TranslationPromptBuilder(request).build(),
      userText: request.text,
    );
    return assembleTranslationEvents(
      // DeepSeek has no request parameter for reasoning (it depends on the
      // model), so an unwanted reasoning stream is dropped here instead.
      chunks.expand(
        (chunk) => _deltasOf(chunk, includeThinking: request.thinking),
      ),
    );
  }

  Iterable<TranslationDelta> _deltasOf(
    DeepSeekChatChunk chunk, {
    required bool includeThinking,
  }) sync* {
    final delta = chunk.choices.isEmpty ? null : chunk.choices.first.delta;
    // The first chunk arrives with empty content (OpenAI-compatible wire
    // behavior); drop empty deltas here.
    if (includeThinking) {
      if (delta?.reasoningContent case final String thinking when thinking.isNotEmpty) {
        yield TranslationThinkingDelta(thinking);
      }
    }
    if (delta?.content case final String text when text.isNotEmpty) {
      yield TranslationTextDelta(text);
    }
  }
}
