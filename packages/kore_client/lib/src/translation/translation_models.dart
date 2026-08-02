import 'package:freezed_annotation/freezed_annotation.dart';

part 'translation_models.freezed.dart';
part 'translation_models.g.dart';

/// An alternative translation with a short nuance note.
@freezed
abstract class TranslationCandidate with _$TranslationCandidate {
  const factory TranslationCandidate({
    required String text,
    @Default('') String nuance,
  }) = _TranslationCandidate;

  factory TranslationCandidate.fromJson(Map<String, dynamic> json) => _$TranslationCandidateFromJson(json);
}

/// A streaming progress snapshot: the model's reasoning so far, plus the
/// translation assembled so far.
///
/// Each event carries the full accumulated state, so consumers can map or
/// assign it declaratively — no per-delta bookkeeping.
@freezed
abstract class TranslationEvent with _$TranslationEvent {
  const factory TranslationEvent({
    @Default('') String thinking,
    TranslationResult? result,
  }) = _TranslationEvent;
}

/// The full result of a translation request.
///
/// Fields other than [translation] default to empty. Empty means the value
/// has not arrived yet (while streaming) or was not provided by the model —
/// UIs rely on this convention to skip rendering absent sections.
@freezed
abstract class TranslationResult with _$TranslationResult {
  const factory TranslationResult({
    required String translation,
    @JsonKey(name: 'detected_language') @Default('') String detectedLanguage,

    /// The language the model translated into — its own decision whenever
    /// the request leaves the choice to it (language pairing).
    @JsonKey(name: 'target_language') @Default('') String targetLanguage,
    @Default('') String explanation,
    @Default([]) List<TranslationCandidate> alternatives,
  }) = _TranslationResult;

  factory TranslationResult.fromJson(Map<String, dynamic> json) => _$TranslationResultFromJson(json);
}
