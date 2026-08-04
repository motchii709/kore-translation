import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kore_client/kore_client.dart';
import 'package:kore_translation/app/i18n/translations.g.dart';
import 'package:kore_translation/app/providers/app_database_provider.dart';
import 'package:kore_translation/app/providers/history_provider.dart';
import 'package:kore_translation/app/providers/translation_jobs_provider.dart';
import 'package:kore_translation/app/ui/scroll/use_animated_scroll_controller.dart';

/// Translation history list, shared by the desktop sidebar and the narrow
/// layout's drawer. Tapping an entry makes it the selected one;
/// [onSelected] runs afterwards with its id (the drawer uses it to close
/// itself and, without a result pane, to push the entry's page).
class HistoryList extends HookConsumerWidget {
  const HistoryList({this.onSelected, super.key});

  final ValueChanged<int>? onSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Hooks must run on every build, so the controller lives outside the
    // switch even though only the data branch scrolls.
    final scrollController = useAnimatedScrollController();
    final entries = ref.watch(historyEntriesProvider);
    final selectedId = ref.watch(selectedHistoryEntryIdProvider);
    // Live jobs overlay the stored rows: a streaming translation shows up
    // in its row from the first rendered snapshot, not on completion.
    final jobs = ref.watch(translationJobsProvider);
    final theme = Theme.of(context);
    return switch (entries) {
      AsyncData(value: final entries) when entries.isEmpty => Center(
        child: Text(
          context.t.history.empty,
          style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.outline),
        ),
      ),
      AsyncData(value: final entries) => ListView.builder(
        controller: scrollController,
        itemCount: entries.length,
        itemBuilder: (context, index) {
          final entry = entries[index];
          final liveTranslation = switch (jobs[entry.id]) {
            AsyncData(value: TranslationEvent(result: TranslationResult(:final translation?))) => translation,
            _ => null,
          };
          return ListTile(
            title: Text(entry.sourceText, maxLines: 1, overflow: TextOverflow.ellipsis),
            subtitle: Text(liveTranslation ?? entry.translation, maxLines: 1, overflow: TextOverflow.ellipsis),
            selected: entry.id == selectedId,
            onTap: () {
              ref.read(selectedHistoryEntryIdProvider.notifier).select(entry.id);
              onSelected?.call(entry.id);
            },
            trailing: IconButton(
              tooltip: context.t.history.delete,
              icon: const Icon(Icons.delete_outline, size: 20),
              onPressed: () async {
                // A deleted entry cannot stay on display.
                if (entry.id == selectedId) {
                  ref.read(selectedHistoryEntryIdProvider.notifier).select(null);
                }
                await ref.read(appDatabaseProvider).deleteEntry(entry.id);
              },
            ),
          );
        },
      ),
      AsyncError(:final error) => Center(child: Text(context.t.history.loadFailed(error: '$error'))),
      _ => const Center(child: CircularProgressIndicator()),
    };
  }
}
