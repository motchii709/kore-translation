import 'package:dio/dio.dart';
import 'package:kore_client/kore_client.dart';
import 'package:kore_honyaku/app/providers/app_settings_provider.dart';
import 'package:llm_clients/llm_clients.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'translation_client_provider.g.dart';

@riverpod
Future<TranslationClient> translationClient(Ref ref) async {
  final settings = await ref.watch(appSettingsStorageProvider.future);
  final dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 120),
    ),
  );
  return switch (settings.toLlmClientConfig()) {
    final OpenAiConfig config => OpenAiTranslationClient(
      llm: OpenAiLlmClient(config: config, dio: dio),
    ),
    final OpenAiCompatibleConfig config => OpenAiCompatibleTranslationClient(
      llm: OpenAiCompatibleLlmClient(config: config, dio: dio),
    ),
    final AnthropicConfig config => AnthropicTranslationClient(
      llm: AnthropicLlmClient(config: config, dio: dio),
    ),
    final GeminiConfig config => GeminiTranslationClient(
      llm: GeminiLlmClient(config: config, dio: dio),
    ),
    final DeepSeekConfig config => DeepSeekTranslationClient(
      llm: DeepSeekLlmClient(config: config, dio: dio),
    ),
  };
}
