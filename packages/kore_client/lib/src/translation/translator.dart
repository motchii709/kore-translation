import 'dart:async';

import 'package:kore_client/src/exceptions.dart';
import 'package:kore_client/src/translation/translation_models.dart';
import 'package:kore_client/src/translation/translation_response_parser.dart';
import 'package:llm_sdk_core/llm_sdk_core.dart';
import 'package:partial_json/partial_json.dart';

/// The one translation implementation, provider-blind: runs a single turn on
/// [session] and accumulates its stream into [TranslationEvent] snapshots —
/// thinking text is concatenated, and the reply is decoded leniently on
/// every delta into a provisional result, then parsed strictly once the
/// stream completes. The last event carries the complete, validated result.
///
/// [systemPrompt] is assembled by the frontend (and thus freely adjustable
/// by the user); its default includes [translationSchemaPrompt] so the reply
/// stays parsable. Whether thinking is requested is not a parameter here:
/// backends that can control it carry the setting in their own config.
Stream<TranslationEvent> streamTranslation(
  LlmSession session, {
  required String systemPrompt,
  required String text,
}) {
  final thinking = StringBuffer();
  final reply = StringBuffer();
  final partial = PartialJsonDecoder();
  TranslationResult? result;
  // Hand-rolled rather than async*: cancelling an async generator parked on
  // an idle inner stream only takes effect on the next event (the language
  // leaves the generator suspended), which would delay both switching
  // translations and the cancellation reaching the backend. The manual
  // controller detaches from [session] the moment the consumer cancels.
  late final StreamController<TranslationEvent> controller;
  late final StreamSubscription<LlmStreamEvent> events;
  controller = StreamController(
    onListen: () {
      events = session
          .streamText(system: systemPrompt, user: text, jsonOutput: true)
          .listen(
            (event) {
              switch (event) {
                case LlmThinkingDelta(:final text):
                  thinking.write(text);
                case LlmTextDelta(:final text):
                  reply.write(text);
                  partial.add(text);
                  final snapshot = tryPartialTranslationResult(partial.decode());
                  if (snapshot == null || snapshot == result) {
                    return; // This cut point renders nothing new.
                  }
                  result = snapshot;
              }
              controller.add(TranslationEvent(thinking: thinking.toString(), result: result));
            },
            onError: (Object error, StackTrace stackTrace) {
              controller.addError(error, stackTrace);
              unawaited(controller.close());
            },
            cancelOnError: true,
            onDone: () {
              try {
                if (reply.isEmpty) {
                  throw const KoreClientException('The API reply contains no translation');
                }
                controller.add(
                  TranslationEvent(thinking: thinking.toString(), result: parseTranslationResponse(reply.toString())),
                );
              } on Exception catch (error, stackTrace) {
                controller.addError(error, stackTrace);
              }
              unawaited(controller.close());
            },
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
/// the requested schema and the parsers (`parseTranslationResponse`,
/// `tryPartialTranslationResult`) stay in sync. Users may edit or remove it
/// from their prompt at their own risk; a broken reply surfaces raw.
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
