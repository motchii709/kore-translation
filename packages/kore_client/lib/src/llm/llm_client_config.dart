import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kore_client/src/llm/llm_provider.dart';

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

  const LlmClientConfig._();

  /// Builds the variant matching [provider] — the bridge from persisted
  /// settings (provider id + strings, where empty means "use the default")
  /// to a typed config.
  factory LlmClientConfig.forProvider(
    LlmProvider provider, {
    required String apiKey,
    String baseUrl = '',
    String model = '',
  }) {
    final defaults = switch (provider) {
      LlmProvider.openAi => LlmClientConfig.openAi(apiKey: apiKey),
      LlmProvider.openAiCompatible => LlmClientConfig.openAiCompatible(apiKey: apiKey),
      LlmProvider.anthropic => LlmClientConfig.anthropic(apiKey: apiKey),
      LlmProvider.google => LlmClientConfig.google(apiKey: apiKey),
      LlmProvider.deepSeek => LlmClientConfig.deepSeek(apiKey: apiKey),
    };
    return defaults.copyWith(
      baseUrl: baseUrl.isNotEmpty ? baseUrl : defaults.baseUrl,
      model: model.isNotEmpty ? model : defaults.model,
    );
  }

  LlmProvider get provider => switch (this) {
    OpenAiConfig() => LlmProvider.openAi,
    OpenAiCompatibleConfig() => LlmProvider.openAiCompatible,
    AnthropicConfig() => LlmProvider.anthropic,
    GeminiConfig() => LlmProvider.google,
    DeepSeekConfig() => LlmProvider.deepSeek,
  };
}
