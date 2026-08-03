import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:llm_sdk_core/llm_sdk_core.dart';
import 'package:llm_sdk_openai_compatible/src/api_error.dart';
import 'package:llm_sdk_openai_compatible/src/open_ai_compatible_stream_models.dart';
import 'package:llm_sdk_openai_compatible/src/safe_json.dart';
import 'package:sse/sse.dart';

/// Thin wrapper over generic OpenAI-compatible Chat Completions endpoints
/// (Ollama, LM Studio, Groq, OpenRouter, vLLM, ...).
///
/// Speaks the conservative baseline of the wire format: standard chunks and
/// optional authentication.
final class OpenAiCompatibleLlmClient {
  OpenAiCompatibleLlmClient({required this.apiKey, required this.baseUrl, required this.model, required this.dio});

  final String apiKey;
  final String baseUrl;
  final String model;
  final Dio dio;

  /// Streams the chunks of one chat completion.
  ///
  /// [responseFormat] is passed through as the API's `response_format`
  /// parameter (e.g. `{"type": "json_object"}`); null omits it.
  Stream<OpenAiCompatibleChatChunk> streamChatCompletions({
    required String systemPrompt,
    required String userText,
    Map<String, Object?>? responseFormat,
  }) async* {
    try {
      final response = await dio.post<ResponseBody>(
        '$baseUrl/chat/completions',
        options: Options(
          responseType: ResponseType.stream,
          headers: {
            // Local servers (Ollama, LM Studio) run without authentication.
            if (apiKey.isNotEmpty) 'Authorization': 'Bearer $apiKey',
          },
        ),
        data: {
          'model': model,
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
          yield OpenAiCompatibleChatChunk.fromJson(json);
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
