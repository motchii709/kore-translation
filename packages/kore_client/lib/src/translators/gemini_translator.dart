import 'package:dio/dio.dart';
import 'package:kore_client/src/translators/dio_translator.dart';

/// [DioTranslator] for the Google AI (Gemini) generateContent API.
final class GeminiTranslator extends DioTranslator {
  GeminiTranslator({required super.config, super.dio});

  @override
  Future<String> requestContent({
    required String systemPrompt,
    required String userText,
  }) async {
    final response = await dio.post<Map<String, dynamic>>(
      '/v1beta/models/$model:generateContent',
      options: Options(
        headers: {'x-goog-api-key': config.apiKey},
      ),
      data: {
        'systemInstruction': {
          'parts': [
            {'text': systemPrompt},
          ],
        },
        'contents': [
          {
            'role': 'user',
            'parts': [
              {'text': userText},
            ],
          },
        ],
        'generationConfig': {'responseMimeType': 'application/json'},
      },
    );
    if (response.data
        case {
          'candidates': [
            {
              'content': {'parts': [{'text': final String text}, ...]},
            },
            ...
          ],
        }
        when text.isNotEmpty) {
      return text;
    }
    throwUnexpectedResponse();
  }
}
