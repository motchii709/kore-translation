import 'dart:async';

import 'package:kore_client/src/translation/translation_models.dart';
import 'package:kore_client/src/translation/translation_snapshot_stream.dart';

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
/// concatenated, reply text is assembled via [translationResultStream].
///
/// The shared core of every `TranslationClient` implementation, composed
/// rather than inherited so the implementations stay flat.
Stream<TranslationEvent> assembleTranslationEvents(
  Stream<TranslationDelta> deltas,
) {
  final output = StreamController<TranslationEvent>();
  final thinking = StringBuffer();
  TranslationResult? lastResult;

  void emit() {
    if (!output.isClosed) {
      output.add(
        TranslationEvent(thinking: thinking.toString(), result: lastResult),
      );
    }
  }

  final jsonDeltas = StreamController<String>();
  final resultSubscription = translationResultStream(jsonDeltas.stream).listen(
    (result) {
      lastResult = result;
      emit();
    },
    onError: output.addError,
    // The result stream completing means the final result has been emitted,
    // so the output can close here.
    onDone: () => unawaited(output.close()),
    cancelOnError: false,
  );

  late final StreamSubscription<TranslationDelta> deltaSubscription;
  deltaSubscription = deltas.listen(
    (delta) {
      switch (delta) {
        case TranslationThinkingDelta(:final delta):
          thinking.write(delta);
          emit();
        case TranslationTextDelta(:final delta):
          jsonDeltas.add(delta);
      }
    },
    onError: (Object error, StackTrace stackTrace) async {
      output.addError(error, stackTrace);
      await resultSubscription.cancel();
      await output.close();
    },
    onDone: () => unawaited(jsonDeltas.close()),
    cancelOnError: true,
  );

  output.onCancel = () async {
    await deltaSubscription.cancel();
    await resultSubscription.cancel();
    if (!jsonDeltas.isClosed) {
      await jsonDeltas.close();
    }
  };
  return output.stream;
}
