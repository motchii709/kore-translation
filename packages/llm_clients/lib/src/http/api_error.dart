import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:llm_clients/src/exceptions.dart';

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
    return;
  }
  final message = envelope.error?.message;
  if (message != null) {
    throw LlmApiException(message);
  }
}
