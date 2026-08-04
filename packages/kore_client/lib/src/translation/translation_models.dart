import 'package:freezed_annotation/freezed_annotation.dart';

part 'translation_models.freezed.dart';
part 'translation_models.g.dart';

/// An alternative translation with a short nuance note.
@freezed
abstract class TranslationCandidate with _$TranslationCandidate {
  const factory TranslationCandidate({
    String? text,
    String? nuance,
  }) = _TranslationCandidate;

  factory TranslationCandidate.fromJson(Map<String, dynamic> json) => _$TranslationCandidateFromJson(json);
}

/// A streaming progress snapshot: the text being translated, the model's
/// reasoning so far, plus the translation assembled so far.
///
/// Each event carries the full accumulated state, so consumers can map or
/// assign it declaratively — no per-delta bookkeeping.
@freezed
abstract class TranslationEvent with _$TranslationEvent {
  const factory TranslationEvent({
    /// The source text of the request this event belongs to, so consumers
    /// can keep showing it after the input moved on.
    String? sourceText,
    String? thinking,
    TranslationResult? result,
  }) = _TranslationEvent;
}

/// The full result of a translation request.
///
/// Every field defaults to empty, so any snapshot of the streamed reply
/// object decodes (`LlmSession.streamObject` hands the decoder partially
/// completed objects). Empty means the value has not arrived yet (while
/// streaming) or was not provided by the model — UIs rely on this
/// convention to skip rendering absent sections.
@freezed
abstract class TranslationResult with _$TranslationResult {
  const factory TranslationResult({
    String? translation,
    @JsonKey(name: 'detected_language') String? detectedLanguage,

    /// The language the model translated into — its own decision whenever
    /// the request leaves the choice to it (language pairing).
    @JsonKey(name: 'target_language') String? targetLanguage,
    String? explanation,

    /// Correction notes from a proofread request. Its presence is what marks
    /// a result as a proofread — translations carry [explanation] instead.
    String? proofread,
    List<TranslationCandidate>? alternatives,
  }) = _TranslationResult;

  factory TranslationResult.fromJson(Map<String, dynamic> json) => _$TranslationResultFromJson(json);
}
