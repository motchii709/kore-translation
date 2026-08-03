import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:llm_sdk_core/llm_sdk_core.dart';

part 'api_error.freezed.dart';
part 'api_error.g.dart';

/// OpenAI, Anthropic and Google all report errors as
/// `{"error": {"message": ...}}`.
@freezed
abstract class ApiErrorEnvelope with _$ApiErrorEnvelope {
  const factory ApiErrorEnvelope({ApiErrorDetail? error}) = _ApiErrorEnvelope;

  factory ApiErrorEnvelope.fromJson(Map<String, dynamic> json) => _$ApiErrorEnvelopeFromJson(json);
}

@freezed
abstract class ApiErrorDetail with _$ApiErrorDetail {
  const factory ApiErrorDetail({String? message}) = _ApiErrorDetail;

  factory ApiErrorDetail.fromJson(Map<String, dynamic> json) => _$ApiErrorDetailFromJson(json);
}

/// Throws when [json] is an API error event (`{"error": {"message": ...}}`).
void throwIfApiError(Map<String, dynamic> json) {
  final ApiErrorEnvelope envelope;
  try {
    envelope = ApiErrorEnvelope.fromJson(json);
  } on CheckedFromJsonException {
    // Not the standard envelope shape. An `error` key is still a reported
    // failure, though — carry it raw rather than letting it degrade into a
    // generic parse error downstream.
    if (json case {'error': final Object error}) {
      throw LlmApiException(jsonEncode(error));
    }
    return;
  }
  final message = envelope.error?.message;
  if (message != null) {
    throw LlmApiException(message);
  }
  if (envelope.error != null) {
    // An error object without the standard message field is still a
    // reported failure — carry it raw.
    throw LlmApiException(jsonEncode(json['error']));
  }
}
