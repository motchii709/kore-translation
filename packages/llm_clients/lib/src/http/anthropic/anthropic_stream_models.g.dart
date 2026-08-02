// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anthropic_stream_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnthropicContentBlockDeltaEvent _$AnthropicContentBlockDeltaEventFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('AnthropicContentBlockDeltaEvent', json, ($checkedConvert) {
  final val = AnthropicContentBlockDeltaEvent(
    delta: $checkedConvert(
      'delta',
      (v) => AnthropicDelta.fromJson(v as Map<String, dynamic>),
    ),
    $type: $checkedConvert('type', (v) => v as String?),
  );
  return val;
}, fieldKeyMap: const {r'$type': 'type'});

Map<String, dynamic> _$AnthropicContentBlockDeltaEventToJson(
  AnthropicContentBlockDeltaEvent instance,
) => <String, dynamic>{'delta': instance.delta, 'type': instance.$type};

AnthropicUnknownEvent _$AnthropicUnknownEventFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('AnthropicUnknownEvent', json, ($checkedConvert) {
  final val = AnthropicUnknownEvent(
    $type: $checkedConvert('type', (v) => v as String?),
  );
  return val;
}, fieldKeyMap: const {r'$type': 'type'});

Map<String, dynamic> _$AnthropicUnknownEventToJson(
  AnthropicUnknownEvent instance,
) => <String, dynamic>{'type': instance.$type};

AnthropicTextDelta _$AnthropicTextDeltaFromJson(Map<String, dynamic> json) =>
    $checkedCreate('AnthropicTextDelta', json, ($checkedConvert) {
      final val = AnthropicTextDelta(
        text: $checkedConvert('text', (v) => v as String),
        $type: $checkedConvert('type', (v) => v as String?),
      );
      return val;
    }, fieldKeyMap: const {r'$type': 'type'});

Map<String, dynamic> _$AnthropicTextDeltaToJson(AnthropicTextDelta instance) =>
    <String, dynamic>{'text': instance.text, 'type': instance.$type};

AnthropicThinkingDelta _$AnthropicThinkingDeltaFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('AnthropicThinkingDelta', json, ($checkedConvert) {
  final val = AnthropicThinkingDelta(
    thinking: $checkedConvert('thinking', (v) => v as String),
    $type: $checkedConvert('type', (v) => v as String?),
  );
  return val;
}, fieldKeyMap: const {r'$type': 'type'});

Map<String, dynamic> _$AnthropicThinkingDeltaToJson(
  AnthropicThinkingDelta instance,
) => <String, dynamic>{'thinking': instance.thinking, 'type': instance.$type};

AnthropicUnknownDelta _$AnthropicUnknownDeltaFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('AnthropicUnknownDelta', json, ($checkedConvert) {
  final val = AnthropicUnknownDelta(
    $type: $checkedConvert('type', (v) => v as String?),
  );
  return val;
}, fieldKeyMap: const {r'$type': 'type'});

Map<String, dynamic> _$AnthropicUnknownDeltaToJson(
  AnthropicUnknownDelta instance,
) => <String, dynamic>{'type': instance.$type};
