import 'package:llm_clients/llm_clients.dart';

/// Resolves a [LlmClientConfig] from command line options and the config
/// file.
///
/// Priority: command line option > [fileConfig] (keyed by option name, see
/// `loadCliConfigFile`) > provider default.
LlmClientConfig resolveCliConfig({
  String? providerId,
  String? baseUrl,
  String? apiKey,
  String? model,
  String? acpCommand,
  String? codexCommand,
  Map<String, String> fileConfig = const {},
}) {
  final rawProviderId = providerId ?? fileConfig['provider'];
  final provider = rawProviderId == null
      ? LlmProvider.openAi
      : LlmProvider.fromId(rawProviderId) ??
            (throw FormatException(
              'Unknown provider: $rawProviderId '
              '(${LlmProvider.values.map((p) => p.id).join(' / ')})',
            ));
  return LlmClientConfig.forProvider(
    provider,
    apiKey: apiKey ?? fileConfig['api-key'] ?? '',
    baseUrl: baseUrl ?? fileConfig['base-url'] ?? '',
    model: model ?? fileConfig['model'] ?? '',
    command: switch (provider) {
      LlmProvider.acp => acpCommand ?? fileConfig['acp-command'] ?? '',
      LlmProvider.codex => codexCommand ?? fileConfig['codex-command'] ?? '',
      _ => '',
    },
  );
}
