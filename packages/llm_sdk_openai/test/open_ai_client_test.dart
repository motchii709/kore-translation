import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:llm_sdk_http/llm_sdk_http.dart';
import 'package:llm_sdk_http/src/streaming_http_client_io.dart';
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

Stream<(String?, Object?)> _stream(_FakeAdapter adapter) => OpenAiSession(
      apiKey: 'test-key',
      baseUrl: 'https://api.openai.com/v1',
      model: 'gpt-5-mini',
      client: DioStreamingHttpClient(dio: Dio()..httpClientAdapter = adapter),
    ).streamObject(
      system: 'sys',
      user: 'こんにちは',
      thinking: false,
      decoder: (thinking, reply) => (thinking, reply?['translation']),
    );

void main() {
  test('decodes reply-object snapshots, dropping empty deltas, and always requests JSON via response_format', () async {
    final adapter = _FakeAdapter(
      _sse([
        _delta({'content': ''}),
        _delta({'content': '{"translation": "Hel'}),
        _delta({'content': 'lo"}'}),
        '[DONE]',
      ]),
    );
    final snapshots = await _stream(adapter).toList();

    expect(snapshots, [(null, 'Hel'), (null, 'Hello')]);
    expect(adapter.lastRequest?.uri.path, '/v1/chat/completions');
    expect(adapter.lastRequest?.headers['Authorization'], 'Bearer test-key');
    final data = adapter.lastRequest?.data as Map<String, Object?>;
    expect(data['response_format'], {'type': 'json_object'});
  });

  test('an HTTP error propagates a StreamingHttpException with a drained body', () {
    final adapter = _FakeAdapter(
      '{"error": {"message": "Incorrect API key provided"}}',
      statusCode: 401,
    );
    expect(
      _stream(adapter).last,
      throwsA(
        isA<StreamingHttpException>()
            .having((e) => e.statusCode, 'statusCode', 401)
            .having((e) => e.body, 'body', contains('Incorrect API key provided')),
      ),
    );
  });
}
