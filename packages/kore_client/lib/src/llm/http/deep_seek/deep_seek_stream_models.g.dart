// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deep_seek_stream_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DeepSeekChatChunk _$DeepSeekChatChunkFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_DeepSeekChatChunk', json, ($checkedConvert) {
      final val = _DeepSeekChatChunk(
        choices: $checkedConvert(
          'choices',
          (v) =>
              (v as List<dynamic>?)
                  ?.map(
                    (e) => DeepSeekChunkChoice.fromJson(e as Map<String, dynamic>),
                  )
                  .toList() ??
              const [],
        ),
      );
      return val;
    });

Map<String, dynamic> _$DeepSeekChatChunkToJson(_DeepSeekChatChunk instance) => <String, dynamic>{
  'choices': instance.choices,
};

_DeepSeekChunkChoice _$DeepSeekChunkChoiceFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_DeepSeekChunkChoice', json, ($checkedConvert) {
      final val = _DeepSeekChunkChoice(
        delta: $checkedConvert(
          'delta',
          (v) => v == null ? null : DeepSeekChunkDelta.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$DeepSeekChunkChoiceToJson(
  _DeepSeekChunkChoice instance,
) => <String, dynamic>{'delta': instance.delta};

_DeepSeekChunkDelta _$DeepSeekChunkDeltaFromJson(Map<String, dynamic> json) => $checkedCreate(
  '_DeepSeekChunkDelta',
  json,
  ($checkedConvert) {
    final val = _DeepSeekChunkDelta(
      content: $checkedConvert('content', (v) => v as String?),
      reasoningContent: $checkedConvert(
        'reasoning_content',
        (v) => v as String?,
      ),
    );
    return val;
  },
  fieldKeyMap: const {'reasoningContent': 'reasoning_content'},
);

Map<String, dynamic> _$DeepSeekChunkDeltaToJson(_DeepSeekChunkDelta instance) => <String, dynamic>{
  'content': instance.content,
  'reasoning_content': instance.reasoningContent,
};
