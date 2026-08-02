// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'open_ai_stream_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OpenAiChatChunk _$OpenAiChatChunkFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_OpenAiChatChunk', json, ($checkedConvert) {
      final val = _OpenAiChatChunk(
        choices: $checkedConvert(
          'choices',
          (v) =>
              (v as List<dynamic>?)
                  ?.map(
                    (e) =>
                        OpenAiChunkChoice.fromJson(e as Map<String, dynamic>),
                  )
                  .toList() ??
              const [],
        ),
      );
      return val;
    });

Map<String, dynamic> _$OpenAiChatChunkToJson(_OpenAiChatChunk instance) =>
    <String, dynamic>{'choices': instance.choices};

_OpenAiChunkChoice _$OpenAiChunkChoiceFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_OpenAiChunkChoice', json, ($checkedConvert) {
      final val = _OpenAiChunkChoice(
        delta: $checkedConvert(
          'delta',
          (v) => v == null
              ? null
              : OpenAiChunkDelta.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$OpenAiChunkChoiceToJson(_OpenAiChunkChoice instance) =>
    <String, dynamic>{'delta': instance.delta};

_OpenAiChunkDelta _$OpenAiChunkDeltaFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_OpenAiChunkDelta', json, ($checkedConvert) {
      final val = _OpenAiChunkDelta(
        content: $checkedConvert('content', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$OpenAiChunkDeltaToJson(_OpenAiChunkDelta instance) =>
    <String, dynamic>{'content': instance.content};
