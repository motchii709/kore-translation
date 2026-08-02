import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kore_client/src/models/llm_provider.dart';

part 'translator_config.freezed.dart';

/// Connection settings for a [LlmProvider] backend.
///
/// [baseUrl] and [model] fall back to the provider defaults when empty, so
/// callers can persist only what the user explicitly overrides.
@freezed
abstract class TranslatorConfig with _$TranslatorConfig {
  const factory TranslatorConfig({
    required LlmProvider provider,
    required String apiKey,
    @Default('') String baseUrl,
    @Default('') String model,
  }) = _TranslatorConfig;

  const TranslatorConfig._();

  String get effectiveBaseUrl =>
      baseUrl.isNotEmpty ? baseUrl : provider.defaultBaseUrl;

  String get effectiveModel => model.isNotEmpty ? model : provider.defaultModel;
}
