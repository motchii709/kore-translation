import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kore_client/src/exceptions.dart';
import 'package:kore_client/src/llm/http/api_error.dart';
import 'package:kore_client/src/llm/http/gemini/gemini_stream_models.dart';
import 'package:kore_client/src/llm/http/sse.dart';
import 'package:kore_client/src/llm/llm_client_config.dart';
import 'package:kore_client/src/safe_json.dart';

/// Thin wrapper over the Google AI (Gemini) generateContent API.
final class GeminiLlmClient {
  GeminiLlmClient({required this.config, required this.dio});

  final GeminiConfig config;
  final Dio dio;

  /// Streams the chunks of one generateContent call.
  ///
  /// [thinkingConfig] is passed through as `generationConfig.thinkingConfig`
  /// (e.g. `{"includeThoughts": true}`); null omits it.
  Stream<GeminiStreamChunk> streamGenerateContent({
    required String systemPrompt,
    required String userText,
    Map<String, Object?>? thinkingConfig,
  }) async* {
    try {
      final response = await dio.post<ResponseBody>(
        '${config.baseUrl}/v1beta/models/${config.model}:streamGenerateContent',
        queryParameters: {'alt': 'sse'},
        options: Options(
          responseType: ResponseType.stream,
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
          'generationConfig': {
            'responseMimeType': 'application/json',
            'thinkingConfig': ?thinkingConfig,
          },
        },
      );
      final body = response.data;
      if (body == null) {
        throw const KoreClientException('Empty API response body');
      }
      await for (final event in sseDataEvents(body.stream)) {
        final json = tryJsonDecode(event);
        if (json is! Map<String, dynamic>) {
          continue;
        }
        throwIfApiError(json);
        try {
          yield GeminiStreamChunk.fromJson(json);
        } on CheckedFromJsonException {
          continue; // Skip events outside the chunk schema.
        }
      }
    } on DioException catch (e) {
      // Materialize streamed error bodies so the raw exception is debuggable.
      if (e.response case final response?) {
        if (response.data case final ResponseBody body) {
          response.data = await utf8.decodeStream(body.stream);
        }
      }
      rethrow;
    }
  }
}
