import 'package:freezed_annotation/freezed_annotation.dart';

part 'anthropic_stream_models.freezed.dart';
part 'anthropic_stream_models.g.dart';

/// One SSE event of an Anthropic Messages API stream.
///
/// Only `content_block_delta` is consumed here; other event types
/// (`message_start`, `ping`, ...) fall back to [AnthropicUnknownEvent].
@Freezed(unionKey: 'type', fallbackUnion: 'unknown')
sealed class AnthropicStreamEvent with _$AnthropicStreamEvent {
  @FreezedUnionValue('content_block_delta')
  const factory AnthropicStreamEvent.contentBlockDelta({
    required AnthropicDelta delta,
  }) = AnthropicContentBlockDeltaEvent;

  const factory AnthropicStreamEvent.unknown() = AnthropicUnknownEvent;

  factory AnthropicStreamEvent.fromJson(Map<String, dynamic> json) => _$AnthropicStreamEventFromJson(json);
}

/// A block delta inside `content_block_delta`. Deltas of other kinds
/// (`signature_delta`, `input_json_delta`, ...) fall back to
/// [AnthropicUnknownDelta].
@Freezed(unionKey: 'type', fallbackUnion: 'unknown')
sealed class AnthropicDelta with _$AnthropicDelta {
  @FreezedUnionValue('text_delta')
  const factory AnthropicDelta.text({required String text}) = AnthropicTextDelta;

  @FreezedUnionValue('thinking_delta')
  const factory AnthropicDelta.thinking({required String thinking}) = AnthropicThinkingDelta;

  const factory AnthropicDelta.unknown() = AnthropicUnknownDelta;

  factory AnthropicDelta.fromJson(Map<String, dynamic> json) => _$AnthropicDeltaFromJson(json);
}
