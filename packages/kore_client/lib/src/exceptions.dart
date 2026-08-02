/// Error thrown by translators when a request or response parsing fails.
class KoreClientException implements Exception {
  const KoreClientException(this.message, {this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() => statusCode == null
      ? 'KoreClientException: $message'
      : 'KoreClientException($statusCode): $message';
}
