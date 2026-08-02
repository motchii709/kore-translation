import 'dart:io';

import 'package:kore_client/kore_client.dart';

/// Resolves a [TranslatorConfig] from command line options and environment
/// variables.
///
/// Priority: command line option > `KORE_*` variable > provider-conventional
/// variable (`OPENAI_API_KEY`, `ANTHROPIC_API_KEY`, `GEMINI_API_KEY`) >
/// provider default.
TranslatorConfig resolveCliConfig({
  String? providerId,
  String? baseUrl,
  String? apiKey,
  String? model,
  Map<String, String>? environment,
}) {
  final env = environment ?? Platform.environment;
  final rawProviderId = providerId ?? env['KORE_PROVIDER'];
  final provider = rawProviderId == null
      ? LlmProvider.openAi
      : LlmProvider.fromId(rawProviderId) ??
          (throw FormatException(
            '不明なプロバイダです: $rawProviderId '
            '(${LlmProvider.values.map((p) => p.id).join(' / ')})',
          ));
  return TranslatorConfig(
    provider: provider,
    apiKey: apiKey ?? env['KORE_API_KEY'] ?? env[provider.apiKeyEnvName] ?? '',
    baseUrl: baseUrl ?? env['KORE_BASE_URL'] ?? '',
    model: model ?? env['KORE_MODEL'] ?? '',
  );
}
