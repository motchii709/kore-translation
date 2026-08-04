import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
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

Stream<(String?, Object?)> _stream(_FakeAdapter adapter, {bool thinking = true}) => DeepSeekSession(
  apiKey: 'test-key',
  baseUrl: 'https://api.deepseek.com',
  model: 'deepseek-chat',
  dio: Dio()..httpClientAdapter = adapter,
).streamObject(
  system: 'sys',
  user: 'こんにちは',
  thinking: thinking,
  decoder: (thinking, reply) => (thinking, reply?['translation']),
);

void main() {
  test('streams reasoning_content as thinking and never sends response_format', () async {
    final adapter = _FakeAdapter(
      _sse([
        _delta({'reasoning_content': '挨拶の翻訳を考える'}),
        _delta({'content': '{"translation": "Hello"}'}),
        '[DONE]',
      ]),
    );
    final snapshots = await _stream(adapter).toList();

    expect(snapshots, [('挨拶の翻訳を考える', null), ('挨拶の翻訳を考える', 'Hello')]);
    final data = adapter.lastRequest?.data as Map<String, Object?>;
    expect(data, isNot(contains('response_format')));
  });

  test('drops reasoning when thinking is disabled', () async {
    final adapter = _FakeAdapter(
      _sse([
        _delta({'reasoning_content': '挨拶の翻訳を考える'}),
        _delta({'content': '{"translation": "Hello"}'}),
        '[DONE]',
      ]),
    );
    final snapshots = await _stream(adapter, thinking: false).toList();

    expect(snapshots, [(null, 'Hello')]);
  });
}
