import 'package:dio/dio.dart';
import 'package:kore_client/src/translators/dio_translator.dart';

/// [DioTranslator] for OpenAI-compatible Chat Completions APIs
/// (OpenAI, Groq, Ollama, LM Studio, OpenRouter, ...).
final class OpenAiTranslator extends DioTranslator {
  OpenAiTranslator({required super.config, super.dio});

  @override
  Future<String> requestContent({
    required String systemPrompt,
    required String userText,
  }) async {
    final response = await dio.post<Map<String, dynamic>>(
      '/chat/completions',
      options: Options(
        headers: {'Authorization': 'Bearer ${config.apiKey}'},
      ),
      data: {
        'model': model,
        'response_format': {'type': 'json_object'},
        'messages': [
          {'role': 'system', 'content': systemPrompt},
          {'role': 'user', 'content': userText},
        ],
      },
    );
    if (response.data
        case {'choices': [{'message': {'content': final String content}}, ...]}
        when content.isNotEmpty) {
      return content;
    }
    throwUnexpectedResponse();
  }
}
