import 'package:freezed_annotation/freezed_annotation.dart';

part 'codex_stream_models.freezed.dart';

/// One streaming notification of a Codex app-server turn, reduced to the
/// kinds a text consumer needs: the agent's message text and its reasoning
/// (summary) text. The JSON-RPC method name is the discriminator on the
/// wire, so `CodexLlmClient` constructs these directly; every other
/// notification kind is dropped there.
@freezed
sealed class CodexTurnEvent with _$CodexTurnEvent {
  const factory CodexTurnEvent.agentMessageDelta({required String delta}) = CodexAgentMessageDelta;

  const factory CodexTurnEvent.reasoningSummaryTextDelta({required String delta}) = CodexReasoningSummaryTextDelta;

  const factory CodexTurnEvent.reasoningTextDelta({required String delta}) = CodexReasoningTextDelta;
}
