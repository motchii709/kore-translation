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
@freezed
abstract class TranslationRequest with _$TranslationRequest {
  const factory TranslationRequest({
    required String text,
    required String targetLanguage,
    @Default(ToneStyle.auto) ToneStyle tone,
    @Default('日本語') String explanationLanguage,
  }) = _TranslationRequest;
}

/// An alternative translation with a short nuance note.
@freezed
abstract class TranslationCandidate with _$TranslationCandidate {
  const factory TranslationCandidate({
    required String text,
    @Default('') String nuance,
  }) = _TranslationCandidate;

  factory TranslationCandidate.fromJson(Map<String, dynamic> json) =>
      _$TranslationCandidateFromJson(json);
}

/// The full result of a translation request.
@freezed
abstract class TranslationResult with _$TranslationResult {
  const factory TranslationResult({
    required String translation,
    @JsonKey(name: 'detected_language') @Default('') String detectedLanguage,
    @Default([]) List<TranslationCandidate> alternatives,
    @Default('') String explanation,
  }) = _TranslationResult;

  factory TranslationResult.fromJson(Map<String, dynamic> json) =>
      _$TranslationResultFromJson(json);
}
