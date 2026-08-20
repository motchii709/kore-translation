import 'dart:convert';

import 'package:llm_sdk_http/llm_sdk_http.dart';
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
  OpenAiCompatibleLlmClient({
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
  Stream<OpenAiCompatibleChatChunk> streamChatCompletions({
    required String systemPrompt,
    required String userText,
    required bool jsonOutput,
  }) async* {
    final response = await client.post(
      '$baseUrl/chat/completions',
      headers: {
        if (apiKey.isNotEmpty) 'Authorization': 'Bearer $apiKey',
      },
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
        yield OpenAiCompatibleChatChunk.fromJson(json);
      } on CheckedFromJsonException {
        continue; // Skip events outside the chunk schema.
      }
    }
  }
}
