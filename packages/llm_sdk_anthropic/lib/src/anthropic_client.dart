import 'package:dio/dio.dart';
import 'package:llm_sdk_anthropic/src/anthropic_llm_client.dart';
import 'package:llm_sdk_anthropic/src/anthropic_stream_models.dart';
import 'package:llm_sdk_core/llm_sdk_core.dart';

/// [LlmClient] backed by the Anthropic Messages API.
final class AnthropicClient implements LlmClient {
  AnthropicClient({required this.apiKey, required this.baseUrl, required this.model, required this.thinking});

  final String apiKey;
  final String baseUrl;
  final String model;

  /// Whether to request thinking and stream it back.
  final bool thinking;

  @override
  Future<LlmSession> open() async => AnthropicSession(
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
final class AnthropicSession implements LlmSession {
  AnthropicSession({
    required String apiKey,
    required String baseUrl,
    required String model,
    required this._thinking,
    required this.dio,
  }) : _llm = AnthropicLlmClient(apiKey: apiKey, baseUrl: baseUrl, model: model, dio: dio);

  /// The HTTP transport the session owns, from [AnthropicClient.open] to [close].
  final Dio dio;

  final bool _thinking;
  final AnthropicLlmClient _llm;

  @override
  bool get isAlive => true;

  @override
  Future<void> close() async => dio.close(); // Graceful: in-flight requests finish.

  // [jsonOutput] is ignored: the Messages API has no response-format
  // parameter, so JSON-only replies rest on the prompt.
  @override
  Stream<LlmStreamEvent> streamText({required String system, required String user, bool jsonOutput = false}) {
    final events = _llm.streamMessages(
      systemPrompt: system,
      userText: user,
      // Thinking tokens count toward max_tokens, so leave generous headroom.
      maxTokens: 16384,
      // Claude 5 models only accept adaptive thinking, and their `display`
      // defaults to "omitted" (empty thinking blocks) — "summarized" opts in
      // to receiving the thinking text.
      thinking: _thinking ? const {'type': 'adaptive', 'display': 'summarized'} : const {'type': 'disabled'},
    );
    return events.expand(_eventsOf);
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
