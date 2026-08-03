import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:llm_sdk_core/llm_sdk_core.dart';
import 'package:llm_sdk_openai/src/open_ai_client.dart';
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

Map<String, Object> _delta(Map<String, Object> delta) => {
  'choices': [
    {'delta': delta},
  ],
};

Matcher _text(String text) => isA<LlmTextDelta>().having((e) => e.text, 'text', text);

OpenAiSession _session(_FakeAdapter adapter) => OpenAiSession(
  apiKey: 'test-key',
  baseUrl: 'https://api.openai.com/v1',
  model: 'gpt-5-mini',
  dio: Dio()..httpClientAdapter = adapter,
);

void main() {
  test('streams text deltas, dropping empty ones, and maps jsonOutput to response_format', () async {
    final adapter = _FakeAdapter(
      _sse([
        _delta({'content': ''}),
        _delta({'content': 'Hel'}),
        _delta({'content': 'lo'}),
        '[DONE]',
      ]),
    );
    final events = await _session(adapter).streamText(system: 'sys', user: 'こんにちは', jsonOutput: true).toList();

    expect(events, [_text('Hel'), _text('lo')]);
    expect(adapter.lastRequest?.uri.path, '/v1/chat/completions');
    expect(adapter.lastRequest?.headers['Authorization'], 'Bearer test-key');
    final data = adapter.lastRequest?.data as Map<String, Object?>;
    expect(data['response_format'], {'type': 'json_object'});
  });

  test('an HTTP error propagates the raw DioException with a drained body', () {
    final adapter = _FakeAdapter(
      '{"error": {"message": "Incorrect API key provided"}}',
      statusCode: 401,
    );
    expect(
      _session(adapter).streamText(system: 'sys', user: 'u').last,
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
