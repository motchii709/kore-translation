import 'package:llm_sdk_acp/src/acp_llm_client.dart';
import 'package:llm_sdk_acp/src/acp_stream_models.dart';
import 'package:llm_sdk_core/llm_sdk_core.dart';
import 'package:stdio_agent/stdio_agent.dart';

/// [LlmClient] backed by an Agent Client Protocol agent
/// (https://agentclientprotocol.com) such as Claude Code or Gemini CLI.
/// Credentials and model belong to the agent itself.
final class AcpClient implements LlmClient {
  AcpClient({required this.command});

  /// The command line that starts the agent on stdio.
  final String command;

  @override
  Future<LlmSession> open() async {
    final process = await StdioAgentProcess.start(command);
    try {
      return AcpSession(llm: await AcpLlmClient.connect(process.channel), process: process);
    } on Exception {
      await process.shutdown(); // A failed handshake must not leak the subprocess.
      rethrow;
    }
  }
}

/// The started session; owns [process].
final class AcpSession implements LlmSession {
  AcpSession({required this._llm, required this.process});

  /// The agent subprocess the session owns, from [AcpClient.open] to [close].
  final StdioAgentProcess process;

  final AcpLlmClient _llm;

  @override
  bool get isAlive => !process.hasExited;

  @override
  Future<void> close() => process.shutdown();

  // [thinking] is ignored — ACP has no thinking switch: agents reason at
  // their own discretion, and thought chunks stream whenever the agent
  // emits them. It has no response-format control either, so the JSON-only
  // reply rests on the prompt.
  @override
  Stream<T> streamObject<T>({
    required String system,
    required String user,
    required bool thinking,
    required T Function(String? thinking, Map<String, dynamic>? reply) decoder,
  }) {
    // ACP has no system-prompt slot: the instruction is prepended to the
    // turn's single text block here, where that provider knowledge belongs.
    final updates = _llm.streamPrompt(text: '$system\n\n$user');
    return updates.expand(_eventsOf).decodeSnapshots(decoder);
  }

  Iterable<LlmStreamEvent> _eventsOf(AcpSessionUpdate update) sync* {
    switch (update) {
      case AcpAgentMessageChunk(content: AcpTextContent(:final text)):
        yield LlmTextDelta(text);
      case AcpAgentThoughtChunk(content: AcpTextContent(:final text)):
        yield LlmThinkingDelta(text);
      default:
        break;
    }
  }
}
