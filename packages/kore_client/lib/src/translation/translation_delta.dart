import 'package:kore_client/src/exceptions.dart';
import 'package:kore_client/src/translation/translation_models.dart';
import 'package:kore_client/src/translation/translation_response_parser.dart';
import 'package:partial_json/partial_json.dart';

/// A neutral delta extracted from provider-specific stream objects by the
/// `TranslationClient` implementations.
sealed class TranslationDelta {
  const TranslationDelta(this.delta);

  final String delta;
}

/// A fragment of the model's reasoning process.
final class TranslationThinkingDelta extends TranslationDelta {
  const TranslationThinkingDelta(super.delta);
}

/// A fragment of the reply body (the translation JSON).
final class TranslationTextDelta extends TranslationDelta {
  const TranslationTextDelta(super.delta);
}

/// Accumulates [deltas] into [TranslationEvent] snapshots: thinking text is
/// concatenated, and the reply is decoded leniently on every delta into a
/// provisional result, then parsed strictly once [deltas] completes.
///
/// Each event carries the full accumulated state. The shared core of every
/// `TranslationClient` implementation, composed rather than inherited so the
/// implementations stay flat.
Stream<TranslationEvent> assembleTranslationEvents(
  Stream<TranslationDelta> deltas,
) async* {
  final thinking = StringBuffer();
  final reply = StringBuffer();
  final partial = PartialJsonDecoder();
  TranslationResult? result;
  await for (final delta in deltas) {
    switch (delta) {
      case TranslationThinkingDelta(:final delta):
        thinking.write(delta);
      case TranslationTextDelta(:final delta):
        reply.write(delta);
        partial.add(delta);
        final snapshot = tryPartialTranslationResult(partial.decode());
        if (snapshot == null || snapshot == result) {
          continue; // This cut point renders nothing new.
        }
        result = snapshot;
    }
    yield TranslationEvent(thinking: thinking.toString(), result: result);
  }
  if (reply.isEmpty) {
    throw const KoreClientException('The API reply contains no translation');
  }
  yield TranslationEvent(
    thinking: thinking.toString(),
    result: parseTranslationResponse(reply.toString()),
  );
}
