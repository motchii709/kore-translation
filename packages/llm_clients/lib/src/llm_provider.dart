/// Identifiers for the supported LLM backends. Anything beyond identity
/// (defaults, labels, wire ids) lives with the code that needs it — the
/// persisted discriminator values are defined on `LlmClientConfig`.
enum LlmProvider { openAi, openAiCompatible, anthropic, google, deepSeek, acp, codex }
