import 'dart:io';

import 'package:llm_clients/llm_clients.dart';

/// Conventional API key environment variables per backend — a CLI concern,
/// kept out of kore_client.
const Map<LlmProvider, String> apiKeyEnvNames = {
  LlmProvider.openAi: 'OPENAI_API_KEY',
  LlmProvider.anthropic: 'ANTHROPIC_API_KEY',
  LlmProvider.google: 'GEMINI_API_KEY',
  LlmProvider.deepSeek: 'DEEPSEEK_API_KEY',
};

/// Resolves a [LlmClientConfig] from command line options and environment
/// variables.
///
/// Priority: command line option > `KORE_*` variable > provider-conventional
/// variable ([apiKeyEnvNames]) > provider default.
LlmClientConfig resolveCliConfig({
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
              'Unknown provider: $rawProviderId '
              '(${LlmProvider.values.map((p) => p.id).join(' / ')})',
            ));
  return LlmClientConfig.forProvider(
    provider,
    apiKey: apiKey ?? env['KORE_API_KEY'] ?? env[apiKeyEnvNames[provider]] ?? '',
    baseUrl: baseUrl ?? env['KORE_BASE_URL'] ?? '',
    model: model ?? env['KORE_MODEL'] ?? '',
  );
}
