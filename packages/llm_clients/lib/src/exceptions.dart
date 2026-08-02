/// Error reported by an LLM API: an error event or error envelope
/// (`{"error": {"message": ...}}`), or an empty streaming body.
///
/// Transport-level errors (e.g. `DioException`) are propagated as-is so
/// callers can inspect the raw failure.
class LlmApiException implements Exception {
  const LlmApiException(this.message);

  final String message;

  @override
  String toString() => 'LlmApiException: $message';
}
