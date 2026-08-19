import 'package:llm_sdk_http/llm_sdk_http.dart';
import 'package:llm_sdk_core/llm_sdk_core.dart';
import 'package:llm_sdk_deep_seek/src/deep_seek_llm_client.dart';
import 'package:llm_sdk_deep_seek/src/deep_seek_stream_models.dart';

/// [LlmClient] backed by the DeepSeek API. Reasoning models
/// (deepseek-reasoner) stream their thinking via `reasoning_content`.
final class DeepSeekClient implements LlmClient {
  DeepSeekClient({required this.apiKey, required this.baseUrl, required this.model});

  final String apiKey;
  final String baseUrl;
  final String model;

  @override
  Future<LlmSession> open() async => DeepSeekSession(
        apiKey: apiKey,
        baseUrl: baseUrl,
        model: model,
        client: createStreamingHttpClient(),
      );
}

/// The started session; owns [client].
final class DeepSeekSession implements LlmSession {
  DeepSeekSession({
    required String apiKey,
    required String baseUrl,
    required String model,
    required this.client,
  }) : _llm = DeepSeekLlmClient(
          apiKey: apiKey,
          baseUrl: baseUrl,
          model: model,
          client: client,
        );

  final StreamingHttpClient client;
  final DeepSeekLlmClient _llm;

  @override
  bool get isAlive => true;

  @override
  Future<void> close() async => client.close();

  // deepseek-reasoner rejects `response_format`, so the JSON-only reply
  // rests on the prompt.
  @override
  Stream<T> streamObject<T>({
    required String system,
    required String user,
    required bool thinking,
    required T Function(String? thinking, Map<String, dynamic>? reply) decoder,
  }) {
    final chunks = _llm.streamChatCompletions(systemPrompt: system, userText: user);
    return chunks.expand((chunk) => _eventsOf(chunk, thinking: thinking)).decodeSnapshots(decoder);
  }

  Iterable<LlmStreamEvent> _eventsOf(DeepSeekChatChunk chunk, {required bool thinking}) sync* {
    final delta = chunk.choices.isEmpty ? null : chunk.choices.first.delta;
    if (thinking) {
      if (delta?.reasoningContent case final String reasoning when reasoning.isNotEmpty) {
        yield LlmThinkingDelta(reasoning);
      }
    }
    if (delta?.content case final String text when text.isNotEmpty) {
      yield LlmTextDelta(text);
    }
  }
}
