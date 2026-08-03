import 'package:freezed_annotation/freezed_annotation.dart';

part 'acp_stream_models.freezed.dart';
part 'acp_stream_models.g.dart';

/// One `session/update` notification of an ACP prompt turn.
///
/// Only the agent's message and thought chunks are consumed here; other
/// update kinds (`tool_call`, `plan`, `usage_update`, ...) fall back to
/// [AcpUnknownUpdate].
@Freezed(unionKey: 'sessionUpdate', fallbackUnion: 'unknown')
sealed class AcpSessionUpdate with _$AcpSessionUpdate {
  @FreezedUnionValue('agent_message_chunk')
  const factory AcpSessionUpdate.agentMessageChunk({
    required AcpContentBlock content,
  }) = AcpAgentMessageChunk;

  @FreezedUnionValue('agent_thought_chunk')
  const factory AcpSessionUpdate.agentThoughtChunk({
    required AcpContentBlock content,
  }) = AcpAgentThoughtChunk;

  const factory AcpSessionUpdate.unknown() = AcpUnknownUpdate;

  factory AcpSessionUpdate.fromJson(Map<String, dynamic> json) => _$AcpSessionUpdateFromJson(json);
}

/// A content block inside a message or thought chunk. Blocks of other kinds
/// (`image`, `resource`, ...) fall back to [AcpUnknownContent].
@Freezed(unionKey: 'type', fallbackUnion: 'unknown')
sealed class AcpContentBlock with _$AcpContentBlock {
  const factory AcpContentBlock.text({required String text}) = AcpTextContent;

  const factory AcpContentBlock.unknown() = AcpUnknownContent;

  factory AcpContentBlock.fromJson(Map<String, dynamic> json) => _$AcpContentBlockFromJson(json);
}
