import 'package:kore_client/src/translation/translation_client.dart';
import 'package:kore_client/src/translation/translation_delta.dart';
import 'package:kore_client/src/translation/translation_models.dart';
import 'package:llm_clients/llm_clients.dart';

/// [TranslationClient] backed by the Anthropic Messages API.
final class AnthropicTranslationClient implements TranslationClient {
  AnthropicTranslationClient({required this.llm});

  final AnthropicLlmClient llm;

  @override
  Stream<TranslationEvent> streamTranslation({
    required String systemPrompt,
    required String text,
  }) {
    final events = llm.streamMessages(
      systemPrompt: systemPrompt,
      userText: text,
      // Thinking tokens count toward max_tokens, so leave generous headroom.
      maxTokens: 16384,
      // Claude 5 models only accept adaptive thinking, and their `display`
      // defaults to "omitted" (empty thinking blocks) — "summarized" opts in
      // to receiving the thinking text.
      thinking: llm.config.thinking ? const {'type': 'adaptive', 'display': 'summarized'} : const {'type': 'disabled'},
    );
    return assembleTranslationEvents(events.expand(_deltasOf));
  }

  Iterable<TranslationDelta> _deltasOf(AnthropicStreamEvent event) sync* {
    switch (event) {
      case AnthropicContentBlockDeltaEvent(delta: AnthropicTextDelta(:final text)):
        yield TranslationTextDelta(text);
      case AnthropicContentBlockDeltaEvent(delta: AnthropicThinkingDelta(:final thinking)):
        yield TranslationThinkingDelta(thinking);
      default:
        break;
    }
  }
}
