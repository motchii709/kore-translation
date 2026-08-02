import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kore_client/kore_client.dart';

part 'app_settings.freezed.dart';

/// User-configurable API settings, persisted in secure storage.
///
/// Empty [baseUrl] / [model] mean "use the provider default".
@freezed
abstract class AppSettings with _$AppSettings {
  const factory AppSettings({
    @Default(LlmProvider.openAi) LlmProvider provider,
    @Default('') String baseUrl,
    @Default('') String apiKey,
    @Default('') String model,
  }) = _AppSettings;

  const AppSettings._();

  TranslatorConfig toTranslatorConfig() => TranslatorConfig(
        provider: provider,
        apiKey: apiKey,
        baseUrl: baseUrl,
        model: model,
      );
}
