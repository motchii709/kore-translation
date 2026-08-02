import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kore_honyaku/app/constants/translation_prompt.dart';
import 'package:llm_clients/llm_clients.dart';

part 'app_settings.freezed.dart';

/// User-configurable settings, persisted in secure storage.
///
/// [llm] is stored verbatim as the [LlmClientConfig] union's JSON. The
/// settings form materializes real values into its fields (variant defaults
/// included), so what is stored here is what gets used.
@freezed
abstract class AppSettings with _$AppSettings {
  const factory AppSettings({
    @Default(LlmClientConfig.openAi(apiKey: '')) LlmClientConfig llm,
    @Default(true) bool thinking,
    @Default(defaultTranslationPromptTemplate) String systemPrompt,
  }) = _AppSettings;

  const AppSettings._();

  /// Whether translation can be attempted with these settings.
  ///
  /// OpenAI-compatible endpoints may be local servers without authentication,
  /// so they require an endpoint and model instead of an API key. Agent
  /// backends hold their own credentials and only need a launch command.
  bool get isConfigured => switch (llm) {
    OpenAiCompatibleConfig(:final baseUrl, :final model) => baseUrl.isNotEmpty && model.isNotEmpty,
    AcpConfig(:final command) || CodexConfig(:final command) => command.isNotEmpty,
    OpenAiConfig(:final apiKey) ||
    AnthropicConfig(:final apiKey) ||
    GeminiConfig(:final apiKey) ||
    DeepSeekConfig(:final apiKey) => apiKey.isNotEmpty,
  };
}
