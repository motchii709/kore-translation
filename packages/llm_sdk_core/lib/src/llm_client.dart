/// A configured LLM backend. Stateless: [open] starts a new, independent
/// session every time and never caches one — sharing and lifetime are the
/// caller's business.
abstract interface class LlmClient {
  Future<LlmSession> open();
}

/// A live connection to an LLM backend, holding resources (HTTP sockets, an
/// agent subprocess) until [close].
abstract interface class LlmSession {
  /// Streams one turn as a growing sequence of [T] snapshots: on every
  /// received fragment, [decoder] is called with the thinking text
  /// accumulated so far and the reply's latest decodable JSON object —
  /// leniently completed while the reply is still truncated — and its
  /// return value is emitted, so the last snapshot is built from the
  /// complete turn. Either argument is null while nothing of it has
  /// arrived: thinking until its first fragment, the reply until an object
  /// first decodes.
  ///
  /// Every turn expects a JSON-only reply: the contract itself lives in the
  /// system prompt, and providers whose API has a response-format control
  /// additionally enforce it there. [thinking] asks the model to think and
  /// stream the thinking text back; providers without such a control ignore
  /// it.
  Stream<T> streamObject<T>({
    required String system,
    required String user,
    required bool thinking,
    required T Function(String? thinking, Map<String, dynamic>? reply) decoder,
  });

  /// Whether the backend is still usable. Agent-backed sessions die with
  /// their subprocess (crash, external kill, self-exit); the caller recovers
  /// by opening a fresh session. HTTP-backed sessions are always alive.
  bool get isAlive;

  /// Releases the session's resources. HTTP backends close gracefully
  /// (in-flight requests finish, idle sockets are released); agent backends
  /// end their subprocess (EOF, then kill after a grace period), which
  /// aborts an in-flight turn. Idempotent.
  Future<void> close();
}
