// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translation_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TranslationCandidate _$TranslationCandidateFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_TranslationCandidate', json, ($checkedConvert) {
  final val = _TranslationCandidate(
    text: $checkedConvert('text', (v) => v as String?),
    nuance: $checkedConvert('nuance', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$TranslationCandidateToJson(
  _TranslationCandidate instance,
) => <String, dynamic>{'text': instance.text, 'nuance': instance.nuance};

_TranslationResult _$TranslationResultFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_TranslationResult',
      json,
      ($checkedConvert) {
        final val = _TranslationResult(
          translation: $checkedConvert('translation', (v) => v as String?),
          detectedLanguage: $checkedConvert(
            'detected_language',
            (v) => v as String?,
          ),
          targetLanguage: $checkedConvert(
            'target_language',
            (v) => v as String?,
          ),
          explanation: $checkedConvert('explanation', (v) => v as String?),
          proofread: $checkedConvert('proofread', (v) => v as String?),
          alternatives: $checkedConvert(
            'alternatives',
            (v) => (v as List<dynamic>?)
                ?.map(
                  (e) =>
                      TranslationCandidate.fromJson(e as Map<String, dynamic>),
                )
                .toList(),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'detectedLanguage': 'detected_language',
        'targetLanguage': 'target_language',
      },
    );

Map<String, dynamic> _$TranslationResultToJson(_TranslationResult instance) =>
    <String, dynamic>{
      'translation': instance.translation,
      'detected_language': instance.detectedLanguage,
      'target_language': instance.targetLanguage,
      'explanation': instance.explanation,
      'proofread': instance.proofread,
      'alternatives': instance.alternatives,
    };
