import 'package:freezed_annotation/freezed_annotation.dart';

part 'open_ai_compatible_stream_models.freezed.dart';
part 'open_ai_compatible_stream_models.g.dart';

/// One SSE chunk of a generic OpenAI-compatible Chat Completions stream.
///
/// Models the conservative baseline of the wire-format family — dialect
/// extensions (DeepSeek's `reasoning_content`, OpenRouter's `reasoning`, ...)
/// belong to their own clients.
@freezed
abstract class OpenAiCompatibleChatChunk with _$OpenAiCompatibleChatChunk {
  const factory OpenAiCompatibleChatChunk({
    @Default([]) List<OpenAiCompatibleChunkChoice> choices,
  }) = _OpenAiCompatibleChatChunk;

  factory OpenAiCompatibleChatChunk.fromJson(Map<String, dynamic> json) => _$OpenAiCompatibleChatChunkFromJson(json);
}

@freezed
abstract class OpenAiCompatibleChunkChoice with _$OpenAiCompatibleChunkChoice {
  const factory OpenAiCompatibleChunkChoice({OpenAiCompatibleChunkDelta? delta}) = _OpenAiCompatibleChunkChoice;

  factory OpenAiCompatibleChunkChoice.fromJson(Map<String, dynamic> json) =>
      _$OpenAiCompatibleChunkChoiceFromJson(json);
}

@freezed
abstract class OpenAiCompatibleChunkDelta with _$OpenAiCompatibleChunkDelta {
  const factory OpenAiCompatibleChunkDelta({String? content}) = _OpenAiCompatibleChunkDelta;

  factory OpenAiCompatibleChunkDelta.fromJson(Map<String, dynamic> json) => _$OpenAiCompatibleChunkDeltaFromJson(json);
}
