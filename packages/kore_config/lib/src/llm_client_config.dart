import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kore_config/src/llm_provider.dart';

part 'llm_client_config.freezed.dart';
part 'llm_client_config.g.dart';

/// Connection settings for an LLM backend, one variant per client type.
///
/// Variants carry real default values and the composition root reads every
/// field as-is. The union is also the persistence schema: frontends store
/// and load it verbatim (`toJson` / `fromJson`, discriminated by `provider`
/// and with snake_case field keys).
///
/// A variant only carries fields its backend can actually honor — e.g.
/// [AnthropicConfig.thinking] toggles reasoning, while `OpenAiConfig` and
/// `AcpConfig` have no such field because their backends cannot control it.
/// [systemPrompt] (the user's prompt template) is on every variant today;
/// a future managed backend that owns its prompt would simply omit it.
@Freezed(unionKey: 'provider')
sealed class LlmClientConfig with _$LlmClientConfig {
  @FreezedUnionValue('openai')
  const factory LlmClientConfig.openAi({
    @JsonKey(name: 'api_key') required String apiKey,
    @JsonKey(name: 'base_url') @Default('https://api.openai.com/v1') String baseUrl,
    @Default('gpt-5-mini') String model,
    @JsonKey(name: 'system_prompt') @Default('') String systemPrompt,
  }) = OpenAiConfig;

  /// Generic OpenAI-compatible endpoint (Ollama, LM Studio, Groq,
  /// OpenRouter, vLLM, ...). No sensible universal defaults exist, so
  /// [baseUrl] and [model] have none; [apiKey] may stay empty for local
  /// servers that do not authenticate.
  @FreezedUnionValue('openai-compatible')
  const factory LlmClientConfig.openAiCompatible({
    @JsonKey(name: 'api_key') @Default('') String apiKey,
    @JsonKey(name: 'base_url') @Default('') String baseUrl,
    @Default('') String model,
    @JsonKey(name: 'system_prompt') @Default('') String systemPrompt,
  }) = OpenAiCompatibleConfig;

  @FreezedUnionValue('anthropic')
  const factory LlmClientConfig.anthropic({
    @JsonKey(name: 'api_key') required String apiKey,
    @JsonKey(name: 'base_url') @Default('https://api.anthropic.com') String baseUrl,
    @Default('claude-sonnet-5') String model,

    /// Whether to request thinking and stream it back.
    @Default(true) bool thinking,
    @JsonKey(name: 'system_prompt') @Default('') String systemPrompt,
  }) = AnthropicConfig;

  @FreezedUnionValue('google')
  const factory LlmClientConfig.google({
    @JsonKey(name: 'api_key') required String apiKey,
    @JsonKey(name: 'base_url') @Default('https://generativelanguage.googleapis.com') String baseUrl,
    @Default('gemini-2.5-flash') String model,

    /// Whether to request the model's thoughts in the response.
    @Default(true) bool thinking,
    @JsonKey(name: 'system_prompt') @Default('') String systemPrompt,
  }) = GeminiConfig;

  @FreezedUnionValue('deepseek')
  const factory LlmClientConfig.deepSeek({
    @JsonKey(name: 'api_key') required String apiKey,
    @JsonKey(name: 'base_url') @Default('https://api.deepseek.com') String baseUrl,
    @Default('deepseek-chat') String model,

    /// Whether to surface `reasoning_content` (reasoning models only; the
    /// API has no request parameter, so this filters the response stream).
    @Default(true) bool thinking,
    @JsonKey(name: 'system_prompt') @Default('') String systemPrompt,
  }) = DeepSeekConfig;

  /// An Agent Client Protocol agent (https://agentclientprotocol.com) such
  /// as Claude Code or Gemini CLI. [command] is the command line that starts
  /// the agent on stdio; no universal default exists. Credentials and model
  /// belong to the agent itself.
  @FreezedUnionValue('acp')
  const factory LlmClientConfig.acp({
    @Default('') String command,
    @JsonKey(name: 'system_prompt') @Default('') String systemPrompt,
  }) = AcpConfig;

  /// The Codex app-server (Codex's own stdio JSON-RPC protocol, spoken by
  /// the official IDE extensions). Credentials come from `codex login`;
  /// an empty [model] uses the Codex configuration's default.
  @FreezedUnionValue('codex')
  const factory LlmClientConfig.codex({
    @Default('codex app-server') String command,
    @Default('') String model,

    /// Whether to stream reasoning summaries back (Codex models always
    /// reason; this only controls whether the reasoning is shown).
    @Default(true) bool thinking,
    @JsonKey(name: 'system_prompt') @Default('') String systemPrompt,
  }) = CodexConfig;

  const LlmClientConfig._();

  factory LlmClientConfig.fromJson(Map<String, dynamic> json) => _$LlmClientConfigFromJson(json);

  LlmProvider get provider => switch (this) {
    OpenAiConfig() => LlmProvider.openAi,
    OpenAiCompatibleConfig() => LlmProvider.openAiCompatible,
    AnthropicConfig() => LlmProvider.anthropic,
    GeminiConfig() => LlmProvider.google,
    DeepSeekConfig() => LlmProvider.deepSeek,
    AcpConfig() => LlmProvider.acp,
    CodexConfig() => LlmProvider.codex,
  };
}
