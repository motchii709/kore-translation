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

AnthropicSession _session(_FakeAdapter adapter, {bool thinking = true}) => AnthropicSession(
  apiKey: 'test-key',
  baseUrl: 'https://api.anthropic.com',
  model: 'claude-sonnet-5',
  thinking: thinking,
  dio: Dio()..httpClientAdapter = adapter,
);

void main() {
  test('streams thinking deltas separately from text deltas', () async {
    final adapter = _FakeAdapter(
      _sse([
        _delta({'type': 'thinking_delta', 'thinking': '考え中'}),
        _delta({'type': 'text_delta', 'text': 'Hel'}),
        _delta({'type': 'text_delta', 'text': 'lo'}),
      ]),
    );
    final events = await _session(adapter).streamText(system: 'sys', user: 'こんにちは').toList();

    expect(events, [
      isA<LlmThinkingDelta>().having((e) => e.text, 'text', '考え中'),
      isA<LlmTextDelta>().having((e) => e.text, 'text', 'Hel'),
      isA<LlmTextDelta>().having((e) => e.text, 'text', 'lo'),
    ]);
    expect(adapter.lastRequest?.uri.path, '/v1/messages');
  });

  test('maps the thinking flag to the API parameter', () async {
    final adapter = _FakeAdapter(
      _sse([
        _delta({'type': 'text_delta', 'text': 'Hello'}),
      ]),
    );

    await _session(adapter).streamText(system: 'sys', user: 'u').drain<void>();
    var data = adapter.lastRequest?.data as Map<String, Object?>;
    expect(data['thinking'], {'type': 'adaptive', 'display': 'summarized'});
    expect(data['max_tokens'], 16384);

    await _session(adapter, thinking: false).streamText(system: 'sys', user: 'u').drain<void>();
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
      _session(adapter).streamText(system: 'sys', user: 'u').drain<void>(),
      throwsA(
        isA<LlmApiException>().having((e) => e.message, 'message', 'Overloaded'),
      ),
    );
  });
}
