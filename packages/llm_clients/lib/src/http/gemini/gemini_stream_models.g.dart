// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gemini_stream_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GeminiStreamChunk _$GeminiStreamChunkFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_GeminiStreamChunk', json, ($checkedConvert) {
      final val = _GeminiStreamChunk(
        candidates: $checkedConvert(
          'candidates',
          (v) =>
              (v as List<dynamic>?)
                  ?.map(
                    (e) => GeminiCandidate.fromJson(e as Map<String, dynamic>),
                  )
                  .toList() ??
              const [],
        ),
      );
      return val;
    });

Map<String, dynamic> _$GeminiStreamChunkToJson(_GeminiStreamChunk instance) =>
    <String, dynamic>{'candidates': instance.candidates};

_GeminiCandidate _$GeminiCandidateFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_GeminiCandidate', json, ($checkedConvert) {
      final val = _GeminiCandidate(
        content: $checkedConvert(
          'content',
          (v) => v == null
              ? null
              : GeminiContent.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$GeminiCandidateToJson(_GeminiCandidate instance) =>
    <String, dynamic>{'content': instance.content};

_GeminiContent _$GeminiContentFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_GeminiContent', json, ($checkedConvert) {
      final val = _GeminiContent(
        parts: $checkedConvert(
          'parts',
          (v) =>
              (v as List<dynamic>?)
                  ?.map((e) => GeminiPart.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              const [],
        ),
      );
      return val;
    });

Map<String, dynamic> _$GeminiContentToJson(_GeminiContent instance) =>
    <String, dynamic>{'parts': instance.parts};

_GeminiPart _$GeminiPartFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_GeminiPart', json, ($checkedConvert) {
      final val = _GeminiPart(
        text: $checkedConvert('text', (v) => v as String?),
        thought: $checkedConvert('thought', (v) => v as bool? ?? false),
      );
      return val;
    });

Map<String, dynamic> _$GeminiPartToJson(_GeminiPart instance) =>
    <String, dynamic>{'text': instance.text, 'thought': instance.thought};
