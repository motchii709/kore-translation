// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'acp_stream_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AcpAgentMessageChunk _$AcpAgentMessageChunkFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('AcpAgentMessageChunk', json, ($checkedConvert) {
  final val = AcpAgentMessageChunk(
    content: $checkedConvert(
      'content',
      (v) => AcpContentBlock.fromJson(v as Map<String, dynamic>),
    ),
    $type: $checkedConvert('sessionUpdate', (v) => v as String?),
  );
  return val;
}, fieldKeyMap: const {r'$type': 'sessionUpdate'});

Map<String, dynamic> _$AcpAgentMessageChunkToJson(
  AcpAgentMessageChunk instance,
) => <String, dynamic>{
  'content': instance.content,
  'sessionUpdate': instance.$type,
};

AcpAgentThoughtChunk _$AcpAgentThoughtChunkFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('AcpAgentThoughtChunk', json, ($checkedConvert) {
  final val = AcpAgentThoughtChunk(
    content: $checkedConvert(
      'content',
      (v) => AcpContentBlock.fromJson(v as Map<String, dynamic>),
    ),
    $type: $checkedConvert('sessionUpdate', (v) => v as String?),
  );
  return val;
}, fieldKeyMap: const {r'$type': 'sessionUpdate'});

Map<String, dynamic> _$AcpAgentThoughtChunkToJson(
  AcpAgentThoughtChunk instance,
) => <String, dynamic>{
  'content': instance.content,
  'sessionUpdate': instance.$type,
};

AcpUnknownUpdate _$AcpUnknownUpdateFromJson(Map<String, dynamic> json) =>
    $checkedCreate('AcpUnknownUpdate', json, ($checkedConvert) {
      final val = AcpUnknownUpdate(
        $type: $checkedConvert('sessionUpdate', (v) => v as String?),
      );
      return val;
    }, fieldKeyMap: const {r'$type': 'sessionUpdate'});

Map<String, dynamic> _$AcpUnknownUpdateToJson(AcpUnknownUpdate instance) =>
    <String, dynamic>{'sessionUpdate': instance.$type};

AcpTextContent _$AcpTextContentFromJson(Map<String, dynamic> json) =>
    $checkedCreate('AcpTextContent', json, ($checkedConvert) {
      final val = AcpTextContent(
        text: $checkedConvert('text', (v) => v as String),
        $type: $checkedConvert('type', (v) => v as String?),
      );
      return val;
    }, fieldKeyMap: const {r'$type': 'type'});

Map<String, dynamic> _$AcpTextContentToJson(AcpTextContent instance) =>
    <String, dynamic>{'text': instance.text, 'type': instance.$type};

AcpUnknownContent _$AcpUnknownContentFromJson(Map<String, dynamic> json) =>
    $checkedCreate('AcpUnknownContent', json, ($checkedConvert) {
      final val = AcpUnknownContent(
        $type: $checkedConvert('type', (v) => v as String?),
      );
      return val;
    }, fieldKeyMap: const {r'$type': 'type'});

Map<String, dynamic> _$AcpUnknownContentToJson(AcpUnknownContent instance) =>
    <String, dynamic>{'type': instance.$type};
