import 'package:llm_clients/llm_clients.dart';

/// UI labels for the LLM backends. Kept out of kore_client, which only
/// deals in stable identifiers.
extension LlmProviderUi on LlmProvider {
  String get label => switch (this) {
    LlmProvider.openAi => 'OpenAI',
    LlmProvider.openAiCompatible => 'OpenAI互換',
    LlmProvider.anthropic => 'Anthropic',
    LlmProvider.google => 'Google AI',
    LlmProvider.deepSeek => 'DeepSeek',
  };
}
