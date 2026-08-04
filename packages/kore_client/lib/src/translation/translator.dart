import 'dart:async';

import 'package:kore_client/src/translation/translation_models.dart';
import 'package:llm_sdk_core/llm_sdk_core.dart';

/// The one translation implementation, provider-blind: runs a single turn on
/// [session] and decodes its snapshots into [TranslationEvent]s. Every
/// [TranslationResult] field defaults to empty, so each partially completed
/// reply object decodes as-is and the result grows monotonically; the last
/// event is built from the complete turn. Empty [TranslationResult.translation]
/// on the last event (or no events at all) means the model never delivered a
/// translation — that judgement is the caller's.
///
/// [systemPrompt] is assembled by the frontend (and thus freely adjustable
/// by the user); its default includes [translationSchemaPrompt] so the reply
/// stays parsable. [thinking] is passed through to the turn; backends
/// without a thinking control ignore it.
Stream<TranslationEvent> streamTranslation(
  LlmSession session, {
  required String systemPrompt,
  required String text,
  required bool thinking,
}) {
  // Hand-rolled rather than async*: cancelling an async generator parked on
  // an idle inner stream only takes effect on the next event (the language
  // leaves the generator suspended), which would delay both switching
  // translations and the cancellation reaching the backend. The manual
  // controller detaches from [session] the moment the consumer cancels.
  late final StreamController<TranslationEvent> controller;
  late final StreamSubscription<TranslationEvent> events;
  controller = StreamController(
    onListen: () {
      events = session
          .streamObject(
            system: systemPrompt,
            user: text,
            thinking: thinking,
            decoder: (thinkingText, replyJson) {
              final result = TranslationResult.fromJson(replyJson ?? {});
              return TranslationEvent(sourceText: text, thinking: thinkingText, result: result);
            },
          )
          .listen(
            controller.add,
            onError: (Object error, StackTrace stackTrace) {
              controller.addError(error, stackTrace);
              unawaited(controller.close());
            },
            cancelOnError: true,
            onDone: () => unawaited(controller.close()),
          );
    },
    onPause: () => events.pause(),
    onResume: () => events.resume(),
    onCancel: () => events.cancel(),
  );
  return controller.stream;
}

/// Response-format instruction shared by every translation prompt.
///
/// Owned by kore_client and seeded into the frontends' default prompts, so
/// the requested schema and [TranslationResult.fromJson] stay in sync. Users
/// may edit or remove it from their prompt at their own risk; a reply that
/// stops matching simply leaves the affected fields empty.
const translationSchemaPrompt = '''
Respond with a JSON object only, using exactly this schema:
{
  "detected_language": "<name of the input language>",
  "target_language": "<name of the language translated into>",
  "translation": "<the best translation>",
  "explanation": "<brief notes about nuance, word choice, and grammar>",
  "alternatives": [
    {"text": "<alternative translation>", "nuance": "<short nuance note>"}
  ]
}
Provide 2 or 3 alternatives with meaningfully different nuances.
''';

/// Response-format instruction for proofread prompts: no language pair (the
/// text stays in its own language) and the notes ride in `proofread` rather
/// than `explanation` — its presence is what lets UIs label the result as a
/// proofread. The corrected text rides in `translation`, so the result
/// flows through the same decoding, storage and result pane.
const proofreadSchemaPrompt = '''
Respond with a JSON object only, using exactly this schema:
{
  "translation": "<the corrected text>",
  "proofread": "<brief notes about what was corrected and why>",
  "alternatives": [
    {"text": "<alternative correction>", "nuance": "<short nuance note>"}
  ]
}
Provide 2 or 3 alternatives with meaningfully different nuances.
''';
