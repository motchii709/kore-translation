import 'package:kore_client/src/models/translation_models.dart';

/// Builds the system prompt shared by every LLM backend.
final class TranslationPromptBuilder {
  const TranslationPromptBuilder(this.request);

  final TranslationRequest request;

  String build() {
    final targetLanguage = request.targetLanguage;
    final explanationLanguage = request.explanationLanguage;
    return '''
You are a professional translator. Translate the user's text into $targetLanguage.
${request.tone.instruction}
Respond with a JSON object only, using exactly this schema:
{
  "detected_language": "<name of the input language, written in $explanationLanguage>",
  "translation": "<the best translation>",
  "alternatives": [
    {"text": "<alternative translation>", "nuance": "<short nuance note in $explanationLanguage>"}
  ],
  "explanation": "<brief notes in $explanationLanguage about nuance, word choice, and grammar>"
}
Provide 2 or 3 alternatives with meaningfully different nuances.
''';
  }
}
