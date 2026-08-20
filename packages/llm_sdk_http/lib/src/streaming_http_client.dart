import 'streaming_http_client_stub.dart'
    if (dart.library.io) 'streaming_http_client_io.dart'
    if (dart.library.js_interop) 'streaming_http_client_web.dart' as _impl;

/// A streaming HTTP POST response: the HTTP status code and a raw byte stream.
class StreamingHttpResponse {
  const StreamingHttpResponse({required this.statusCode, required this.body});
  final int statusCode;
  final Stream<List<int>> body;
}

/// Thrown by [StreamingHttpClient] for non‑2xx responses or transport failures.
/// The response body (if any) is materialised into [body] for debugging.
class StreamingHttpException implements Exception {
  const StreamingHttpException(this.statusCode, this.message, {this.body});
  final int statusCode;
  final String message;
  final String? body;
  @override
  String toString() => 'StreamingHttpException($statusCode): $message\n$body';
}

/// Platform‑agnostic streaming HTTP client.
abstract interface class StreamingHttpClient {
  /// Sends a POST request and returns the raw byte stream and status.
  Future<StreamingHttpResponse> post(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    Object? body,
  });

  /// Gracefully close any underlying resources (e.g. Dio). No‑op on the web.
  Future<void> close();
}

/// Factory that creates a platform‑appropriate [StreamingHttpClient].
StreamingHttpClient createStreamingHttpClient({
  Duration connectTimeout = const Duration(seconds: 10),
  Duration receiveTimeout = const Duration(seconds: 120),
}) => _impl.createStreamingHttpClient(
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
    );
