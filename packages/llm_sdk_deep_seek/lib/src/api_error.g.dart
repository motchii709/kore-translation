// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ApiErrorEnvelope _$ApiErrorEnvelopeFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_ApiErrorEnvelope', json, ($checkedConvert) {
      final val = _ApiErrorEnvelope(
        error: $checkedConvert(
          'error',
          (v) => v == null ? null : ApiErrorDetail.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$ApiErrorEnvelopeToJson(_ApiErrorEnvelope instance) => <String, dynamic>{'error': instance.error};

_ApiErrorDetail _$ApiErrorDetailFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_ApiErrorDetail', json, ($checkedConvert) {
      final val = _ApiErrorDetail(
        message: $checkedConvert('message', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$ApiErrorDetailToJson(_ApiErrorDetail instance) => <String, dynamic>{'message': instance.message};
