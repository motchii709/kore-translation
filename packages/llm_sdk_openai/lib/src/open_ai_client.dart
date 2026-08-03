import 'package:dio/dio.dart';
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
    dio: Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 120),
      ),
    ),
  );
}

/// The started session; owns [dio].
final class OpenAiSession implements LlmSession {
  OpenAiSession({required String apiKey, required String baseUrl, required String model, required this.dio})
    : _llm = OpenAiLlmClient(apiKey: apiKey, baseUrl: baseUrl, model: model, dio: dio);

  /// The HTTP transport the session owns, from [OpenAiClient.open] to [close].
  final Dio dio;

  final OpenAiLlmClient _llm;

  @override
  bool get isAlive => true;

  @override
  Future<void> close() async => dio.close(); // Graceful: in-flight requests finish.

  @override
  Stream<LlmStreamEvent> streamText({required String system, required String user, bool jsonOutput = false}) {
    final chunks = _llm.streamChatCompletions(
      systemPrompt: system,
      userText: user,
      responseFormat: jsonOutput ? const {'type': 'json_object'} : null,
    );
    return chunks.expand(_eventsOf);
  }

  Iterable<LlmStreamEvent> _eventsOf(OpenAiChatChunk chunk) sync* {
    final delta = chunk.choices.isEmpty ? null : chunk.choices.first.delta;
    // The first chunk arrives with `content: ""`; drop empty deltas here.
    if (delta?.content case final String text when text.isNotEmpty) {
      yield LlmTextDelta(text);
    }
  }
}
