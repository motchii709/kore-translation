import 'package:freezed_annotation/freezed_annotation.dart';

part 'open_ai_stream_models.freezed.dart';
part 'open_ai_stream_models.g.dart';

/// One SSE chunk of an OpenAI-compatible Chat Completions stream.
@freezed
abstract class OpenAiChatChunk with _$OpenAiChatChunk {
  const factory OpenAiChatChunk({
    @Default([]) List<OpenAiChunkChoice> choices,
  }) = _OpenAiChatChunk;

  factory OpenAiChatChunk.fromJson(Map<String, dynamic> json) => _$OpenAiChatChunkFromJson(json);
}

@freezed
abstract class OpenAiChunkChoice with _$OpenAiChunkChoice {
  const factory OpenAiChunkChoice({OpenAiChunkDelta? delta}) = _OpenAiChunkChoice;

  factory OpenAiChunkChoice.fromJson(Map<String, dynamic> json) => _$OpenAiChunkChoiceFromJson(json);
}

@freezed
abstract class OpenAiChunkDelta with _$OpenAiChunkDelta {
  const factory OpenAiChunkDelta({String? content}) = _OpenAiChunkDelta;

  factory OpenAiChunkDelta.fromJson(Map<String, dynamic> json) => _$OpenAiChunkDeltaFromJson(json);
}
