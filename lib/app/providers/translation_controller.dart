import 'dart:async';
import 'dart:convert';

import 'package:kore_client/kore_client.dart';
import 'package:kore_translation/app/providers/app_database_provider.dart';
import 'package:kore_translation/app/providers/history_provider.dart';
import 'package:kore_translation/app/providers/translation_client_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'translation_controller.g.dart';

/// Holds the latest translation progress. `null` means nothing has been
/// translated yet. While streaming, the model's thinking and progressively
/// richer results are reflected into [state]; the last event carries the
/// validated final result, which is also appended to the history.
@riverpod
class TranslationController extends _$TranslationController {
  StreamSubscription<TranslationEvent>? _subscription;

  @override
  Future<TranslationEvent?> build() async {
    ref.onDispose(() => unawaited(_subscription?.cancel()));
    return null;
  }

  /// Cancels the previous request (if any) and starts a new streaming
  /// translation.
  Future<void> translate({
    required String systemPrompt,
    required String text,
  }) async {
    await _subscription?.cancel();
    // The live stream takes the result pane back from any history entry.
    ref.read(selectedHistoryEntryProvider.notifier).select(null);
    state = const AsyncLoading();
    final TranslationClient client;
    try {
      client = await ref.read(translationClientProvider.future);
    } on Exception catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      return;
    }
    TranslationEvent? lastEvent;
    _subscription = client
        .streamTranslation(systemPrompt: systemPrompt, text: text)
        .listen(
          (event) {
            lastEvent = event;
            state = AsyncData(event);
          },
          onError: (Object error, StackTrace stackTrace) => state = AsyncError(error, stackTrace),
          cancelOnError: true,
          onDone: () {
            // Cancellation and errors skip onDone, so this runs for streams
            // that completed; only a validated final result is worth keeping.
            final result = lastEvent?.result;
            if (result == null || !ref.mounted) {
              return;
            }
            // An insert failure surfaces as an uncaught error by design:
            // the translation itself succeeded and stays on screen.
            unawaited(
              ref
                  .read(appDatabaseProvider)
                  .insertEntry(
                    sourceText: text,
                    translation: result.translation,
                    resultJson: jsonEncode(result.toJson()),
                  ),
            );
          },
        );
  }
}
