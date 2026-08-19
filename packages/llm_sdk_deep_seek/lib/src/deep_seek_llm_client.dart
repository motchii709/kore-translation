import 'dart:convert';

import 'package:llm_sdk_http/llm_sdk_http.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:llm_sdk_core/llm_sdk_core.dart';
import 'package:llm_sdk_deep_seek/src/api_error.dart';
import 'package:llm_sdk_deep_seek/src/deep_seek_stream_models.dart';
import 'package:llm_sdk_deep_seek/src/safe_json.dart';
import 'package:sse/sse.dart';

/// Thin wrapper over the DeepSeek Chat Completions API.
final class DeepSeekLlmClient {
  DeepSeekLlmClient({
    required this.apiKey,
    required this.baseUrl,
    required this.model,
    required this.client,
  });

  final String apiKey;
  final String baseUrl;
  final String model;
  final StreamingHttpClient client;

  /// Streams the chunks of one chat completion.
  ///
  /// [responseFormat] is passed through as the API's `response_format`
  /// parameter; null omits it (deepseek-reasoner rejects the parameter).
  Stream<DeepSeekChatChunk> streamChatCompletions({
    required String systemPrompt,
    required String userText,
    Map<String, Object?>? responseFormat,
  }) async* {
    final response = await client.post(
      '$baseUrl/chat/completions',
      headers: {'Authorization': 'Bearer $apiKey'},
      body: {
        'model': model,
        'stream': true,
        'response_format': responseFormat,
        'messages': [
          {'role': 'system', 'content': systemPrompt},
          {'role': 'user', 'content': userText},
        ],
      },
    );
    await for (final event in sseDataEvents(response.body)) {
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
  }
}
