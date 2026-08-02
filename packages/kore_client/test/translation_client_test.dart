import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:kore_client/kore_client.dart';
import 'package:test/test.dart';

/// Serves a canned SSE (or plain) body for any request.
class _FakeAdapter implements HttpClientAdapter {
  _FakeAdapter(this.body, {this.statusCode = 200});

  final String body;
  final int statusCode;
  RequestOptions? lastRequest;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    lastRequest = options;
    return ResponseBody.fromString(
      body,
      statusCode,
      headers: {
        Headers.contentTypeHeader: [
          if (statusCode == 200) 'text/event-stream' else 'text/plain',
        ],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

String _sse(List<Object> events) =>
    events.map((event) => 'data: ${event is String ? event : jsonEncode(event)}\n\n').join();

TranslationClient _client(LlmClientConfig config, _FakeAdapter adapter) {
  final dio = Dio()..httpClientAdapter = adapter;
  return switch (config) {
    final OpenAiConfig config => OpenAiTranslationClient(
      llm: OpenAiLlmClient(config: config, dio: dio),
    ),
    final OpenAiCompatibleConfig config => OpenAiCompatibleTranslationClient(
      llm: OpenAiCompatibleLlmClient(config: config, dio: dio),
    ),
    final AnthropicConfig config => AnthropicTranslationClient(
      llm: AnthropicLlmClient(config: config, dio: dio),
    ),
    final GeminiConfig config => GeminiTranslationClient(
      llm: GeminiLlmClient(config: config, dio: dio),
    ),
    final DeepSeekConfig config => DeepSeekTranslationClient(
      llm: DeepSeekLlmClient(config: config, dio: dio),
    ),
  };
}

Map<String, Object> _openAiDelta(Map<String, Object> delta) => {
  'choices': [
    {'delta': delta},
  ],
};

Map<String, Object> _anthropicDelta(Map<String, Object> delta) => {
  'type': 'content_block_delta',
  'delta': delta,
};

Map<String, Object> _geminiParts(List<Map<String, Object>> parts) => {
  'candidates': [
    {
      'content': {'parts': parts},
    },
  ],
};

void main() {
  const prompt = 'You are a professional translator. Translate into English.';

  test('OpenAiTranslationClient streams snapshots and a validated final result', () async {
    final adapter = _FakeAdapter(
      _sse([
        _openAiDelta({'content': ''}),
        _openAiDelta({'content': '{"translation": "He'}),
        _openAiDelta({'content': 'llo", "explanation": "挨拶'}),
        _openAiDelta({'content': 'です。"}'}),
        '[DONE]',
      ]),
    );
    final events = await _client(
      const LlmClientConfig.openAi(apiKey: 'test-key'),
      adapter,
    ).streamTranslation(systemPrompt: prompt, text: 'こんにちは').toList();

    expect(events.map((e) => e.result?.translation), contains('He'));
    final last = events.last;
    expect(last.result?.translation, 'Hello');
    expect(last.result?.explanation, '挨拶です。');
    expect(adapter.lastRequest?.uri.path, '/v1/chat/completions');
  });

  test('OpenAiCompatibleTranslationClient omits authentication for local servers', () async {
    final adapter = _FakeAdapter(
      _sse([
        _openAiDelta({'content': '{"translation": "Hello"}'}),
        '[DONE]',
      ]),
    );
    final events = await _client(
      const LlmClientConfig.openAiCompatible(
        baseUrl: 'http://localhost:11434/v1',
        model: 'llama3',
      ),
      adapter,
    ).streamTranslation(systemPrompt: prompt, text: 'こんにちは').toList();

    expect(events.last.result?.translation, 'Hello');
    expect(adapter.lastRequest?.headers.containsKey('Authorization'), isFalse);
    expect(adapter.lastRequest?.uri.toString(), 'http://localhost:11434/v1/chat/completions');
  });

  test('DeepSeekTranslationClient streams reasoning_content as thinking', () async {
    final adapter = _FakeAdapter(
      _sse([
        _openAiDelta({'reasoning_content': '挨拶の翻訳を考える'}),
        _openAiDelta({'content': '{"translation": "He'}),
        _openAiDelta({'content': 'llo"}'}),
        '[DONE]',
      ]),
    );
    final events = await _client(
      const LlmClientConfig.deepSeek(apiKey: 'test-key'),
      adapter,
    ).streamTranslation(systemPrompt: prompt, text: 'こんにちは').toList();

    expect(events.first.thinking, '挨拶の翻訳を考える');
    expect(events.first.result, isNull);
    expect(events.last.result?.translation, 'Hello');
    expect(events.last.thinking, '挨拶の翻訳を考える');
    expect(adapter.lastRequest?.uri.path, '/chat/completions');
  });

  test('AnthropicTranslationClient streams thinking deltas separately', () async {
    final adapter = _FakeAdapter(
      _sse([
        _anthropicDelta({'type': 'thinking_delta', 'thinking': '考え中'}),
        _anthropicDelta({'type': 'text_delta', 'text': '{"translation": "He'}),
        _anthropicDelta({'type': 'text_delta', 'text': 'llo"}'}),
      ]),
    );
    final events = await _client(
      const LlmClientConfig.anthropic(apiKey: 'test-key'),
      adapter,
    ).streamTranslation(systemPrompt: prompt, text: 'こんにちは').toList();

    expect(events.first.thinking, '考え中');
    expect(events.first.result, isNull);
    expect(events.last.result?.translation, 'Hello');
    expect(events.last.thinking, '考え中');
    expect(adapter.lastRequest?.uri.path, '/v1/messages');
  });

  test('AnthropicTranslationClient maps the thinking flag to the API parameter', () async {
    final adapter = _FakeAdapter(
      _sse([
        _anthropicDelta({'type': 'text_delta', 'text': '{"translation": "Hello"}'}),
      ]),
    );
    final client = _client(const LlmClientConfig.anthropic(apiKey: 'test-key'), adapter);

    await client.streamTranslation(systemPrompt: prompt, text: 'こんにちは').last;
    var data = adapter.lastRequest?.data as Map<String, Object?>;
    expect(data['thinking'], {'type': 'adaptive', 'display': 'summarized'});

    await client.streamTranslation(systemPrompt: prompt, text: 'こんにちは', thinking: false).last;
    data = adapter.lastRequest?.data as Map<String, Object?>;
    expect(data['thinking'], {'type': 'disabled'});
  });

  test('DeepSeekTranslationClient drops reasoning when thinking is off', () async {
    final adapter = _FakeAdapter(
      _sse([
        _openAiDelta({'reasoning_content': '挨拶の翻訳を考える'}),
        _openAiDelta({'content': '{"translation": "Hello"}'}),
        '[DONE]',
      ]),
    );
    final events = await _client(
      const LlmClientConfig.deepSeek(apiKey: 'test-key'),
      adapter,
    ).streamTranslation(systemPrompt: prompt, text: 'こんにちは', thinking: false).toList();

    expect(events.map((e) => e.thinking), everyElement(isEmpty));
    expect(events.last.result?.translation, 'Hello');
  });

  test('GeminiTranslationClient treats thought parts as thinking', () async {
    final adapter = _FakeAdapter(
      _sse([
        _geminiParts([
          {'thought': true, 'text': '推論の要約'},
          {'text': '{"translation": "Hel'},
        ]),
        _geminiParts([
          {'text': 'lo"}'},
        ]),
      ]),
    );
    final events = await _client(
      const LlmClientConfig.google(apiKey: 'test-key'),
      adapter,
    ).streamTranslation(systemPrompt: prompt, text: 'こんにちは').toList();

    expect(events.map((e) => e.thinking), contains('推論の要約'));
    expect(events.last.result?.translation, 'Hello');
  });

  test('an error event in the stream surfaces the API message', () {
    final adapter = _FakeAdapter(
      _sse([
        {
          'error': {'message': 'Overloaded'},
        },
      ]),
    );
    expect(
      _client(
        const LlmClientConfig.anthropic(apiKey: 'test-key'),
        adapter,
      ).streamTranslation(systemPrompt: prompt, text: 'こんにちは').last,
      throwsA(
        isA<KoreClientException>().having((e) => e.message, 'message', 'Overloaded'),
      ),
    );
  });

  test('an HTTP error propagates the raw DioException with a drained body', () {
    final adapter = _FakeAdapter(
      '{"error": {"message": "Incorrect API key provided"}}',
      statusCode: 401,
    );
    expect(
      _client(
        const LlmClientConfig.openAi(apiKey: 'test-key'),
        adapter,
      ).streamTranslation(systemPrompt: prompt, text: 'こんにちは').last,
      throwsA(
        isA<DioException>()
            .having((e) => e.response?.statusCode, 'statusCode', 401)
            .having(
              (e) => e.response?.data,
              'response.data',
              contains('Incorrect API key provided'),
            ),
      ),
    );
  });
}
