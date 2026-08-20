import 'package:llm_sdk_http/llm_sdk_http.dart';
import 'package:llm_sdk_core/llm_sdk_core.dart';
import 'package:llm_sdk_openai/src/open_ai_llm_client.dart';
import 'package:llm_sdk_openai/src/open_ai_stream_models.dart';

/// [LlmClient] backed by the OpenAI API.
final class OpenAiClient implements LlmClient {
  OpenAiClient({required this.apiKey, required this.baseUrl, required this.model});

  final String apiKey;
  final String baseUrl;
  final String model;

  @override
  Future<LlmSession> open() async => OpenAiSession(
    apiKey: apiKey,
    baseUrl: baseUrl,
    model: model,
      client: createStreamingHttpClient(),
  );
}

/// The started session; owns [client].
final class OpenAiSession implements LlmSession {
  OpenAiSession({
    required String apiKey,
    required String baseUrl,
    required String model,
    required this.client,
  }) : _llm = OpenAiLlmClient(
          apiKey: apiKey,
          baseUrl: baseUrl,
          model: model,
          client: client,
        );

  /// The HTTP transport the session owns, from [OpenAiClient.open] to [close].
  final StreamingHttpClient client;

  final OpenAiLlmClient _llm;

  @override
  bool get isAlive => true;

  @override
  Future<void> close() async => client.close(); // Graceful: in-flight requests finish.

  // [thinking] is ignored: this client speaks the Chat Completions API,
  // which has no switch for reasoning or for streaming it back.
  @override
  Stream<T> streamObject<T>({
    required String system,
    required String user,
    required bool thinking,
    required T Function(String? thinking, Map<String, dynamic>? reply) decoder,
  }) {
    final chunks = _llm.streamChatCompletions(systemPrompt: system, userText: user, jsonOutput: true);
    return chunks.expand(_eventsOf).decodeSnapshots(decoder);
  }

  Iterable<LlmStreamEvent> _eventsOf(OpenAiChatChunk chunk) sync* {
    final delta = chunk.choices.isEmpty ? null : chunk.choices.first.delta;
    // The first chunk arrives with `content: ""`; drop empty deltas here.
    if (delta?.content case final String text when text.isNotEmpty) {
      yield LlmTextDelta(text);
    }
  }
}
