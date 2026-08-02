// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'open_ai_compatible_stream_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OpenAiCompatibleChatChunk _$OpenAiCompatibleChatChunkFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_OpenAiCompatibleChatChunk', json, ($checkedConvert) {
  final val = _OpenAiCompatibleChatChunk(
    choices: $checkedConvert(
      'choices',
      (v) =>
          (v as List<dynamic>?)
              ?.map(
                (e) => OpenAiCompatibleChunkChoice.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList() ??
          const [],
    ),
  );
  return val;
});

Map<String, dynamic> _$OpenAiCompatibleChatChunkToJson(
  _OpenAiCompatibleChatChunk instance,
) => <String, dynamic>{'choices': instance.choices};

_OpenAiCompatibleChunkChoice _$OpenAiCompatibleChunkChoiceFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_OpenAiCompatibleChunkChoice', json, ($checkedConvert) {
  final val = _OpenAiCompatibleChunkChoice(
    delta: $checkedConvert(
      'delta',
      (v) => v == null
          ? null
          : OpenAiCompatibleChunkDelta.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$OpenAiCompatibleChunkChoiceToJson(
  _OpenAiCompatibleChunkChoice instance,
) => <String, dynamic>{'delta': instance.delta};

_OpenAiCompatibleChunkDelta _$OpenAiCompatibleChunkDeltaFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_OpenAiCompatibleChunkDelta', json, ($checkedConvert) {
  final val = _OpenAiCompatibleChunkDelta(
    content: $checkedConvert('content', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$OpenAiCompatibleChunkDeltaToJson(
  _OpenAiCompatibleChunkDelta instance,
) => <String, dynamic>{'content': instance.content};
