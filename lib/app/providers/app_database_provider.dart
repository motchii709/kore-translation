import 'dart:io';

import 'package:drift_flutter/drift_flutter.dart';
import 'package:kore_translation/app/data/app_database.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_database_provider.g.dart';

const _databaseName = 'kore';

/// The database file path, shared by the connection and the wholesale
/// deletion in the advanced settings.
Future<String> _appDatabasePath() async => '${(await getApplicationSupportDirectory()).path}/$_databaseName.sqlite';

/// The app's local store. Kept alive: one database connection for the
/// whole session.
@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) {
  final database = AppDatabase(
    driftDatabase(
      name: _databaseName,
      native: const DriftNativeOptions(databasePath: _appDatabasePath),
      web: DriftWebOptions(
        sqlite3Wasm: Uri.parse('sqlite3.wasm'),
        driftWorker: Uri.parse('drift_worker.js'),
      ),
    ),
  );
  ref.onDispose(database.close);
  return database;
}

/// Deletes the database files wholesale — the beta recovery for any schema
/// change or corruption, since migrations do not exist. Callers close the
/// database and invalidate [appDatabaseProvider] around this; a fresh empty
/// database is then created lazily.
Future<void> deleteAppDatabaseFiles() async {
  final path = await _appDatabasePath();
  // The main file plus SQLite's write-ahead-log companions.
  for (final suffix in ['', '-wal', '-shm']) {
    final file = File('$path$suffix');
    if (file.existsSync()) {
      await file.delete();
    }
  }
}
