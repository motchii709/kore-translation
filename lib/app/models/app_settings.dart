import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:llm_clients/llm_clients.dart';

part 'app_settings.freezed.dart';

/// User-configurable settings, persisted in secure storage.
///
/// Empty [baseUrl] / [model] mean "use the provider default"; an empty
/// [systemPrompt] means "use the default prompt template".
@freezed
abstract class AppSettings with _$AppSettings {
  const factory AppSettings({
    @Default(LlmProvider.openAi) LlmProvider provider,
    @Default('') String baseUrl,
    @Default('') String apiKey,
    @Default('') String model,
    @Default(true) bool thinking,
    @Default('') String systemPrompt,
  }) = _AppSettings;

  const AppSettings._();

  /// Whether translation can be attempted with these settings.
  ///
  /// OpenAI-compatible endpoints may be local servers without authentication,
  /// so they require an endpoint and model instead of an API key.
  bool get isConfigured => switch (provider) {
    LlmProvider.openAiCompatible => baseUrl.isNotEmpty && model.isNotEmpty,
    _ => apiKey.isNotEmpty,
  };

  LlmClientConfig toLlmClientConfig() => LlmClientConfig.forProvider(
    provider,
    apiKey: apiKey,
    baseUrl: baseUrl,
    model: model,
  );
}
