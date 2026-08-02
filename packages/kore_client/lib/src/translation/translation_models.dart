import 'package:freezed_annotation/freezed_annotation.dart';

part 'translation_models.freezed.dart';
part 'translation_models.g.dart';

/// Tone hint passed to the LLM.
enum ToneStyle {
  auto('自動', 'Choose a natural tone for the context.'),
  casual('カジュアル', 'Use a casual, friendly tone.'),
  formal('フォーマル', 'Use a formal, polite tone.');

  const ToneStyle(this.label, this.instruction);

  final String label;

  /// Instruction sentence embedded into the prompt.
  final String instruction;
}

/// A single translation request, independent of any LLM backend.
///
/// [thinking] is a neutral intent; each `TranslationClient` implementation
/// maps it to its provider's parameters (or ignores it when unsupported).
@freezed
abstract class TranslationRequest with _$TranslationRequest {
  const factory TranslationRequest({
    required String text,
    required String targetLanguage,
    @Default(ToneStyle.auto) ToneStyle tone,
    @Default('日本語') String explanationLanguage,
    @Default(true) bool thinking,
  }) = _TranslationRequest;
}

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
    @Default([]) List<TranslationCandidate> alternatives,
    @Default('') String explanation,
  }) = _TranslationResult;

  factory TranslationResult.fromJson(Map<String, dynamic> json) => _$TranslationResultFromJson(json);
}
