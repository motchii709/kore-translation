/// Stable identifiers for the supported LLM backends, used for persistence
/// and CLI options. Anything beyond identity (defaults, labels, environment
/// conventions) lives with the code that needs it.
enum LlmProvider {
  openAi('openai'),
  openAiCompatible('openai-compatible'),
  anthropic('anthropic'),
  google('google'),
  deepSeek('deepseek');

  const LlmProvider(this.id);

  final String id;

  static LlmProvider? fromId(String? id) {
    for (final provider in values) {
      if (provider.id == id) {
        return provider;
      }
    }
    return null;
  }
}
