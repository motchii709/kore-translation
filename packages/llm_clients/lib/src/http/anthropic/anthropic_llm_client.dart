import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:llm_clients/src/exceptions.dart';
import 'package:llm_clients/src/http/anthropic/anthropic_stream_models.dart';
import 'package:llm_clients/src/http/api_error.dart';
import 'package:llm_clients/src/http/sse.dart';
import 'package:llm_clients/src/llm_client_config.dart';
import 'package:llm_clients/src/safe_json.dart';

/// Thin wrapper over the Anthropic Messages API.
final class AnthropicLlmClient {
  AnthropicLlmClient({required this.config, required this.dio});

  static const _apiVersion = '2023-06-01';

  final AnthropicConfig config;
  final Dio dio;

  /// Streams the events of one message.
  ///
  /// [maxTokens] is mandatory on this API. [thinking] is passed through as
  /// the API's `thinking` parameter (e.g. `{"type": "adaptive", "display":
  /// "summarized"}`); null omits it.
  Stream<AnthropicStreamEvent> streamMessages({
    required String systemPrompt,
    required String userText,
    required int maxTokens,
    Map<String, Object?>? thinking,
  }) async* {
    try {
      final response = await dio.post<ResponseBody>(
        '${config.baseUrl}/v1/messages',
        options: Options(
          responseType: ResponseType.stream,
          headers: {
            'x-api-key': config.apiKey,
            'anthropic-version': _apiVersion,
          },
        ),
        data: {
          'model': config.model,
          'max_tokens': maxTokens,
          'stream': true,
          'thinking': ?thinking,
          'system': systemPrompt,
          'messages': [
            {'role': 'user', 'content': userText},
          ],
        },
      );
      final body = response.data;
      if (body == null) {
        throw const LlmApiException('Empty API response body');
      }
      await for (final event in sseDataEvents(body.stream)) {
        final json = tryJsonDecode(event);
        if (json is! Map<String, dynamic>) {
          continue; // Skip non-JSON lines (this API is not expected to send any).
        }
        throwIfApiError(json);
        try {
          yield AnthropicStreamEvent.fromJson(json);
        } on CheckedFromJsonException {
          continue; // Skip events outside the schema.
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
