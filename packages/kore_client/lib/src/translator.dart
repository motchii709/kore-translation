import 'package:dio/dio.dart';
import 'package:kore_client/src/models/llm_provider.dart';
import 'package:kore_client/src/models/translation_models.dart';
import 'package:kore_client/src/models/translator_config.dart';
import 'package:kore_client/src/translators/anthropic_translator.dart';
import 'package:kore_client/src/translators/gemini_translator.dart';
import 'package:kore_client/src/translators/open_ai_translator.dart';

/// A translation backend. UIs (Flutter app, CLI, TUI, ...) depend only on
/// this interface; the concrete LLM backend is chosen via [TranslatorConfig].
abstract interface class Translator {
  factory Translator.fromConfig(TranslatorConfig config, {Dio? dio}) {
    return switch (config.provider) {
      LlmProvider.openAi => OpenAiTranslator(config: config, dio: dio),
      LlmProvider.anthropic => AnthropicTranslator(config: config, dio: dio),
      LlmProvider.google => GeminiTranslator(config: config, dio: dio),
    };
  }

  Future<TranslationResult> translate(TranslationRequest request);
}
