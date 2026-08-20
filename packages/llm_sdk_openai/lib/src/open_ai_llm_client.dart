import 'dart:convert';

import 'package:llm_sdk_http/llm_sdk_http.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:llm_sdk_core/llm_sdk_core.dart';
import 'package:llm_sdk_openai/src/api_error.dart';
import 'package:llm_sdk_openai/src/open_ai_stream_models.dart';
import 'package:llm_sdk_openai/src/safe_json.dart';
import 'package:sse/sse.dart';

/// Thin wrapper over the OpenAI Chat Completions API.
final class OpenAiLlmClient {
  OpenAiLlmClient({
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
  /// [jsonOutput] requests a JSON-only reply via the API's `response_format`
  /// parameter; false omits it.
  Stream<OpenAiChatChunk> streamChatCompletions({
    required String systemPrompt,
    required String userText,
    required bool jsonOutput,
  }) async* {
    final response = await client.post(
      '$baseUrl/chat/completions',
      headers: {'Authorization': 'Bearer $apiKey'},
      body: {
        'model': model,
        'stream': true,
        if (jsonOutput) 'response_format': {'type': 'json_object'},
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
        yield OpenAiChatChunk.fromJson(json);
      } on CheckedFromJsonException {
        continue; // Skip events outside the chunk schema.
      }
    }
  }
}
