import 'package:drift/drift.dart';
import 'package:flutter/material.dart' show ThemeMode;
import 'package:kore_translation/app/data/app_database.drift.dart';
import 'package:kore_translation/app/models/ui_settings.dart';

// Consumers get the generated row type (HistoryEntry) with this import.
export 'package:kore_translation/app/data/app_database.drift.dart' show HistoryEntry;

/// One translation request. The row is inserted as pending (empty
/// [translation] and [resultJson]) the moment the request starts, so the
/// history lists it immediately; completion fills both. [translation] is
/// denormalized from the result for the history list; [resultJson] is the
/// full `TranslationResult` JSON for the detail view. Streaming progress
/// and thinking are never stored.
@DataClassName('HistoryEntry')
class HistoryEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get sourceText => text()();
  TextColumn get translation => text()();
  TextColumn get resultJson => text()();
  DateTimeColumn get createdAt => dateTime()();
}

/// The app-wide UI preferences as a single row (id fixed to 0). Enum values
/// are stored by name; renames are schema changes like any other.
@DataClassName('UiSettingsRow')
class UiSettingsRows extends Table {
  IntColumn get id => integer()();
  TextColumn get themeMode => textEnum<ThemeMode>()();
  TextColumn get submitShortcut => textEnum<SubmitShortcut>()();
  TextColumn get submitAction => textEnum<SubmitAction>()();
  TextColumn get appLanguage => textEnum<AppLanguage>()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// The app's local store: translation history and UI preferences. The
/// executor is injected at the composition root (app provider / tests).
@DriftDatabase(tables: [HistoryEntries, UiSettingsRows])
class AppDatabase extends $AppDatabase {
  AppDatabase(super.e);

  static const _uiSettingsRowId = 0;

  // Beta policy: no migrations and no version bumps. Stale data after a
  // schema change surfaces raw errors (SQL or JSON parsing), and the user
  // recovers by deleting the database from the advanced settings.
  @override
  int get schemaVersion => 1;

  /// History, newest first.
  Stream<List<HistoryEntry>> watchEntries() =>
      (select(historyEntries)..orderBy([(e) => OrderingTerm.desc(e.id)])).watch();

  /// Inserts a pending entry and returns its id, for [updateEntry] once the
  /// translation completes.
  Future<int> insertEntry({
    required String sourceText,
    required String translation,
    required String resultJson,
  }) => into(historyEntries).insert(
    HistoryEntriesCompanion.insert(
      sourceText: sourceText,
      translation: translation,
      resultJson: resultJson,
      createdAt: DateTime.now(),
    ),
  );

  /// Fills a pending entry with its completed result.
  Future<void> updateEntry({
    required int id,
    required String translation,
    required String resultJson,
  }) => (update(historyEntries)..where((e) => e.id.equals(id))).write(
    HistoryEntriesCompanion(translation: Value(translation), resultJson: Value(resultJson)),
  );

  Future<void> deleteEntry(int id) => (delete(historyEntries)..where((e) => e.id.equals(id))).go();

  /// The stored UI preferences; the defaults when never saved.
  Future<UiSettings> loadUiSettings() async {
    final row = await (select(
      uiSettingsRows,
    )..where((r) => r.id.equals(_uiSettingsRowId))).getSingleOrNull();
    return switch (row) {
      null => const UiSettings(),
      final row => UiSettings(
        themeMode: row.themeMode,
        submitShortcut: row.submitShortcut,
        submitAction: row.submitAction,
        language: row.appLanguage,
      ),
    };
  }

  Future<void> saveUiSettings(UiSettings settings) => into(uiSettingsRows).insertOnConflictUpdate(
    UiSettingsRow(
      id: _uiSettingsRowId,
      themeMode: settings.themeMode,
      submitShortcut: settings.submitShortcut,
      submitAction: settings.submitAction,
      appLanguage: settings.language,
    ),
  );
}
