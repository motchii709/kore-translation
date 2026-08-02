import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:kore_client/src/exceptions.dart';
import 'package:kore_client/src/models/translation_models.dart';

/// Parses the JSON text returned by an LLM into a [TranslationResult].
TranslationResult parseTranslationResponse(String content) {
  try {
    final json = jsonDecode(_stripCodeFence(content));
    if (json is! Map<String, dynamic>) {
      throw const FormatException('response is not a JSON object');
    }
    return TranslationResult.fromJson(json);
  } on CheckedFromJsonException catch (e) {
    throw KoreClientException('LLMの応答が期待するスキーマと一致しません: ${e.message}');
  } on FormatException catch (e) {
    throw KoreClientException('LLMの応答をJSONとして解釈できませんでした: ${e.message}');
  }
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
