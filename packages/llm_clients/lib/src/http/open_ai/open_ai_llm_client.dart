import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:llm_clients/src/exceptions.dart';
import 'package:llm_clients/src/http/api_error.dart';
import 'package:llm_clients/src/http/open_ai/open_ai_stream_models.dart';
import 'package:llm_clients/src/http/sse.dart';
import 'package:llm_clients/src/llm_client_config.dart';
import 'package:llm_clients/src/safe_json.dart';

/// Thin wrapper over the OpenAI Chat Completions API
/// (OpenAI, Groq, Ollama, LM Studio, OpenRouter, ...).
final class OpenAiLlmClient {
  OpenAiLlmClient({required this.config, required this.dio});

  final OpenAiConfig config;
  final Dio dio;

  /// Streams the chunks of one chat completion.
  ///
  /// [responseFormat] is passed through as the API's `response_format`
  /// parameter (e.g. `{"type": "json_object"}`); null omits it.
  Stream<OpenAiChatChunk> streamChatCompletions({
    required String systemPrompt,
    required String userText,
    Map<String, Object?>? responseFormat,
  }) async* {
    try {
      final response = await dio.post<ResponseBody>(
        '${config.baseUrl}/chat/completions',
        options: Options(
          responseType: ResponseType.stream,
          headers: {'Authorization': 'Bearer ${config.apiKey}'},
        ),
        data: {
          'model': config.model,
          'stream': true,
          'response_format': ?responseFormat,
          'messages': [
            {'role': 'system', 'content': systemPrompt},
            {'role': 'user', 'content': userText},
          ],
        },
      );
      final body = response.data;
      if (body == null) {
        throw const LlmApiException('Empty API response body');
      }
      await for (final event in sseDataEvents(body.stream)) {
        // Skip non-JSON lines such as "[DONE]".
        final json = tryJsonDecode(event);
        if (json is! Map<String, dynamic>) {
          continue;
        }
        throwIfApiError(json);
        try {
          yield OpenAiChatChunk.fromJson(json);
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
