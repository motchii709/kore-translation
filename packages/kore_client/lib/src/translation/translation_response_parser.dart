import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:kore_client/src/exceptions.dart';
import 'package:kore_client/src/translation/translation_models.dart';

/// Parses the JSON text returned by an LLM into a [TranslationResult].
TranslationResult parseTranslationResponse(String content) {
  try {
    final json = jsonDecode(_stripCodeFence(content));
    if (json is! Map<String, dynamic>) {
      throw const FormatException('response is not a JSON object');
    }
    return TranslationResult.fromJson(json);
  } on CheckedFromJsonException catch (e) {
    throw KoreClientException(
      'The API reply does not match the expected schema: ${e.message}',
    );
  } on FormatException catch (e) {
    throw KoreClientException('The API reply is not valid JSON: ${e.message}');
  }
}

/// Converts a snapshot decoded from the in-progress reply (see
/// `PartialJsonDecoder`) into a provisional [TranslationResult], or null
/// when it is not renderable yet: not a JSON object, a schema mismatch at
/// this cut point (e.g. an alternative whose required text has not arrived),
/// or no translation text to show.
TranslationResult? tryPartialTranslationResult(Object? json) {
  if (json is! Map<String, dynamic>) {
    return null;
  }
  final TranslationResult result;
  try {
    result = TranslationResult.fromJson(json);
  } on CheckedFromJsonException {
    return null;
  }
  return result.translation.isEmpty ? null : result;
}

/// Some models wrap JSON in a Markdown code fence despite instructions.
String _stripCodeFence(String content) {
  final trimmed = content.trim();
  if (!trimmed.startsWith('```')) {
    return trimmed;
  }
  final lines = trimmed.split('\n');
  final endsWithFence = lines.length > 1 && lines.last.trim() == '```';
  return lines.sublist(1, endsWithFence ? lines.length - 1 : null).join('\n');
}
