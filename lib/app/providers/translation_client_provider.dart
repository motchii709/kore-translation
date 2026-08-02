import 'package:dio/dio.dart';
import 'package:kore_client/kore_client.dart';
import 'package:kore_honyaku/app/providers/app_settings_provider.dart';
import 'package:llm_clients/llm_clients.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'translation_client_provider.g.dart';

/// The translation backend. Kept alive so the agent backends (ACP / Codex)
/// hold one subprocess across translations instead of losing it to auto
/// dispose mid-stream; a settings change rebuilds this provider, which
/// disposes the previous agent.
@Riverpod(keepAlive: true)
Future<TranslationClient> translationClient(Ref ref) async {
  final settings = await ref.watch(appSettingsStorageProvider.future);
  Dio dio() => Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 120),
    ),
  );
  // The agent subprocess lives as long as this provider. The provider may
  // be rebuilt (e.g. by a settings change) while the agent is still
  // starting; that stale build must kill its own process and bail out.
  Future<StdioAgentProcess> startAgent(String command) async {
    final agent = await StdioAgentProcess.start(command);
    if (!ref.mounted) {
      agent.kill();
      throw Exception('translationClient was rebuilt while its agent was starting');
    }
    ref.onDispose(agent.kill);
    return agent;
  }

  switch (settings.llm) {
    case final OpenAiConfig config:
      return OpenAiTranslationClient(
        llm: OpenAiLlmClient(config: config, dio: dio()),
      );
    case final OpenAiCompatibleConfig config:
      return OpenAiCompatibleTranslationClient(
        llm: OpenAiCompatibleLlmClient(config: config, dio: dio()),
      );
    case final AnthropicConfig config:
      return AnthropicTranslationClient(
        llm: AnthropicLlmClient(config: config, dio: dio()),
      );
    case final GeminiConfig config:
      return GeminiTranslationClient(
        llm: GeminiLlmClient(config: config, dio: dio()),
      );
    case final DeepSeekConfig config:
      return DeepSeekTranslationClient(
        llm: DeepSeekLlmClient(config: config, dio: dio()),
      );
    case final AcpConfig config:
      final agent = await startAgent(config.command);
      return AcpTranslationClient(llm: AcpLlmClient(channel: agent.channel));
    case final CodexConfig config:
      final server = await startAgent(config.command);
      return CodexTranslationClient(
        llm: CodexLlmClient(config: config, channel: server.channel),
      );
  }
}
