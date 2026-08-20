import 'package:llm_sdk_http/llm_sdk_http.dart';
import 'package:llm_sdk_core/llm_sdk_core.dart';
import 'package:llm_sdk_openai_compatible/src/open_ai_compatible_llm_client.dart';
import 'package:llm_sdk_openai_compatible/src/open_ai_compatible_stream_models.dart';

/// [LlmClient] backed by a generic OpenAI-compatible endpoint.
final class OpenAiCompatibleClient implements LlmClient {
  OpenAiCompatibleClient({required this.baseUrl, required this.model, this.apiKey = ''});

  final String apiKey;
  final String baseUrl;
  final String model;

  @override
  Future<LlmSession> open() async => OpenAiCompatibleSession(
        apiKey: apiKey,
        baseUrl: baseUrl,
        model: model,
        client: createStreamingHttpClient(),
      );
}

/// The started session; owns [client].
final class OpenAiCompatibleSession implements LlmSession {
  OpenAiCompatibleSession({
    required String apiKey,
    required String baseUrl,
    required String model,
    required this.client,
  }) : _llm = OpenAiCompatibleLlmClient(
          apiKey: apiKey,
          baseUrl: baseUrl,
          model: model,
          client: client,
        );

  /// The HTTP transport the session owns, from [OpenAiCompatibleClient.open] to [close].
  final StreamingHttpClient client;

  final OpenAiCompatibleLlmClient _llm;

  @override
  bool get isAlive => true;

  @override
  Future<void> close() async => client.close();

  // [thinking] is ignored: the Chat Completions surface has no portable
  // switch for reasoning or for streaming it back.
  @override
  Stream<T> streamObject<T>({
    required String system,
    required String user,
    required bool thinking,
    required T Function(String? thinking, Map<String, dynamic>? reply) decoder,
  }) {
    final chunks = _llm.streamChatCompletions(
      systemPrompt: system,
      userText: user,
      jsonOutput: true,
    );
    return chunks.expand(_eventsOf).decodeSnapshots(decoder);
  }

  Iterable<LlmStreamEvent> _eventsOf(OpenAiCompatibleChatChunk chunk) sync* {
    final delta = chunk.choices.isEmpty ? null : chunk.choices.first.delta;
    // The first chunk arrives with `content: ""`; drop empty deltas here.
    if (delta?.content case final String text when text.isNotEmpty) {
      yield LlmTextDelta(text);
    }
  }
}
