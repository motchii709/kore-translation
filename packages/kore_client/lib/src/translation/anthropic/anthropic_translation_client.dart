import 'package:kore_client/src/llm/http/anthropic/anthropic_llm_client.dart';
import 'package:kore_client/src/llm/http/anthropic/anthropic_stream_models.dart';
import 'package:kore_client/src/translation/translation_client.dart';
import 'package:kore_client/src/translation/translation_delta.dart';
import 'package:kore_client/src/translation/translation_models.dart';
import 'package:kore_client/src/translation/translation_prompt_builder.dart';

/// [TranslationClient] backed by the Anthropic Messages API.
final class AnthropicTranslationClient implements TranslationClient {
  AnthropicTranslationClient({required this.llm});

  final AnthropicLlmClient llm;

  @override
  Stream<TranslationEvent> streamTranslation(TranslationRequest request) {
    final events = llm.streamMessages(
      systemPrompt: TranslationPromptBuilder(request).build(),
      userText: request.text,
      // Claude 5 models only accept adaptive thinking, and their `display`
      // defaults to "omitted" (empty thinking blocks) — "summarized" opts in
      // to receiving the thinking text.
      thinking: request.thinking
          ? const {'type': 'adaptive', 'display': 'summarized'}
          : const {'type': 'disabled'},
    );
    return assembleTranslationEvents(events.expand(_deltasOf));
  }

  Iterable<TranslationDelta> _deltasOf(AnthropicStreamEvent event) sync* {
    switch (event) {
      case AnthropicContentBlockDeltaEvent(
        delta: AnthropicTextDelta(:final text),
      ):
        yield TranslationTextDelta(text);
      case AnthropicContentBlockDeltaEvent(
        delta: AnthropicThinkingDelta(:final thinking),
      ):
        yield TranslationThinkingDelta(thinking);
      default:
        break;
    }
  }
}
