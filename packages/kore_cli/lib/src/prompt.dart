import 'package:kore_client/kore_client.dart';

/// Builds the system prompt for one translation. A non-empty [customPrompt]
/// (the llm block's `system_prompt`) is the whole prompt, used verbatim —
/// response-format instructions included, at the user's own risk. Only the
/// built-in default carries kore_client's response schema itself.
String buildCliSystemPrompt({
  required String targetLanguage,
  required String toneInstruction,
  String customPrompt = '',
}) {
  if (customPrompt.isNotEmpty) {
    return customPrompt;
  }
  return [
    "You are a professional translator. Translate the user's text into $targetLanguage.",
    if (toneInstruction.isNotEmpty) toneInstruction,
    'Write detected_language, target_language, nuance and explanation in 日本語.',
    translationSchemaPrompt,
  ].join('\n');
}
