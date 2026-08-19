import 'package:llm_sdk_http/llm_sdk_http.dart';
import 'package:llm_sdk_anthropic/src/anthropic_stream_models.dart';
import 'package:llm_sdk_anthropic/src/api_error.dart';
import 'package:llm_sdk_anthropic/src/safe_json.dart';
import 'package:llm_sdk_core/llm_sdk_core.dart';
import 'package:sse/sse.dart';

/// Thin wrapper over the Anthropic Messages API.
final class AnthropicLlmClient {
  AnthropicLlmClient({
    required this.apiKey,
    required this.baseUrl,
    required this.model,
    required this.client,
  });

  static const _apiVersion = '2023-06-01';

  final String apiKey;
  final String baseUrl;
  final String model;
  final StreamingHttpClient client;

  /// Streams the events of one message.
  ///
  /// [maxTokens] is mandatory on this API. [thinking] turns thinking on
  /// (adaptive, with the text streamed back) or off.
  Stream<AnthropicStreamEvent> streamMessages({
    required String systemPrompt,
    required String userText,
    required int maxTokens,
    required bool thinking,
  }) async* {
    final response = await client.post(
      '$baseUrl/v1/messages',
      headers: {
        'x-api-key': apiKey,
        'anthropic-version': _apiVersion,
      },
      body: {
        'model': model,
        'max_tokens': maxTokens,
        'stream': true,
        'thinking': thinking ? {'type': 'adaptive', 'display': 'summarized'} : {'type': 'disabled'},
        'system': systemPrompt,
        'messages': [
          {'role': 'user', 'content': userText},
        ],
      },
    );
    await for (final event in sseDataEvents(response.body)) {
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
  }
}
