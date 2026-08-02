import 'package:freezed_annotation/freezed_annotation.dart';

part 'deep_seek_stream_models.freezed.dart';
part 'deep_seek_stream_models.g.dart';

/// One SSE chunk of a DeepSeek Chat Completions stream.
///
/// DeepSeek speaks the OpenAI wire format extended with `reasoning_content`,
/// which is why it gets its own models instead of piggybacking on the
/// OpenAI ones.
@freezed
abstract class DeepSeekChatChunk with _$DeepSeekChatChunk {
  const factory DeepSeekChatChunk({
    @Default([]) List<DeepSeekChunkChoice> choices,
  }) = _DeepSeekChatChunk;

  factory DeepSeekChatChunk.fromJson(Map<String, dynamic> json) => _$DeepSeekChatChunkFromJson(json);
}

@freezed
abstract class DeepSeekChunkChoice with _$DeepSeekChunkChoice {
  const factory DeepSeekChunkChoice({DeepSeekChunkDelta? delta}) = _DeepSeekChunkChoice;

  factory DeepSeekChunkChoice.fromJson(Map<String, dynamic> json) => _$DeepSeekChunkChoiceFromJson(json);
}

@freezed
abstract class DeepSeekChunkDelta with _$DeepSeekChunkDelta {
  const factory DeepSeekChunkDelta({
    String? content,
    @JsonKey(name: 'reasoning_content') String? reasoningContent,
  }) = _DeepSeekChunkDelta;

  factory DeepSeekChunkDelta.fromJson(Map<String, dynamic> json) => _$DeepSeekChunkDeltaFromJson(json);
}
