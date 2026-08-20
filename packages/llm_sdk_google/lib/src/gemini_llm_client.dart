import 'dart:convert';

import 'package:llm_sdk_http/llm_sdk_http.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:llm_sdk_core/llm_sdk_core.dart';
import 'package:llm_sdk_google/src/api_error.dart';
import 'package:llm_sdk_google/src/gemini_stream_models.dart';
import 'package:llm_sdk_google/src/safe_json.dart';
import 'package:sse/sse.dart';

/// Thin wrapper over the Google AI (Gemini) generateContent API.
final class GeminiLlmClient {
  GeminiLlmClient({
    required this.apiKey,
    required this.baseUrl,
    required this.model,
    required this.client,
  });

  final String apiKey;
  final String baseUrl;
  final String model;
  final StreamingHttpClient client;

  /// Streams the chunks of one generateContent call.
  ///
  /// [responseMimeType] is passed through inside `generationConfig` (e.g.
  /// "application/json"); null omits it. [thinking] requests the model's
  /// thoughts in the response.
  Stream<GeminiStreamChunk> streamGenerateContent({
    required String systemPrompt,
    required String userText,
    required bool thinking,
    String? responseMimeType,
  }) async* {
    final response = await client.post(
      '$baseUrl/v1beta/models/$model:streamGenerateContent',
      queryParameters: {'alt': 'sse'},
      headers: {'x-goog-api-key': apiKey},
      body: {
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
          'responseMimeType': responseMimeType,
          if (thinking) 'thinkingConfig': {'includeThoughts': true},
        },
      },
    );
    await for (final event in sseDataEvents(response.body)) {
      final json = tryJsonDecode(event);
      if (json is! Map<String, dynamic>) {
        continue; // Skip non-JSON lines (this API is not expected to send any).
      }
      throwIfApiError(json);
      try {
        yield GeminiStreamChunk.fromJson(json);
      } on CheckedFromJsonException {
        continue; // Skip events outside the chunk schema.
      }
    }
  }
}
