import 'package:kore_translation/app/data/app_database.dart';
import 'package:kore_translation/app/providers/app_database_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'history_provider.g.dart';

/// History entries, newest first.
@riverpod
Stream<List<HistoryEntry>> historyEntries(Ref ref) => ref.watch(appDatabaseProvider).watchEntries();

/// The history entry shown in the result pane; null shows the live
/// translation instead.
@riverpod
class SelectedHistoryEntry extends _$SelectedHistoryEntry {
  @override
  HistoryEntry? build() => null;

  void select(HistoryEntry? entry) => state = entry;
}
