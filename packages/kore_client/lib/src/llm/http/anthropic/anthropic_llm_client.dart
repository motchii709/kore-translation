import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kore_client/src/exceptions.dart';
import 'package:kore_client/src/llm/http/anthropic/anthropic_stream_models.dart';
import 'package:kore_client/src/llm/http/api_error.dart';
import 'package:kore_client/src/llm/http/sse.dart';
import 'package:kore_client/src/llm/llm_client_config.dart';
import 'package:kore_client/src/safe_json.dart';

/// Thin wrapper over the Anthropic Messages API.
final class AnthropicLlmClient {
  AnthropicLlmClient({required this.config, required this.dio});

  static const _apiVersion = '2023-06-01';
  // Thinking tokens count toward max_tokens, so leave generous headroom.
  static const _maxTokens = 16384;

  final AnthropicConfig config;
  final Dio dio;

  /// Streams the events of one message.
  ///
  /// [thinking] is passed through as the API's `thinking` parameter
  /// (e.g. `{"type": "adaptive", "display": "summarized"}`); null omits it.
  Stream<AnthropicStreamEvent> streamMessages({
    required String systemPrompt,
    required String userText,
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
          'max_tokens': _maxTokens,
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
        throw const KoreClientException('Empty API response body');
      }
      await for (final event in sseDataEvents(body.stream)) {
        final json = tryJsonDecode(event);
        if (json is! Map<String, dynamic>) {
          continue;
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
