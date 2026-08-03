import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:llm_sdk_core/llm_sdk_core.dart';
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
  test('treats thought parts as thinking and maps jsonOutput to the response MIME type', () async {
    final adapter = _FakeAdapter(
      _sse([
        _parts([
          {'thought': true, 'text': '推論の要約'},
          {'text': 'Hel'},
        ]),
        _parts([
          {'text': 'lo'},
        ]),
      ]),
    );
    final session = GeminiSession(
      apiKey: 'test-key',
      baseUrl: 'https://generativelanguage.googleapis.com',
      model: 'gemini-2.5-flash',
      thinking: true,
      dio: Dio()..httpClientAdapter = adapter,
    );
    final events = await session.streamText(system: 'sys', user: 'こんにちは', jsonOutput: true).toList();

    expect(events, [
      isA<LlmThinkingDelta>().having((e) => e.text, 'text', '推論の要約'),
      isA<LlmTextDelta>().having((e) => e.text, 'text', 'Hel'),
      isA<LlmTextDelta>().having((e) => e.text, 'text', 'lo'),
    ]);
    final data = adapter.lastRequest?.data as Map<String, Object?>;
    expect(data['generationConfig'], {
      'responseMimeType': 'application/json',
      'thinkingConfig': {'includeThoughts': true},
    });
  });
}
