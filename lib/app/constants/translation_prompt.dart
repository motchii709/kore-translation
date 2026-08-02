import 'package:kore_client/kore_client.dart';

/// Default system prompt template. Users can replace it in the settings;
/// `{{target}}` and `{{tone}}` are substituted on every request.
const defaultTranslationPromptTemplate = '''
You are a professional translator. Translate the user's text into {{target}}.
{{tone}}
Write detected_language, nuance and explanation in 日本語.''';

/// Composes the final system prompt: the user-adjustable instruction with its
/// placeholders filled in, followed by the response schema kore_client's
/// parsers rely on.
String buildTranslationSystemPrompt({
  required String template,
  required String targetLanguage,
  required String toneInstruction,
}) {
  final instruction = template.replaceAll('{{target}}', targetLanguage).replaceAll('{{tone}}', toneInstruction);
  return '$instruction\n$translationSchemaPrompt';
}
