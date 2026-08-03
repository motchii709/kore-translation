/// Error reported by an LLM backend: an error event or error envelope
/// (`{"error": {"message": ...}}`), an empty streaming body, or an agent
/// process that died (carrying its exit code and stderr trail).
///
/// Transport-level errors (e.g. `DioException`) are propagated as-is so
/// callers can inspect the raw failure.
class LlmApiException implements Exception {
  const LlmApiException(this.message);

  final String message;

  @override
  String toString() => 'LlmApiException: $message';
}
