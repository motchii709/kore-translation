import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:llm_clients/src/llm_provider.dart';

part 'llm_client_config.freezed.dart';

/// Connection settings for an LLM backend, one variant per client type.
///
/// Variants carry real default values; clients read `baseUrl` and `model`
/// as-is. How partial settings are persisted (e.g. "empty string means
/// default") is a concern of the persistence boundary — see
/// `LlmClientConfig.forProvider`.
@freezed
sealed class LlmClientConfig with _$LlmClientConfig {
  const factory LlmClientConfig.openAi({
    required String apiKey,
    @Default('https://api.openai.com/v1') String baseUrl,
    @Default('gpt-5-mini') String model,
  }) = OpenAiConfig;

  /// Generic OpenAI-compatible endpoint (Ollama, LM Studio, Groq,
  /// OpenRouter, vLLM, ...). No sensible universal defaults exist, so
  /// [baseUrl] and [model] have none; [apiKey] may stay empty for local
  /// servers that do not authenticate.
  const factory LlmClientConfig.openAiCompatible({
    @Default('') String apiKey,
    @Default('') String baseUrl,
    @Default('') String model,
  }) = OpenAiCompatibleConfig;

  const factory LlmClientConfig.anthropic({
    required String apiKey,
    @Default('https://api.anthropic.com') String baseUrl,
    @Default('claude-sonnet-5') String model,
  }) = AnthropicConfig;

  const factory LlmClientConfig.google({
    required String apiKey,
    @Default('https://generativelanguage.googleapis.com') String baseUrl,
    @Default('gemini-2.5-flash') String model,
  }) = GeminiConfig;

  const factory LlmClientConfig.deepSeek({
    required String apiKey,
    @Default('https://api.deepseek.com') String baseUrl,
    @Default('deepseek-chat') String model,
  }) = DeepSeekConfig;

  /// An Agent Client Protocol agent (https://agentclientprotocol.com) such
  /// as Claude Code or Gemini CLI. [command] is the command line that starts
  /// the agent on stdio; no universal default exists. Credentials and model
  /// belong to the agent itself.
  const factory LlmClientConfig.acp({
    @Default('') String command,
  }) = AcpConfig;

  /// The Codex app-server (Codex's own stdio JSON-RPC protocol, spoken by
  /// the official IDE extensions). Credentials come from `codex login`;
  /// an empty [model] uses the Codex configuration's default.
  const factory LlmClientConfig.codex({
    @Default('codex app-server') String command,
    @Default('') String model,
  }) = CodexConfig;

  const LlmClientConfig._();

  /// Builds the variant matching [provider] — the bridge from persisted
  /// settings (provider id + strings, where empty means "use the default")
  /// to a typed config.
  factory LlmClientConfig.forProvider(
    LlmProvider provider, {
    String apiKey = '',
    String baseUrl = '',
    String model = '',
    String command = '',
  }) {
    final defaults = switch (provider) {
      LlmProvider.openAi => LlmClientConfig.openAi(apiKey: apiKey),
      LlmProvider.openAiCompatible => LlmClientConfig.openAiCompatible(apiKey: apiKey),
      LlmProvider.anthropic => LlmClientConfig.anthropic(apiKey: apiKey),
      LlmProvider.google => LlmClientConfig.google(apiKey: apiKey),
      LlmProvider.deepSeek => LlmClientConfig.deepSeek(apiKey: apiKey),
      LlmProvider.acp => LlmClientConfig.acp(command: command),
      LlmProvider.codex => const LlmClientConfig.codex(),
    };
    // The agent variants share no endpoint fields with the API variants, so
    // the "empty means default" merge is spelled out per variant.
    return switch (defaults) {
      final AcpConfig config => config,
      final CodexConfig config => config.copyWith(
        command: _nonEmpty(command, config.command),
        model: _nonEmpty(model, config.model),
      ),
      final OpenAiConfig config => config.copyWith(
        baseUrl: _nonEmpty(baseUrl, config.baseUrl),
        model: _nonEmpty(model, config.model),
      ),
      final OpenAiCompatibleConfig config => config.copyWith(
        baseUrl: _nonEmpty(baseUrl, config.baseUrl),
        model: _nonEmpty(model, config.model),
      ),
      final AnthropicConfig config => config.copyWith(
        baseUrl: _nonEmpty(baseUrl, config.baseUrl),
        model: _nonEmpty(model, config.model),
      ),
      final GeminiConfig config => config.copyWith(
        baseUrl: _nonEmpty(baseUrl, config.baseUrl),
        model: _nonEmpty(model, config.model),
      ),
      final DeepSeekConfig config => config.copyWith(
        baseUrl: _nonEmpty(baseUrl, config.baseUrl),
        model: _nonEmpty(model, config.model),
      ),
    };
  }

  static String _nonEmpty(String value, String fallback) => value.isNotEmpty ? value : fallback;

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
