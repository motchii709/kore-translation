import 'dart:async';
import 'dart:convert';

import 'package:kore_client/kore_client.dart';
import 'package:kore_translation/app/providers/app_database_provider.dart';
import 'package:kore_translation/app/providers/history_provider.dart';
import 'package:llm_sdk_core/llm_sdk_core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'translation_jobs_provider.g.dart';

/// The session's translations, keyed by their history entry id. Pressing
/// translate inserts the pending history entry immediately and streams into
/// its slot here, so any number of translations run in parallel and the
/// result pane switches between them by selection. Completion writes the
/// result back into the entry's row; the slot keeps its final snapshot (or
/// error), so switching back to a finished stream needs no reload.
@Riverpod(keepAlive: true)
class TranslationJobs extends _$TranslationJobs {
  final _subscriptions = <int, StreamSubscription<TranslationEvent>>{};

  @override
  Map<int, AsyncValue<TranslationEvent>> build() {
    ref.onDispose(() {
      for (final subscription in _subscriptions.values) {
        unawaited(subscription.cancel());
      }
    });
    return const {};
  }

  /// Inserts the pending history entry for [text], starts its streaming
  /// translation on [session] (which the caller opened), selects the entry,
  /// and returns its id. Never cancels other translations. [thinking] is
  /// the translate-form toggle, chosen per request; backends without a
  /// thinking control ignore it.
  Future<int> translate({
    required LlmSession session,
    required String systemPrompt,
    required String text,
    required bool thinking,
  }) async {
    final database = ref.read(appDatabaseProvider);
    // Pending row: empty translation and result until the stream completes.
    final id = await database.insertEntry(sourceText: text, translation: '', resultJson: '');
    ref.read(selectedHistoryEntryIdProvider.notifier).select(id);
    state = {...state, id: const AsyncLoading()};
    _subscriptions[id] = streamTranslation(session, systemPrompt: systemPrompt, text: text, thinking: thinking).listen(
      (event) => state = {...state, id: AsyncData(event)},
      onError: (Object error, StackTrace stackTrace) => state = {...state, id: AsyncError(error, stackTrace)},
      cancelOnError: true,
      onDone: () {
        // Cancellation and errors skip onDone, so this runs for streams
        // that completed: the slot still holds this turn's last snapshot —
        // the completed turn. Only a delivered translation is worth
        // persisting; a deleted entry makes the update a no-op.
        if (state[id] case AsyncData(value: final event)) {
          final result = event.result;
          final translation = result?.translation;
          if (result == null || translation == null) {
            return;
          }
          // An update failure surfaces as an uncaught error by design:
          // the translation itself succeeded and stays on screen.
          unawaited(
            database.updateEntry(id: id, translation: translation, resultJson: jsonEncode(result.toJson())),
          );
        }
      },
    );
    return id;
  }
}
