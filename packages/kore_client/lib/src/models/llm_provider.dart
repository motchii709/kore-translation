/// Supported LLM backends.
///
/// [openAi] works with any OpenAI-compatible endpoint (OpenAI, Groq, Ollama,
/// LM Studio, OpenRouter, ...) by changing the base URL.
enum LlmProvider {
  openAi(
    id: 'openai',
    label: 'OpenAI 互換',
    defaultBaseUrl: 'https://api.openai.com/v1',
    defaultModel: 'gpt-5-mini',
    apiKeyEnvName: 'OPENAI_API_KEY',
  ),
  anthropic(
    id: 'anthropic',
    label: 'Anthropic',
    defaultBaseUrl: 'https://api.anthropic.com',
    defaultModel: 'claude-sonnet-5',
    apiKeyEnvName: 'ANTHROPIC_API_KEY',
  ),
  google(
    id: 'google',
    label: 'Google AI',
    defaultBaseUrl: 'https://generativelanguage.googleapis.com',
    defaultModel: 'gemini-2.5-flash',
    apiKeyEnvName: 'GEMINI_API_KEY',
  );

  const LlmProvider({
    required this.id,
    required this.label,
    required this.defaultBaseUrl,
    required this.defaultModel,
    required this.apiKeyEnvName,
  });

  /// Stable identifier used for persistence and CLI options.
  final String id;

  final String label;
  final String defaultBaseUrl;
  final String defaultModel;

  /// Conventional environment variable holding the API key for this backend.
  final String apiKeyEnvName;

  static LlmProvider? fromId(String? id) {
    for (final provider in values) {
      if (provider.id == id) {
        return provider;
      }
    }
    return null;
  }
}
