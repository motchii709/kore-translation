import 'package:dio/dio.dart';
import 'package:llm_sdk_core/llm_sdk_core.dart';
import 'package:llm_sdk_google/src/gemini_llm_client.dart';
import 'package:llm_sdk_google/src/gemini_stream_models.dart';

/// [LlmClient] backed by the Google AI (Gemini) API.
final class GeminiClient implements LlmClient {
  GeminiClient({required this.apiKey, required this.baseUrl, required this.model, required this.thinking});

  final String apiKey;
  final String baseUrl;
  final String model;

  /// Whether to request the model's thoughts in the response.
  final bool thinking;

  @override
  Future<LlmSession> open() async => GeminiSession(
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
final class GeminiSession implements LlmSession {
  GeminiSession({
    required String apiKey,
    required String baseUrl,
    required String model,
    required this._thinking,
    required this.dio,
  }) : _llm = GeminiLlmClient(apiKey: apiKey, baseUrl: baseUrl, model: model, dio: dio);

  /// The HTTP transport the session owns, from [GeminiClient.open] to [close].
  final Dio dio;

  final bool _thinking;
  final GeminiLlmClient _llm;

  @override
  bool get isAlive => true;

  @override
  Future<void> close() async => dio.close(); // Graceful: in-flight requests finish.

  @override
  Stream<LlmStreamEvent> streamText({required String system, required String user, bool jsonOutput = false}) {
    final chunks = _llm.streamGenerateContent(
      systemPrompt: system,
      userText: user,
      responseMimeType: jsonOutput ? 'application/json' : null,
      // Thoughts are only included in the response when explicitly requested.
      thinkingConfig: _thinking ? const {'includeThoughts': true} : null,
    );
    return chunks.expand(_eventsOf);
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
