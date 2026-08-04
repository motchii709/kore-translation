import 'package:llm_sdk_codex/src/codex_llm_client.dart';
import 'package:llm_sdk_codex/src/codex_stream_models.dart';
import 'package:llm_sdk_core/llm_sdk_core.dart';
import 'package:stdio_agent/stdio_agent.dart';

/// [LlmClient] backed by the Codex app-server (Codex's own stdio JSON-RPC
/// protocol, spoken by the official IDE extensions). Credentials come from
/// `codex login`; an empty [model] uses the Codex configuration's default.
final class CodexClient implements LlmClient {
  CodexClient({required this.command, required this.model});

  /// The command line that starts the server on stdio.
  final String command;

  final String model;

  @override
  Future<LlmSession> open() async {
    final process = await StdioAgentProcess.start(command);
    try {
      return CodexSession(
        llm: await CodexLlmClient.connect(process.channel, model: model),
        process: process,
      );
    } on Exception {
      await process.shutdown(); // A failed handshake must not leak the subprocess.
      rethrow;
    }
  }
}

/// The started session; owns [process].
final class CodexSession implements LlmSession {
  CodexSession({required this._llm, required this.process});

  /// The server subprocess the session owns, from [CodexClient.open] to [close].
  final StdioAgentProcess process;

  final CodexLlmClient _llm;

  @override
  bool get isAlive => !process.hasExited;

  @override
  Future<void> close() => process.shutdown();

  // The app-server has no response-format control, so the JSON-only reply
  // rests on the prompt.
  @override
  Stream<T> streamObject<T>({
    required String system,
    required String user,
    required bool thinking,
    required T Function(String? thinking, Map<String, dynamic>? reply) decoder,
  }) {
    final events = _llm.streamTurn(
      systemPrompt: system,
      userText: user,
      // Codex models always reason; the summary setting only controls
      // whether the reasoning streams back as text.
      reasoningSummary: thinking ? 'auto' : 'none',
    );
    return events.expand(_eventsOf).decodeSnapshots(decoder);
  }

  Iterable<LlmStreamEvent> _eventsOf(CodexTurnEvent event) sync* {
    switch (event) {
      case CodexAgentMessageDelta(:final delta):
        yield LlmTextDelta(delta);
      case CodexReasoningSummaryTextDelta(:final delta) || CodexReasoningTextDelta(:final delta):
        yield LlmThinkingDelta(delta);
    }
  }
}
