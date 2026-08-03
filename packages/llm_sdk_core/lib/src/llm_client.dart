import 'package:llm_sdk_core/src/llm_stream_event.dart';

/// A configured LLM backend. Stateless: [open] starts a new, independent
/// session every time and never caches one — sharing and lifetime are the
/// caller's business.
abstract interface class LlmClient {
  Future<LlmSession> open();
}

/// A live connection to an LLM backend, holding resources (HTTP sockets, an
/// agent subprocess) until [close].
abstract interface class LlmSession {
  /// Streams one turn. [jsonOutput] asks the model to reply with JSON only;
  /// providers without such a control ignore it.
  Stream<LlmStreamEvent> streamText({
    required String system,
    required String user,
    bool jsonOutput = false,
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
