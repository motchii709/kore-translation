import 'dart:async';
import 'dart:convert';
import 'dart:js_interop';
import 'package:web/web.dart' as web;
import 'streaming_http_client.dart';

/// Creates a web (Fetch API) based [StreamingHttpClient].
StreamingHttpClient createStreamingHttpClient({Duration? connectTimeout, Duration? receiveTimeout}) =>
    FetchStreamingHttpClient();

final class FetchStreamingHttpClient implements StreamingHttpClient {
  @override
  Future<StreamingHttpResponse> post(String url,
      {Map<String, String>? headers,
      Map<String, dynamic>? queryParameters,
      Object? body}) async {
    final uri = Uri.parse(url).replace(queryParameters: queryParameters);
    final requestHeaders = (headers ?? {}).jsify() as JSObject;
    final requestInit = web.RequestInit(
      method: 'POST',
      headers: requestHeaders,
      body: body != null ? jsonEncode(body).toJS : null,
    );
    
    // Use fetch with proper promise handling
    final responsePromise = web.window.fetch(web.Request(uri.toString(), requestInit));
    final response = await responsePromise.toDart;
    final status = response.status;
    final readable = response.body;
    
    if (readable == null) {
      throw const StreamingHttpException(0, 'Empty API response body');
    }
    
    // Convert ReadableStream to Dart Stream<List<int>>
    final stream = _readableStream(readable);
    
    if (status < 200 || status >= 300) {
      // Materialise the error body.
      final errorBytes = await _readAllBytes(readable);
      final errorText = utf8.decode(errorBytes);
      throw StreamingHttpException(status, 'HTTP $status', body: errorText);
    }
    return StreamingHttpResponse(statusCode: status, body: stream);
  }

  @override
  Future<void> close() async {}
}

// Helper: Convert a ReadableStream to a Dart Stream<List<int>>.
Stream<List<int>> _readableStream(web.ReadableStream stream) {
  final controller = StreamController<List<int>>();
  final reader = stream.getReader();
  
  void pump() {
    final promise = reader.read();
    promise.toDart.then((result) {
      // result is a ReadableStreamReadResult
      final done = result.done;
      if (done) {
        controller.close();
        return;
      }
      final value = result.value;
      if (value != null) {
        // value is expected to be a JSUint8Array.
        final bytes = (value as web.JSUint8Array).toDart;
        controller.add(bytes);
      }
      pump();
    }).catchError((e, st) {
      controller.addError(e, st);
      controller.close();
    });
  }
  pump();
  return controller.stream;
}

// Helper: Read all bytes from a ReadableStream (used for error bodies).
Future<List<int>> _readAllBytes(web.ReadableStream stream) async {
  final bytes = <int>[];
  await for (final chunk in _readableStream(stream)) {
    bytes.addAll(chunk);
  }
  return bytes;
}