import 'package:kore_client/kore_client.dart';

/// Builds the system prompt for one translation. [customPrompt] (from
/// `--prompt`) replaces the built-in instruction; kore_client's response
/// schema is always appended so the reply stays parsable.
String buildCliSystemPrompt({
  required String targetLanguage,
  required String toneInstruction,
  String? customPrompt,
}) {
  final instruction =
      customPrompt ??
      [
        "You are a professional translator. Translate the user's text into $targetLanguage.",
        if (toneInstruction.isNotEmpty) toneInstruction,
        'Write detected_language, nuance and explanation in 日本語.',
      ].join('\n');
  return '$instruction\n$translationSchemaPrompt';
}
