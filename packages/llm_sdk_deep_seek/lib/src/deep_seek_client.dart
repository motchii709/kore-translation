import 'package:dio/dio.dart';
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
    dio: Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 120),
      ),
    ),
  );
}

/// The started session; owns [dio].
final class DeepSeekSession implements LlmSession {
  DeepSeekSession({
    required String apiKey,
    required String baseUrl,
    required String model,
    required this.dio,
  }) : _llm = DeepSeekLlmClient(apiKey: apiKey, baseUrl: baseUrl, model: model, dio: dio);

  /// The HTTP transport the session owns, from [DeepSeekClient.open] to [close].
  final Dio dio;

  final DeepSeekLlmClient _llm;

  @override
  bool get isAlive => true;

  @override
  Future<void> close() async => dio.close(); // Graceful: in-flight requests finish.

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
    // The DeepSeek API has no request parameter for reasoning (it depends
    // on the model), so an unwanted reasoning stream is dropped here.
    if (thinking) {
      if (delta?.reasoningContent case final String reasoning when reasoning.isNotEmpty) {
        yield LlmThinkingDelta(reasoning);
      }
    }
    // The first chunk arrives with empty content (OpenAI-compatible wire
    // behavior); drop empty deltas here.
    if (delta?.content case final String text when text.isNotEmpty) {
      yield LlmTextDelta(text);
    }
  }
}
