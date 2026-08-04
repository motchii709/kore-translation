import 'package:dio/dio.dart';
import 'package:llm_sdk_core/llm_sdk_core.dart';
import 'package:llm_sdk_google/src/gemini_llm_client.dart';
import 'package:llm_sdk_google/src/gemini_stream_models.dart';

/// [LlmClient] backed by the Google AI (Gemini) API.
final class GeminiClient implements LlmClient {
  GeminiClient({required this.apiKey, required this.baseUrl, required this.model});

  final String apiKey;
  final String baseUrl;
  final String model;

  @override
  Future<LlmSession> open() async => GeminiSession(
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
final class GeminiSession implements LlmSession {
  GeminiSession({
    required String apiKey,
    required String baseUrl,
    required String model,
    required this.dio,
  }) : _llm = GeminiLlmClient(apiKey: apiKey, baseUrl: baseUrl, model: model, dio: dio);

  /// The HTTP transport the session owns, from [GeminiClient.open] to [close].
  final Dio dio;

  final GeminiLlmClient _llm;

  @override
  bool get isAlive => true;

  @override
  Future<void> close() async => dio.close(); // Graceful: in-flight requests finish.

  @override
  Stream<T> streamObject<T>({
    required String system,
    required String user,
    required bool thinking,
    required T Function(String? thinking, Map<String, dynamic>? reply) decoder,
  }) {
    final chunks = _llm.streamGenerateContent(
      systemPrompt: system,
      userText: user,
      responseMimeType: 'application/json',
      thinking: thinking,
    );
    return chunks.expand(_eventsOf).decodeSnapshots(decoder);
  }

  Iterable<LlmStreamEvent> _eventsOf(GeminiStreamChunk chunk) sync* {
    final parts = chunk.candidates.isEmpty
        ? const <GeminiPart>[]
        : chunk.candidates.first.content?.parts ?? const <GeminiPart>[];
    for (final part in parts) {
      final text = part.text;
      if (text == null) {
        continue;
      }
      yield part.thought ? LlmThinkingDelta(text) : LlmTextDelta(text);
    }
  }
}
