import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:llm_sdk_core/llm_sdk_core.dart';
import 'package:llm_sdk_openai_compatible/src/open_ai_compatible_client.dart';
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

void main() {
  test('omits authentication for local servers and streams text deltas', () async {
    final adapter = _FakeAdapter(
      _sse([
        {
          'choices': [
            {
              'delta': {'content': 'Hello'},
            },
          ],
        },
        '[DONE]',
      ]),
    );
    final session = OpenAiCompatibleSession(
      apiKey: '',
      baseUrl: 'http://localhost:11434/v1',
      model: 'llama3',
      dio: Dio()..httpClientAdapter = adapter,
    );
    final events = await session.streamText(system: 'sys', user: 'こんにちは').toList();

    expect(events, [isA<LlmTextDelta>().having((e) => e.text, 'text', 'Hello')]);
    expect(adapter.lastRequest?.headers.containsKey('Authorization'), isFalse);
    expect(adapter.lastRequest?.uri.toString(), 'http://localhost:11434/v1/chat/completions');
  });
}
