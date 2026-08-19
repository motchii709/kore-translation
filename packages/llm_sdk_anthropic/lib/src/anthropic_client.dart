import 'package:llm_sdk_http/llm_sdk_http.dart';
import 'package:llm_sdk_anthropic/src/anthropic_llm_client.dart';
import 'package:llm_sdk_anthropic/src/anthropic_stream_models.dart';
import 'package:llm_sdk_core/llm_sdk_core.dart';

/// [LlmClient] backed by the Anthropic Messages API.
final class AnthropicClient implements LlmClient {
  AnthropicClient({required this.apiKey, required this.baseUrl, required this.model});

  final String apiKey;
  final String baseUrl;
  final String model;

  @override
  Future<LlmSession> open() async => AnthropicSession(
        apiKey: apiKey,
        baseUrl: baseUrl,
        model: model,
        client: createStreamingHttpClient(),
      );
}

/// The started session; owns [client].
final class AnthropicSession implements LlmSession {
  AnthropicSession({
    required String apiKey,
    required String baseUrl,
    required String model,
    required this.client,
  }) : _llm = AnthropicLlmClient(
          apiKey: apiKey,
          baseUrl: baseUrl,
          model: model,
          client: client,
        );

  /// The HTTP transport the session owns, from [AnthropicClient.open] to [close].
  final StreamingHttpClient client;

  final AnthropicLlmClient _llm;

  @override
  bool get isAlive => true;

  @override
  Future<void> close() async => client.close(); // Graceful: in-flight requests finish.

  // The Messages API has no response-format parameter, so the JSON-only
  // reply rests on the prompt.
  @override
  Stream<T> streamObject<T>({
    required String system,
    required String user,
    required bool thinking,
    required T Function(String? thinking, Map<String, dynamic>? reply) decoder,
  }) {
    final events = _llm.streamMessages(
      systemPrompt: system,
      userText: user,
      maxTokens: 16384,
      thinking: thinking,
    );
    return events.expand(_eventsOf).decodeSnapshots(decoder);
  }

  Iterable<LlmStreamEvent> _eventsOf(AnthropicStreamEvent event) sync* {
    switch (event) {
      case AnthropicContentBlockDeltaEvent(delta: AnthropicTextDelta(:final text)):
        yield LlmTextDelta(text);
      case AnthropicContentBlockDeltaEvent(delta: AnthropicThinkingDelta(:final thinking)):
        yield LlmThinkingDelta(thinking);
      default:
        break;
    }
  }
}
