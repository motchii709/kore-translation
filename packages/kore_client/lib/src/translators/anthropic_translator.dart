import 'package:dio/dio.dart';
import 'package:kore_client/src/translators/dio_translator.dart';

/// [DioTranslator] for the Anthropic Messages API.
final class AnthropicTranslator extends DioTranslator {
  AnthropicTranslator({required super.config, super.dio});

  static const _apiVersion = '2023-06-01';
  static const _maxTokens = 4096;

  @override
  Future<String> requestContent({
    required String systemPrompt,
    required String userText,
  }) async {
    final response = await dio.post<Map<String, dynamic>>(
      '/v1/messages',
      options: Options(
        headers: {
          'x-api-key': config.apiKey,
          'anthropic-version': _apiVersion,
        },
      ),
      data: {
        'model': model,
        'max_tokens': _maxTokens,
        'system': systemPrompt,
        'messages': [
          {'role': 'user', 'content': userText},
        ],
      },
    );
    if (response.data case {'content': [{'text': final String text}, ...]}
        when text.isNotEmpty) {
      return text;
    }
    throwUnexpectedResponse();
  }
}
