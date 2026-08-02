import 'package:freezed_annotation/freezed_annotation.dart';

part 'gemini_stream_models.freezed.dart';
part 'gemini_stream_models.g.dart';

/// One SSE chunk of a Google AI (Gemini) streamGenerateContent stream.
@freezed
abstract class GeminiStreamChunk with _$GeminiStreamChunk {
  const factory GeminiStreamChunk({
    @Default([]) List<GeminiCandidate> candidates,
  }) = _GeminiStreamChunk;

  factory GeminiStreamChunk.fromJson(Map<String, dynamic> json) => _$GeminiStreamChunkFromJson(json);
}

@freezed
abstract class GeminiCandidate with _$GeminiCandidate {
  const factory GeminiCandidate({GeminiContent? content}) = _GeminiCandidate;

  factory GeminiCandidate.fromJson(Map<String, dynamic> json) => _$GeminiCandidateFromJson(json);
}

@freezed
abstract class GeminiContent with _$GeminiContent {
  const factory GeminiContent({@Default([]) List<GeminiPart> parts}) = _GeminiContent;

  factory GeminiContent.fromJson(Map<String, dynamic> json) => _$GeminiContentFromJson(json);
}

@freezed
abstract class GeminiPart with _$GeminiPart {
  const factory GeminiPart({
    String? text,
    // Reasoning-summary parts are flagged with `thought: true`.
    @Default(false) bool thought,
  }) = _GeminiPart;

  factory GeminiPart.fromJson(Map<String, dynamic> json) => _$GeminiPartFromJson(json);
}
