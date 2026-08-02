import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kore_client/src/exceptions.dart';
import 'package:kore_client/src/llm/http/api_error.dart';
import 'package:kore_client/src/llm/http/deep_seek/deep_seek_stream_models.dart';
import 'package:kore_client/src/llm/http/sse.dart';
import 'package:kore_client/src/llm/llm_client_config.dart';
import 'package:kore_client/src/safe_json.dart';

/// Thin wrapper over the DeepSeek Chat Completions API.
final class DeepSeekLlmClient {
  DeepSeekLlmClient({required this.config, required this.dio});

  final DeepSeekConfig config;
  final Dio dio;

  /// Streams the chunks of one chat completion.
  Stream<DeepSeekChatChunk> streamChatCompletions({
    required String systemPrompt,
    required String userText,
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
          // No response_format: deepseek-reasoner rejects it; the prompt and
          // the fence-tolerant parser keep the output usable.
          'messages': [
            {'role': 'system', 'content': systemPrompt},
            {'role': 'user', 'content': userText},
          ],
        },
      );
      final body = response.data;
      if (body == null) {
        throw const KoreClientException('Empty API response body');
      }
      await for (final event in sseDataEvents(body.stream)) {
        // Skip non-JSON lines such as "[DONE]".
        final json = tryJsonDecode(event);
        if (json is! Map<String, dynamic>) {
          continue;
        }
        throwIfApiError(json);
        try {
          yield DeepSeekChatChunk.fromJson(json);
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
