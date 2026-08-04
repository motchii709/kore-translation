import 'dart:async';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kore_translation/app/data/app_database.dart';
import 'package:kore_translation/app/providers/app_database_provider.dart';
import 'package:kore_translation/app/providers/history_provider.dart';
import 'package:kore_translation/app/providers/translation_jobs_provider.dart';
import 'package:kore_translation/main.dart';
import 'package:llm_sdk_core/llm_sdk_core.dart';

/// Streams that stay open until cancelled: completion never happens, so the
/// entries stay pending. Cancellation never completes either — like a
/// backend parked mid-turn — so these also prove nothing waits on teardown.
class _OpenStreamSession implements LlmSession {
  final controllers = <StreamController<Object?>>[];

  @override
  bool get isAlive => true;

  @override
  Future<void> close() async {}

  @override
  Stream<T> streamObject<T>({
    required String system,
    required String user,
    required bool thinking,
    required T Function(String? thinking, Map<String, dynamic>? reply) decoder,
  }) {
    final controller = StreamController<T>(onCancel: () => Completer<void>().future);
    controllers.add(controller);
    return controller.stream;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('translations run in parallel, insert pending entries immediately, and select the newest', () async {
    final session = _OpenStreamSession();
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    // Mirrors the app's ProviderScope: retries disabled so errors surface.
    final scope = ProviderContainer(
      retry: noRetry,
      overrides: [appDatabaseProvider.overrideWithValue(database)],
    );
    addTearDown(scope.dispose);
    final notifier = scope.read(translationJobsProvider.notifier);

    final first = await notifier.translate(session: session, systemPrompt: 'p', text: 'a', thinking: true);
    final second = await notifier.translate(session: session, systemPrompt: 'p', text: 'b', thinking: true);

    // Both streams stay live: starting a translation cancels nothing.
    expect(session.controllers, hasLength(2));
    expect(session.controllers.first.hasListener, isTrue);
    expect(session.controllers.last.hasListener, isTrue);

    // The pending rows exist before any stream completes, newest first.
    final entries = await database.watchEntries().first;
    expect(entries.map((entry) => (entry.id, entry.sourceText)), [(second, 'b'), (first, 'a')]);

    // The pane follows the newest stream.
    expect(scope.read(selectedHistoryEntryIdProvider), second);
  });
}
