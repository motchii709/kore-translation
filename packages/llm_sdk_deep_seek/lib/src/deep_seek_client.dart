import 'package:dio/dio.dart';
import 'package:llm_sdk_core/llm_sdk_core.dart';
import 'package:llm_sdk_deep_seek/src/deep_seek_llm_client.dart';
import 'package:llm_sdk_deep_seek/src/deep_seek_stream_models.dart';

/// [LlmClient] backed by the DeepSeek API. Reasoning models
/// (deepseek-reasoner) stream their thinking via `reasoning_content`.
final class DeepSeekClient implements LlmClient {
  DeepSeekClient({required this.apiKey, required this.baseUrl, required this.model, required this.thinking});

  final String apiKey;
  final String baseUrl;
  final String model;

  /// Whether to surface `reasoning_content` (reasoning models only; the
  /// API has no request parameter, so this filters the response stream).
  final bool thinking;

  @override
  Future<LlmSession> open() async => DeepSeekSession(
    apiKey: apiKey,
    baseUrl: baseUrl,
    model: model,
    thinking: thinking,
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
    required this._thinking,
    required this.dio,
  }) : _llm = DeepSeekLlmClient(apiKey: apiKey, baseUrl: baseUrl, model: model, dio: dio);

  /// The HTTP transport the session owns, from [DeepSeekClient.open] to [close].
  final Dio dio;

  final bool _thinking;
  final DeepSeekLlmClient _llm;

  @override
  bool get isAlive => true;

  @override
  Future<void> close() async => dio.close(); // Graceful: in-flight requests finish.

  // [jsonOutput] is ignored: deepseek-reasoner rejects `response_format`,
  // so JSON-only replies rest on the prompt.
  @override
  Stream<LlmStreamEvent> streamText({required String system, required String user, bool jsonOutput = false}) {
    final chunks = _llm.streamChatCompletions(systemPrompt: system, userText: user);
    return chunks.expand(_eventsOf);
  }

  Iterable<LlmStreamEvent> _eventsOf(DeepSeekChatChunk chunk) sync* {
    final delta = chunk.choices.isEmpty ? null : chunk.choices.first.delta;
    // The DeepSeek API has no request parameter for reasoning (it depends
    // on the model), so an unwanted reasoning stream is dropped here.
    if (_thinking) {
      if (delta?.reasoningContent case final String thinking when thinking.isNotEmpty) {
        yield LlmThinkingDelta(thinking);
      }
    }
    // The first chunk arrives with empty content (OpenAI-compatible wire
    // behavior); drop empty deltas here.
    if (delta?.content case final String text when text.isNotEmpty) {
      yield LlmTextDelta(text);
    }
  }
}
