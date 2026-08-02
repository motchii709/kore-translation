import 'package:kore_client/src/translation/translation_models.dart';

/// A translation backend. UIs (Flutter app, CLI, TUI, ...) depend only on
/// this interface.
///
/// Concrete implementations pair one provider's thin LLM wrapper with the
/// shared translation pipeline, and are constructed at the composition root
/// (app providers, CLI main) by switching over the config variants.
abstract interface class TranslationClient {
  /// Streams progress snapshots; the last event carries the complete,
  /// strictly parsed result.
  ///
  /// [systemPrompt] is assembled by the frontend (and thus freely adjustable
  /// by the user); append [translationSchemaPrompt] to it so the reply stays
  /// parsable. Whether thinking is requested is not a request parameter:
  /// backends that can control it read it from their own config variant.
  Stream<TranslationEvent> streamTranslation({
    required String systemPrompt,
    required String text,
  });
}

/// Response-format instruction shared by every translation prompt.
///
/// Owned by kore_client and appended by frontends after their user-adjustable
/// instruction, so the requested schema and the parsers
/// (`parseTranslationResponse`, `tryPartialTranslationResult`) stay in sync.
const translationSchemaPrompt = '''
Respond with a JSON object only, using exactly this schema:
{
  "detected_language": "<name of the input language>",
  "target_language": "<name of the language translated into>",
  "translation": "<the best translation>",
  "alternatives": [
    {"text": "<alternative translation>", "nuance": "<short nuance note>"}
  ],
  "explanation": "<brief notes about nuance, word choice, and grammar>"
}
Provide 2 or 3 alternatives with meaningfully different nuances.
''';
