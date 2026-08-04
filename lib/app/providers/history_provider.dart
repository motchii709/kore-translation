import 'package:kore_translation/app/data/app_database.dart';
import 'package:kore_translation/app/providers/app_database_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'history_provider.g.dart';

/// History entries, newest first.
@riverpod
Stream<List<HistoryEntry>> historyEntries(Ref ref) => ref.watch(appDatabaseProvider).watchEntries();

/// The id of the history entry shown in the result pane; null shows the
/// placeholder. Starting a translation selects its just-inserted entry, so
/// the pane follows the newest stream until the user picks another one.
@riverpod
class SelectedHistoryEntryId extends _$SelectedHistoryEntryId {
  @override
  int? build() => null;

  void select(int? id) => state = id;
}
