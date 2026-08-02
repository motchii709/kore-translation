/// Error thrown by kore_client for domain-level failures: API error events,
/// unparsable replies, or replies without a result.
///
/// Transport-level errors (e.g. `DioException`) are propagated as-is so
/// callers can inspect the raw failure.
class KoreClientException implements Exception {
  const KoreClientException(this.message);

  final String message;

  @override
  String toString() => 'KoreClientException: $message';
}
