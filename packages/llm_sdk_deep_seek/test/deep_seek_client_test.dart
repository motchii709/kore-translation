import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:llm_sdk_core/llm_sdk_core.dart';
import 'package:llm_sdk_deep_seek/src/deep_seek_client.dart';
import 'package:test/test.dart';

/// Serves a canned SSE body for any request.
class _FakeAdapter implements HttpClientAdapter {
  _FakeAdapter(this.body);

  final String body;
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
      200,
      headers: {
        Headers.contentTypeHeader: ['text/event-stream'],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

String _sse(List<Object> events) =>
    events.map((event) => 'data: ${event is String ? event : jsonEncode(event)}\n\n').join();

Map<String, Object> _delta(Map<String, Object> delta) => {
  'choices': [
    {'delta': delta},
  ],
};

DeepSeekSession _session(_FakeAdapter adapter, {bool thinking = true}) => DeepSeekSession(
  apiKey: 'test-key',
  baseUrl: 'https://api.deepseek.com',
  model: 'deepseek-chat',
  thinking: thinking,
  dio: Dio()..httpClientAdapter = adapter,
);

void main() {
  test('streams reasoning_content as thinking and never sends response_format', () async {
    final adapter = _FakeAdapter(
      _sse([
        _delta({'reasoning_content': '挨拶の翻訳を考える'}),
        _delta({'content': 'Hello'}),
        '[DONE]',
      ]),
    );
    final events = await _session(adapter).streamText(system: 'sys', user: 'こんにちは', jsonOutput: true).toList();

    expect(events, [
      isA<LlmThinkingDelta>().having((e) => e.text, 'text', '挨拶の翻訳を考える'),
      isA<LlmTextDelta>().having((e) => e.text, 'text', 'Hello'),
    ]);
    final data = adapter.lastRequest?.data as Map<String, Object?>;
    expect(data, isNot(contains('response_format')));
  });

  test('drops reasoning when thinking is disabled', () async {
    final adapter = _FakeAdapter(
      _sse([
        _delta({'reasoning_content': '挨拶の翻訳を考える'}),
        _delta({'content': 'Hello'}),
        '[DONE]',
      ]),
    );
    final events = await _session(adapter, thinking: false).streamText(system: 'sys', user: 'こんにちは').toList();

    expect(events, [isA<LlmTextDelta>().having((e) => e.text, 'text', 'Hello')]);
  });
}
