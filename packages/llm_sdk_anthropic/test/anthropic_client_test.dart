import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:llm_sdk_anthropic/src/anthropic_client.dart';
import 'package:llm_sdk_core/llm_sdk_core.dart';
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
  'type': 'content_block_delta',
  'delta': delta,
};

Stream<(String?, Object?)> _stream(_FakeAdapter adapter, {bool thinking = true}) => AnthropicSession(
  apiKey: 'test-key',
  baseUrl: 'https://api.anthropic.com',
  model: 'claude-sonnet-5',
  dio: Dio()..httpClientAdapter = adapter,
).streamObject(
  system: 'sys',
  user: 'こんにちは',
  thinking: thinking,
  decoder: (thinking, reply) => (thinking, reply?['translation']),
);

void main() {
  test('accumulates thinking and decodes reply-object snapshots', () async {
    final adapter = _FakeAdapter(
      _sse([
        _delta({'type': 'thinking_delta', 'thinking': '考え中'}),
        _delta({'type': 'text_delta', 'text': '{"translation": "Hel'}),
        _delta({'type': 'text_delta', 'text': 'lo"}'}),
      ]),
    );
    final snapshots = await _stream(adapter).toList();

    expect(snapshots, [
      ('考え中', null),
      ('考え中', 'Hel'),
      ('考え中', 'Hello'),
    ]);
    expect(adapter.lastRequest?.uri.path, '/v1/messages');
  });

  test('maps the thinking flag to the API parameter', () async {
    final adapter = _FakeAdapter(
      _sse([
        _delta({'type': 'text_delta', 'text': 'Hello'}),
      ]),
    );

    await _stream(adapter).drain<void>();
    var data = adapter.lastRequest?.data as Map<String, Object?>;
    expect(data['thinking'], {'type': 'adaptive', 'display': 'summarized'});
    expect(data['max_tokens'], 16384);

    await _stream(adapter, thinking: false).drain<void>();
    data = adapter.lastRequest?.data as Map<String, Object?>;
    expect(data['thinking'], {'type': 'disabled'});
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
      _stream(adapter).drain<void>(),
      throwsA(
        isA<LlmApiException>().having((e) => e.message, 'message', 'Overloaded'),
      ),
    );
  });
}
