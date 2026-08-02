import 'package:dio/dio.dart';
import 'package:kore_client/src/exceptions.dart';
import 'package:kore_client/src/http/api_error_mapper.dart';
import 'package:kore_client/src/models/translation_models.dart';
import 'package:kore_client/src/models/translator_config.dart';
import 'package:kore_client/src/parsing/translation_response_parser.dart';
import 'package:kore_client/src/prompt/translation_prompt_builder.dart';
import 'package:kore_client/src/translator.dart';
import 'package:meta/meta.dart';

/// Base class for HTTP-based [Translator] implementations.
///
/// Subclasses only implement [requestContent]: one provider-specific API call
/// that returns the raw text content. Prompt building, response parsing and
/// error mapping are shared here.
abstract base class DioTranslator implements Translator {
  DioTranslator({required this.config, Dio? dio})
      : dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: config.effectiveBaseUrl,
                connectTimeout: const Duration(seconds: 10),
                receiveTimeout: const Duration(seconds: 120),
              ),
            );

  final TranslatorConfig config;

  @protected
  final Dio dio;

  @protected
  String get model => config.effectiveModel;

  @override
  Future<TranslationResult> translate(TranslationRequest request) async {
    final systemPrompt = TranslationPromptBuilder(request).build();
    final String content;
    try {
      content = await requestContent(
        systemPrompt: systemPrompt,
        userText: request.text,
      );
    } on DioException catch (e) {
      throw mapDioException(e);
    }
    return parseTranslationResponse(content);
  }

  /// Sends one provider-specific request and returns the raw text content
  /// of the model's reply.
  @protected
  Future<String> requestContent({
    required String systemPrompt,
    required String userText,
  });

  @protected
  Never throwUnexpectedResponse() {
    throw const KoreClientException('APIの応答に翻訳結果が含まれていません');
  }
}
