import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:llm_sdk_google/src/gemini_client.dart';
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

Map<String, Object> _parts(List<Map<String, Object>> parts) => {
  'candidates': [
    {
      'content': {'parts': parts},
    },
  ],
};

void main() {
  test('treats thought parts as thinking and always requests JSON via the response MIME type', () async {
    final adapter = _FakeAdapter(
      _sse([
        _parts([
          {'thought': true, 'text': '推論の要約'},
          {'text': '{"translation": "Hel'},
        ]),
        _parts([
          {'text': 'lo"}'},
        ]),
      ]),
    );
    final session = GeminiSession(
      apiKey: 'test-key',
      baseUrl: 'https://generativelanguage.googleapis.com',
      model: 'gemini-2.5-flash',
      dio: Dio()..httpClientAdapter = adapter,
    );
    final snapshots = await session
        .streamObject(
          system: 'sys',
          user: 'こんにちは',
          thinking: true,
          decoder: (thinking, reply) => (thinking, reply?['translation']),
        )
        .toList();

    expect(snapshots, [
      ('推論の要約', null),
      ('推論の要約', 'Hel'),
      ('推論の要約', 'Hello'),
    ]);
    final data = adapter.lastRequest?.data as Map<String, Object?>;
    expect(data['generationConfig'], {
      'responseMimeType': 'application/json',
      'thinkingConfig': {'includeThoughts': true},
    });
  });
}
