import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:kore_client/src/exceptions.dart';

/// Maps a [DioException] into a [KoreClientException] with a human-readable
/// message.
///
/// OpenAI, Anthropic and Google all report errors as
/// `{"error": {"message": ...}}`, so a single mapper suffices.
KoreClientException mapDioException(DioException e) {
  final statusCode = e.response?.statusCode;
  if (statusCode != null) {
    final message = _apiErrorMessage(e.response?.data) ??
        'APIリクエストが失敗しました (HTTP $statusCode)';
    return KoreClientException(message, statusCode: statusCode);
  }
  final message = switch (e.type) {
    DioExceptionType.connectionTimeout ||
    DioExceptionType.sendTimeout ||
    DioExceptionType.receiveTimeout =>
      'APIリクエストがタイムアウトしました',
    DioExceptionType.connectionError => 'APIに接続できませんでした',
    _ => e.message ?? '不明なエラーが発生しました',
  };
  return KoreClientException(message);
}

/// Error bodies are usually decoded to a `Map`, but some endpoints respond
/// with `content-type: text/plain`, leaving the JSON as an undecoded string.
String? _apiErrorMessage(Object? data) {
  final decoded = switch (data) {
    final String text => _tryJsonDecode(text),
    _ => data,
  };
  return switch (decoded) {
    {'error': {'message': final String message}} => message,
    _ => null,
  };
}

Object? _tryJsonDecode(String text) {
  try {
    return jsonDecode(text);
  } on FormatException {
    return null;
  }
}
