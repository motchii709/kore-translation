import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kore_translation/app/i18n/translations.g.dart';
import 'package:kore_translation/app/providers/app_database_provider.dart';
import 'package:kore_translation/app/providers/history_provider.dart';
import 'package:silky_scroll/silky_scroll.dart';

/// Translation history list, shared by the desktop sidebar and the narrow
/// layout's drawer. Tapping an entry makes it the selected one;
/// [onSelected] runs afterwards (the drawer uses it to close itself).
class HistoryList extends ConsumerWidget {
  const HistoryList({this.onSelected, super.key});

  final VoidCallback? onSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entries = ref.watch(historyEntriesProvider);
    final selected = ref.watch(selectedHistoryEntryProvider);
    final theme = Theme.of(context);
    return switch (entries) {
      AsyncData(value: final entries) when entries.isEmpty => Center(
        child: Text(
          context.t.history.empty,
          style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.outline),
        ),
      ),
      AsyncData(value: final entries) => SilkyListView.builder(
        itemCount: entries.length,
        itemBuilder: (context, index) {
          final entry = entries[index];
          return ListTile(
            title: Text(entry.sourceText, maxLines: 1, overflow: TextOverflow.ellipsis),
            subtitle: Text(entry.translation, maxLines: 1, overflow: TextOverflow.ellipsis),
            selected: entry.id == selected?.id,
            onTap: () {
              ref.read(selectedHistoryEntryProvider.notifier).select(entry);
              onSelected?.call();
            },
            trailing: IconButton(
              tooltip: context.t.history.delete,
              icon: const Icon(Icons.delete_outline, size: 20),
              onPressed: () async {
                // A deleted entry cannot stay on display.
                if (entry.id == selected?.id) {
                  ref.read(selectedHistoryEntryProvider.notifier).select(null);
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
