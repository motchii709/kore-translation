import 'package:kore_client/src/translation/translation_client.dart';
import 'package:kore_client/src/translation/translation_delta.dart';
import 'package:kore_client/src/translation/translation_models.dart';
import 'package:llm_clients/llm_clients.dart';

/// [TranslationClient] backed by the DeepSeek API. Reasoning models
/// (deepseek-reasoner) stream their thinking via `reasoning_content`.
final class DeepSeekTranslationClient implements TranslationClient {
  DeepSeekTranslationClient({required this.llm});

  final DeepSeekLlmClient llm;

  @override
  Stream<TranslationEvent> streamTranslation({
    required String systemPrompt,
    required String text,
    bool thinking = true,
  }) {
    // No responseFormat: deepseek-reasoner rejects it; the prompt and the
    // fence-tolerant parser keep the reply usable.
    final chunks = llm.streamChatCompletions(
      systemPrompt: systemPrompt,
      userText: text,
    );
    return assembleTranslationEvents(
      // DeepSeek has no request parameter for reasoning (it depends on the
      // model), so an unwanted reasoning stream is dropped here instead.
      chunks.expand(
        (chunk) => _deltasOf(chunk, includeThinking: thinking),
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
