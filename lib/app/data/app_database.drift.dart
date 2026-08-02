// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:kore_translation/app/data/app_database.drift.dart' as i1;
import 'package:kore_translation/app/data/app_database.dart' as i2;
import 'package:flutter/src/material/app.dart' as i3;
import 'package:kore_translation/app/models/ui_settings.dart' as i4;

typedef $$HistoryEntriesTableCreateCompanionBuilder =
    i1.HistoryEntriesCompanion Function({
      i0.Value<int> id,
      required String sourceText,
      required String translation,
      required String resultJson,
      required DateTime createdAt,
    });
typedef $$HistoryEntriesTableUpdateCompanionBuilder =
    i1.HistoryEntriesCompanion Function({
      i0.Value<int> id,
      i0.Value<String> sourceText,
      i0.Value<String> translation,
      i0.Value<String> resultJson,
      i0.Value<DateTime> createdAt,
    });

class $$HistoryEntriesTableFilterComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.$HistoryEntriesTable> {
  $$HistoryEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get sourceText => $composableBuilder(
    column: $table.sourceText,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get translation => $composableBuilder(
    column: $table.translation,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get resultJson => $composableBuilder(
    column: $table.resultJson,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => i0.ColumnFilters(column),
  );
}

class $$HistoryEntriesTableOrderingComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.$HistoryEntriesTable> {
  $$HistoryEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get sourceText => $composableBuilder(
    column: $table.sourceText,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get translation => $composableBuilder(
    column: $table.translation,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get resultJson => $composableBuilder(
    column: $table.resultJson,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => i0.ColumnOrderings(column),
  );
}

class $$HistoryEntriesTableAnnotationComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.$HistoryEntriesTable> {
  $$HistoryEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  i0.GeneratedColumn<String> get sourceText => $composableBuilder(
    column: $table.sourceText,
    builder: (column) => column,
  );

  i0.GeneratedColumn<String> get translation => $composableBuilder(
    column: $table.translation,
    builder: (column) => column,
  );

  i0.GeneratedColumn<String> get resultJson => $composableBuilder(
    column: $table.resultJson,
    builder: (column) => column,
  );

  i0.GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$HistoryEntriesTableTableManager
    extends
        i0.RootTableManager<
          i0.GeneratedDatabase,
          i1.$HistoryEntriesTable,
          i1.HistoryEntry,
          i1.$$HistoryEntriesTableFilterComposer,
          i1.$$HistoryEntriesTableOrderingComposer,
          i1.$$HistoryEntriesTableAnnotationComposer,
          $$HistoryEntriesTableCreateCompanionBuilder,
          $$HistoryEntriesTableUpdateCompanionBuilder,
          (
            i1.HistoryEntry,
            i0.BaseReferences<
              i0.GeneratedDatabase,
              i1.$HistoryEntriesTable,
              i1.HistoryEntry
            >,
          ),
          i1.HistoryEntry,
          i0.PrefetchHooks Function()
        > {
  $$HistoryEntriesTableTableManager(
    i0.GeneratedDatabase db,
    i1.$HistoryEntriesTable table,
  ) : super(
        i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              i1.$$HistoryEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              i1.$$HistoryEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => i1
              .$$HistoryEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                i0.Value<int> id = const i0.Value.absent(),
                i0.Value<String> sourceText = const i0.Value.absent(),
                i0.Value<String> translation = const i0.Value.absent(),
                i0.Value<String> resultJson = const i0.Value.absent(),
                i0.Value<DateTime> createdAt = const i0.Value.absent(),
              }) => i1.HistoryEntriesCompanion(
                id: id,
                sourceText: sourceText,
                translation: translation,
                resultJson: resultJson,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                i0.Value<int> id = const i0.Value.absent(),
                required String sourceText,
                required String translation,
                required String resultJson,
                required DateTime createdAt,
              }) => i1.HistoryEntriesCompanion.insert(
                id: id,
                sourceText: sourceText,
                translation: translation,
                resultJson: resultJson,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), i0.BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$HistoryEntriesTableProcessedTableManager =
    i0.ProcessedTableManager<
      i0.GeneratedDatabase,
      i1.$HistoryEntriesTable,
      i1.HistoryEntry,
      i1.$$HistoryEntriesTableFilterComposer,
      i1.$$HistoryEntriesTableOrderingComposer,
      i1.$$HistoryEntriesTableAnnotationComposer,
      $$HistoryEntriesTableCreateCompanionBuilder,
      $$HistoryEntriesTableUpdateCompanionBuilder,
      (
        i1.HistoryEntry,
        i0.BaseReferences<
          i0.GeneratedDatabase,
          i1.$HistoryEntriesTable,
          i1.HistoryEntry
        >,
      ),
      i1.HistoryEntry,
      i0.PrefetchHooks Function()
    >;
typedef $$UiSettingsRowsTableCreateCompanionBuilder =
    i1.UiSettingsRowsCompanion Function({
      i0.Value<int> id,
      required i3.ThemeMode themeMode,
      required i4.SubmitShortcut submitShortcut,
      required i4.AppLanguage appLanguage,
    });
typedef $$UiSettingsRowsTableUpdateCompanionBuilder =
    i1.UiSettingsRowsCompanion Function({
      i0.Value<int> id,
      i0.Value<i3.ThemeMode> themeMode,
      i0.Value<i4.SubmitShortcut> submitShortcut,
      i0.Value<i4.AppLanguage> appLanguage,
    });

class $$UiSettingsRowsTableFilterComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.$UiSettingsRowsTable> {
  $$UiSettingsRowsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnWithTypeConverterFilters<i3.ThemeMode, i3.ThemeMode, String>
  get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => i0.ColumnWithTypeConverterFilters(column),
  );

  i0.ColumnWithTypeConverterFilters<
    i4.SubmitShortcut,
    i4.SubmitShortcut,
    String
  >
  get submitShortcut => $composableBuilder(
    column: $table.submitShortcut,
    builder: (column) => i0.ColumnWithTypeConverterFilters(column),
  );

  i0.ColumnWithTypeConverterFilters<i4.AppLanguage, i4.AppLanguage, String>
  get appLanguage => $composableBuilder(
    column: $table.appLanguage,
    builder: (column) => i0.ColumnWithTypeConverterFilters(column),
  );
}

class $$UiSettingsRowsTableOrderingComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.$UiSettingsRowsTable> {
  $$UiSettingsRowsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get submitShortcut => $composableBuilder(
    column: $table.submitShortcut,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get appLanguage => $composableBuilder(
    column: $table.appLanguage,
    builder: (column) => i0.ColumnOrderings(column),
  );
}

class $$UiSettingsRowsTableAnnotationComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.$UiSettingsRowsTable> {
  $$UiSettingsRowsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  i0.GeneratedColumnWithTypeConverter<i3.ThemeMode, String> get themeMode =>
      $composableBuilder(column: $table.themeMode, builder: (column) => column);

  i0.GeneratedColumnWithTypeConverter<i4.SubmitShortcut, String>
  get submitShortcut => $composableBuilder(
    column: $table.submitShortcut,
    builder: (column) => column,
  );

  i0.GeneratedColumnWithTypeConverter<i4.AppLanguage, String> get appLanguage =>
      $composableBuilder(
        column: $table.appLanguage,
        builder: (column) => column,
      );
}

class $$UiSettingsRowsTableTableManager
    extends
        i0.RootTableManager<
          i0.GeneratedDatabase,
          i1.$UiSettingsRowsTable,
          i1.UiSettingsRow,
          i1.$$UiSettingsRowsTableFilterComposer,
          i1.$$UiSettingsRowsTableOrderingComposer,
          i1.$$UiSettingsRowsTableAnnotationComposer,
          $$UiSettingsRowsTableCreateCompanionBuilder,
          $$UiSettingsRowsTableUpdateCompanionBuilder,
          (
            i1.UiSettingsRow,
            i0.BaseReferences<
              i0.GeneratedDatabase,
              i1.$UiSettingsRowsTable,
              i1.UiSettingsRow
            >,
          ),
          i1.UiSettingsRow,
          i0.PrefetchHooks Function()
        > {
  $$UiSettingsRowsTableTableManager(
    i0.GeneratedDatabase db,
    i1.$UiSettingsRowsTable table,
  ) : super(
        i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              i1.$$UiSettingsRowsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              i1.$$UiSettingsRowsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => i1
              .$$UiSettingsRowsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                i0.Value<int> id = const i0.Value.absent(),
                i0.Value<i3.ThemeMode> themeMode = const i0.Value.absent(),
                i0.Value<i4.SubmitShortcut> submitShortcut =
                    const i0.Value.absent(),
                i0.Value<i4.AppLanguage> appLanguage = const i0.Value.absent(),
              }) => i1.UiSettingsRowsCompanion(
                id: id,
                themeMode: themeMode,
                submitShortcut: submitShortcut,
                appLanguage: appLanguage,
              ),
          createCompanionCallback:
              ({
                i0.Value<int> id = const i0.Value.absent(),
                required i3.ThemeMode themeMode,
                required i4.SubmitShortcut submitShortcut,
                required i4.AppLanguage appLanguage,
              }) => i1.UiSettingsRowsCompanion.insert(
                id: id,
                themeMode: themeMode,
                submitShortcut: submitShortcut,
                appLanguage: appLanguage,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), i0.BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UiSettingsRowsTableProcessedTableManager =
    i0.ProcessedTableManager<
      i0.GeneratedDatabase,
      i1.$UiSettingsRowsTable,
      i1.UiSettingsRow,
      i1.$$UiSettingsRowsTableFilterComposer,
      i1.$$UiSettingsRowsTableOrderingComposer,
      i1.$$UiSettingsRowsTableAnnotationComposer,
      $$UiSettingsRowsTableCreateCompanionBuilder,
      $$UiSettingsRowsTableUpdateCompanionBuilder,
      (
        i1.UiSettingsRow,
        i0.BaseReferences<
          i0.GeneratedDatabase,
          i1.$UiSettingsRowsTable,
          i1.UiSettingsRow
        >,
      ),
      i1.UiSettingsRow,
      i0.PrefetchHooks Function()
    >;

abstract class $AppDatabase extends i0.GeneratedDatabase {
  $AppDatabase(i0.QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final i1.$HistoryEntriesTable historyEntries = i1.$HistoryEntriesTable(
    this,
  );
  late final i1.$UiSettingsRowsTable uiSettingsRows = i1.$UiSettingsRowsTable(
    this,
  );
  @override
  Iterable<i0.TableInfo<i0.Table, Object?>> get allTables =>
      allSchemaEntities.whereType<i0.TableInfo<i0.Table, Object?>>();
  @override
  List<i0.DatabaseSchemaEntity> get allSchemaEntities => [
    historyEntries,
    uiSettingsRows,
  ];
}

class $AppDatabaseManager {
  final $AppDatabase _db;
  $AppDatabaseManager(this._db);
  i1.$$HistoryEntriesTableTableManager get historyEntries =>
      i1.$$HistoryEntriesTableTableManager(_db, _db.historyEntries);
  i1.$$UiSettingsRowsTableTableManager get uiSettingsRows =>
      i1.$$UiSettingsRowsTableTableManager(_db, _db.uiSettingsRows);
}

class $HistoryEntriesTable extends i2.HistoryEntries
    with i0.TableInfo<$HistoryEntriesTable, i1.HistoryEntry> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HistoryEntriesTable(this.attachedDatabase, [this._alias]);
  static const i0.VerificationMeta _idMeta = const i0.VerificationMeta('id');
  @override
  late final i0.GeneratedColumn<int> id = i0.GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: i0.DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: i0.GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const i0.VerificationMeta _sourceTextMeta = const i0.VerificationMeta(
    'sourceText',
  );
  @override
  late final i0.GeneratedColumn<String> sourceText = i0.GeneratedColumn<String>(
    'source_text',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const i0.VerificationMeta _translationMeta = const i0.VerificationMeta(
    'translation',
  );
  @override
  late final i0.GeneratedColumn<String> translation =
      i0.GeneratedColumn<String>(
        'translation',
        aliasedName,
        false,
        type: i0.DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const i0.VerificationMeta _resultJsonMeta = const i0.VerificationMeta(
    'resultJson',
  );
  @override
  late final i0.GeneratedColumn<String> resultJson = i0.GeneratedColumn<String>(
    'result_json',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const i0.VerificationMeta _createdAtMeta = const i0.VerificationMeta(
    'createdAt',
  );
  @override
  late final i0.GeneratedColumn<DateTime> createdAt =
      i0.GeneratedColumn<DateTime>(
        'created_at',
        aliasedName,
        false,
        type: i0.DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  @override
  List<i0.GeneratedColumn> get $columns => [
    id,
    sourceText,
    translation,
    resultJson,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'history_entries';
  @override
  i0.VerificationContext validateIntegrity(
    i0.Insertable<i1.HistoryEntry> instance, {
    bool isInserting = false,
  }) {
    final context = i0.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('source_text')) {
      context.handle(
        _sourceTextMeta,
        sourceText.isAcceptableOrUnknown(data['source_text']!, _sourceTextMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceTextMeta);
    }
    if (data.containsKey('translation')) {
      context.handle(
        _translationMeta,
        translation.isAcceptableOrUnknown(
          data['translation']!,
          _translationMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_translationMeta);
    }
    if (data.containsKey('result_json')) {
      context.handle(
        _resultJsonMeta,
        resultJson.isAcceptableOrUnknown(data['result_json']!, _resultJsonMeta),
      );
    } else if (isInserting) {
      context.missing(_resultJsonMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => {id};
  @override
  i1.HistoryEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.HistoryEntry(
      id: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      sourceText: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}source_text'],
      )!,
      translation: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}translation'],
      )!,
      resultJson: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}result_json'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $HistoryEntriesTable createAlias(String alias) {
    return $HistoryEntriesTable(attachedDatabase, alias);
  }
}

class HistoryEntry extends i0.DataClass
    implements i0.Insertable<i1.HistoryEntry> {
  final int id;
  final String sourceText;
  final String translation;
  final String resultJson;
  final DateTime createdAt;
  const HistoryEntry({
    required this.id,
    required this.sourceText,
    required this.translation,
    required this.resultJson,
    required this.createdAt,
  });
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['id'] = i0.Variable<int>(id);
    map['source_text'] = i0.Variable<String>(sourceText);
    map['translation'] = i0.Variable<String>(translation);
    map['result_json'] = i0.Variable<String>(resultJson);
    map['created_at'] = i0.Variable<DateTime>(createdAt);
    return map;
  }

  i1.HistoryEntriesCompanion toCompanion(bool nullToAbsent) {
    return i1.HistoryEntriesCompanion(
      id: i0.Value(id),
      sourceText: i0.Value(sourceText),
      translation: i0.Value(translation),
      resultJson: i0.Value(resultJson),
      createdAt: i0.Value(createdAt),
    );
  }

  factory HistoryEntry.fromJson(
    Map<String, dynamic> json, {
    i0.ValueSerializer? serializer,
  }) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return HistoryEntry(
      id: serializer.fromJson<int>(json['id']),
      sourceText: serializer.fromJson<String>(json['sourceText']),
      translation: serializer.fromJson<String>(json['translation']),
      resultJson: serializer.fromJson<String>(json['resultJson']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sourceText': serializer.toJson<String>(sourceText),
      'translation': serializer.toJson<String>(translation),
      'resultJson': serializer.toJson<String>(resultJson),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  i1.HistoryEntry copyWith({
    int? id,
    String? sourceText,
    String? translation,
    String? resultJson,
    DateTime? createdAt,
  }) => i1.HistoryEntry(
    id: id ?? this.id,
    sourceText: sourceText ?? this.sourceText,
    translation: translation ?? this.translation,
    resultJson: resultJson ?? this.resultJson,
    createdAt: createdAt ?? this.createdAt,
  );
  HistoryEntry copyWithCompanion(i1.HistoryEntriesCompanion data) {
    return HistoryEntry(
      id: data.id.present ? data.id.value : this.id,
      sourceText: data.sourceText.present
          ? data.sourceText.value
          : this.sourceText,
      translation: data.translation.present
          ? data.translation.value
          : this.translation,
      resultJson: data.resultJson.present
          ? data.resultJson.value
          : this.resultJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HistoryEntry(')
          ..write('id: $id, ')
          ..write('sourceText: $sourceText, ')
          ..write('translation: $translation, ')
          ..write('resultJson: $resultJson, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, sourceText, translation, resultJson, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.HistoryEntry &&
          other.id == this.id &&
          other.sourceText == this.sourceText &&
          other.translation == this.translation &&
          other.resultJson == this.resultJson &&
          other.createdAt == this.createdAt);
}

class HistoryEntriesCompanion extends i0.UpdateCompanion<i1.HistoryEntry> {
  final i0.Value<int> id;
  final i0.Value<String> sourceText;
  final i0.Value<String> translation;
  final i0.Value<String> resultJson;
  final i0.Value<DateTime> createdAt;
  const HistoryEntriesCompanion({
    this.id = const i0.Value.absent(),
    this.sourceText = const i0.Value.absent(),
    this.translation = const i0.Value.absent(),
    this.resultJson = const i0.Value.absent(),
    this.createdAt = const i0.Value.absent(),
  });
  HistoryEntriesCompanion.insert({
    this.id = const i0.Value.absent(),
    required String sourceText,
    required String translation,
    required String resultJson,
    required DateTime createdAt,
  }) : sourceText = i0.Value(sourceText),
       translation = i0.Value(translation),
       resultJson = i0.Value(resultJson),
       createdAt = i0.Value(createdAt);
  static i0.Insertable<i1.HistoryEntry> custom({
    i0.Expression<int>? id,
    i0.Expression<String>? sourceText,
    i0.Expression<String>? translation,
    i0.Expression<String>? resultJson,
    i0.Expression<DateTime>? createdAt,
  }) {
    return i0.RawValuesInsertable({
      if (id != null) 'id': id,
      if (sourceText != null) 'source_text': sourceText,
      if (translation != null) 'translation': translation,
      if (resultJson != null) 'result_json': resultJson,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  i1.HistoryEntriesCompanion copyWith({
    i0.Value<int>? id,
    i0.Value<String>? sourceText,
    i0.Value<String>? translation,
    i0.Value<String>? resultJson,
    i0.Value<DateTime>? createdAt,
  }) {
    return i1.HistoryEntriesCompanion(
      id: id ?? this.id,
      sourceText: sourceText ?? this.sourceText,
      translation: translation ?? this.translation,
      resultJson: resultJson ?? this.resultJson,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (id.present) {
      map['id'] = i0.Variable<int>(id.value);
    }
    if (sourceText.present) {
      map['source_text'] = i0.Variable<String>(sourceText.value);
    }
    if (translation.present) {
      map['translation'] = i0.Variable<String>(translation.value);
    }
    if (resultJson.present) {
      map['result_json'] = i0.Variable<String>(resultJson.value);
    }
    if (createdAt.present) {
      map['created_at'] = i0.Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HistoryEntriesCompanion(')
          ..write('id: $id, ')
          ..write('sourceText: $sourceText, ')
          ..write('translation: $translation, ')
          ..write('resultJson: $resultJson, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $UiSettingsRowsTable extends i2.UiSettingsRows
    with i0.TableInfo<$UiSettingsRowsTable, i1.UiSettingsRow> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UiSettingsRowsTable(this.attachedDatabase, [this._alias]);
  static const i0.VerificationMeta _idMeta = const i0.VerificationMeta('id');
  @override
  late final i0.GeneratedColumn<int> id = i0.GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: i0.DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  late final i0.GeneratedColumnWithTypeConverter<i3.ThemeMode, String>
  themeMode = i0.GeneratedColumn<String>(
    'theme_mode',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<i3.ThemeMode>(i1.$UiSettingsRowsTable.$converterthemeMode);
  @override
  late final i0.GeneratedColumnWithTypeConverter<i4.SubmitShortcut, String>
  submitShortcut =
      i0.GeneratedColumn<String>(
        'submit_shortcut',
        aliasedName,
        false,
        type: i0.DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<i4.SubmitShortcut>(
        i1.$UiSettingsRowsTable.$convertersubmitShortcut,
      );
  @override
  late final i0.GeneratedColumnWithTypeConverter<i4.AppLanguage, String>
  appLanguage =
      i0.GeneratedColumn<String>(
        'app_language',
        aliasedName,
        false,
        type: i0.DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<i4.AppLanguage>(
        i1.$UiSettingsRowsTable.$converterappLanguage,
      );
  @override
  List<i0.GeneratedColumn> get $columns => [
    id,
    themeMode,
    submitShortcut,
    appLanguage,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ui_settings_rows';
  @override
  i0.VerificationContext validateIntegrity(
    i0.Insertable<i1.UiSettingsRow> instance, {
    bool isInserting = false,
  }) {
    final context = i0.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => {id};
  @override
  i1.UiSettingsRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.UiSettingsRow(
      id: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      themeMode: i1.$UiSettingsRowsTable.$converterthemeMode.fromSql(
        attachedDatabase.typeMapping.read(
          i0.DriftSqlType.string,
          data['${effectivePrefix}theme_mode'],
        )!,
      ),
      submitShortcut: i1.$UiSettingsRowsTable.$convertersubmitShortcut.fromSql(
        attachedDatabase.typeMapping.read(
          i0.DriftSqlType.string,
          data['${effectivePrefix}submit_shortcut'],
        )!,
      ),
      appLanguage: i1.$UiSettingsRowsTable.$converterappLanguage.fromSql(
        attachedDatabase.typeMapping.read(
          i0.DriftSqlType.string,
          data['${effectivePrefix}app_language'],
        )!,
      ),
    );
  }

  @override
  $UiSettingsRowsTable createAlias(String alias) {
    return $UiSettingsRowsTable(attachedDatabase, alias);
  }

  static i0.JsonTypeConverter2<i3.ThemeMode, String, String>
  $converterthemeMode = const i0.EnumNameConverter<i3.ThemeMode>(
    i3.ThemeMode.values,
  );
  static i0.JsonTypeConverter2<i4.SubmitShortcut, String, String>
  $convertersubmitShortcut = const i0.EnumNameConverter<i4.SubmitShortcut>(
    i4.SubmitShortcut.values,
  );
  static i0.JsonTypeConverter2<i4.AppLanguage, String, String>
  $converterappLanguage = const i0.EnumNameConverter<i4.AppLanguage>(
    i4.AppLanguage.values,
  );
}

class UiSettingsRow extends i0.DataClass
    implements i0.Insertable<i1.UiSettingsRow> {
  final int id;
  final i3.ThemeMode themeMode;
  final i4.SubmitShortcut submitShortcut;
  final i4.AppLanguage appLanguage;
  const UiSettingsRow({
    required this.id,
    required this.themeMode,
    required this.submitShortcut,
    required this.appLanguage,
  });
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['id'] = i0.Variable<int>(id);
    {
      map['theme_mode'] = i0.Variable<String>(
        i1.$UiSettingsRowsTable.$converterthemeMode.toSql(themeMode),
      );
    }
    {
      map['submit_shortcut'] = i0.Variable<String>(
        i1.$UiSettingsRowsTable.$convertersubmitShortcut.toSql(submitShortcut),
      );
    }
    {
      map['app_language'] = i0.Variable<String>(
        i1.$UiSettingsRowsTable.$converterappLanguage.toSql(appLanguage),
      );
    }
    return map;
  }

  i1.UiSettingsRowsCompanion toCompanion(bool nullToAbsent) {
    return i1.UiSettingsRowsCompanion(
      id: i0.Value(id),
      themeMode: i0.Value(themeMode),
      submitShortcut: i0.Value(submitShortcut),
      appLanguage: i0.Value(appLanguage),
    );
  }

  factory UiSettingsRow.fromJson(
    Map<String, dynamic> json, {
    i0.ValueSerializer? serializer,
  }) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return UiSettingsRow(
      id: serializer.fromJson<int>(json['id']),
      themeMode: i1.$UiSettingsRowsTable.$converterthemeMode.fromJson(
        serializer.fromJson<String>(json['themeMode']),
      ),
      submitShortcut: i1.$UiSettingsRowsTable.$convertersubmitShortcut.fromJson(
        serializer.fromJson<String>(json['submitShortcut']),
      ),
      appLanguage: i1.$UiSettingsRowsTable.$converterappLanguage.fromJson(
        serializer.fromJson<String>(json['appLanguage']),
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'themeMode': serializer.toJson<String>(
        i1.$UiSettingsRowsTable.$converterthemeMode.toJson(themeMode),
      ),
      'submitShortcut': serializer.toJson<String>(
        i1.$UiSettingsRowsTable.$convertersubmitShortcut.toJson(submitShortcut),
      ),
      'appLanguage': serializer.toJson<String>(
        i1.$UiSettingsRowsTable.$converterappLanguage.toJson(appLanguage),
      ),
    };
  }

  i1.UiSettingsRow copyWith({
    int? id,
    i3.ThemeMode? themeMode,
    i4.SubmitShortcut? submitShortcut,
    i4.AppLanguage? appLanguage,
  }) => i1.UiSettingsRow(
    id: id ?? this.id,
    themeMode: themeMode ?? this.themeMode,
    submitShortcut: submitShortcut ?? this.submitShortcut,
    appLanguage: appLanguage ?? this.appLanguage,
  );
  UiSettingsRow copyWithCompanion(i1.UiSettingsRowsCompanion data) {
    return UiSettingsRow(
      id: data.id.present ? data.id.value : this.id,
      themeMode: data.themeMode.present ? data.themeMode.value : this.themeMode,
      submitShortcut: data.submitShortcut.present
          ? data.submitShortcut.value
          : this.submitShortcut,
      appLanguage: data.appLanguage.present
          ? data.appLanguage.value
          : this.appLanguage,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UiSettingsRow(')
          ..write('id: $id, ')
          ..write('themeMode: $themeMode, ')
          ..write('submitShortcut: $submitShortcut, ')
          ..write('appLanguage: $appLanguage')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, themeMode, submitShortcut, appLanguage);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.UiSettingsRow &&
          other.id == this.id &&
          other.themeMode == this.themeMode &&
          other.submitShortcut == this.submitShortcut &&
          other.appLanguage == this.appLanguage);
}

class UiSettingsRowsCompanion extends i0.UpdateCompanion<i1.UiSettingsRow> {
  final i0.Value<int> id;
  final i0.Value<i3.ThemeMode> themeMode;
  final i0.Value<i4.SubmitShortcut> submitShortcut;
  final i0.Value<i4.AppLanguage> appLanguage;
  const UiSettingsRowsCompanion({
    this.id = const i0.Value.absent(),
    this.themeMode = const i0.Value.absent(),
    this.submitShortcut = const i0.Value.absent(),
    this.appLanguage = const i0.Value.absent(),
  });
  UiSettingsRowsCompanion.insert({
    this.id = const i0.Value.absent(),
    required i3.ThemeMode themeMode,
    required i4.SubmitShortcut submitShortcut,
    required i4.AppLanguage appLanguage,
  }) : themeMode = i0.Value(themeMode),
       submitShortcut = i0.Value(submitShortcut),
       appLanguage = i0.Value(appLanguage);
  static i0.Insertable<i1.UiSettingsRow> custom({
    i0.Expression<int>? id,
    i0.Expression<String>? themeMode,
    i0.Expression<String>? submitShortcut,
    i0.Expression<String>? appLanguage,
  }) {
    return i0.RawValuesInsertable({
      if (id != null) 'id': id,
      if (themeMode != null) 'theme_mode': themeMode,
      if (submitShortcut != null) 'submit_shortcut': submitShortcut,
      if (appLanguage != null) 'app_language': appLanguage,
    });
  }

  i1.UiSettingsRowsCompanion copyWith({
    i0.Value<int>? id,
    i0.Value<i3.ThemeMode>? themeMode,
    i0.Value<i4.SubmitShortcut>? submitShortcut,
    i0.Value<i4.AppLanguage>? appLanguage,
  }) {
    return i1.UiSettingsRowsCompanion(
      id: id ?? this.id,
      themeMode: themeMode ?? this.themeMode,
      submitShortcut: submitShortcut ?? this.submitShortcut,
      appLanguage: appLanguage ?? this.appLanguage,
    );
  }

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (id.present) {
      map['id'] = i0.Variable<int>(id.value);
    }
    if (themeMode.present) {
      map['theme_mode'] = i0.Variable<String>(
        i1.$UiSettingsRowsTable.$converterthemeMode.toSql(themeMode.value),
      );
    }
    if (submitShortcut.present) {
      map['submit_shortcut'] = i0.Variable<String>(
        i1.$UiSettingsRowsTable.$convertersubmitShortcut.toSql(
          submitShortcut.value,
        ),
      );
    }
    if (appLanguage.present) {
      map['app_language'] = i0.Variable<String>(
        i1.$UiSettingsRowsTable.$converterappLanguage.toSql(appLanguage.value),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UiSettingsRowsCompanion(')
          ..write('id: $id, ')
          ..write('themeMode: $themeMode, ')
          ..write('submitShortcut: $submitShortcut, ')
          ..write('appLanguage: $appLanguage')
          ..write(')'))
        .toString();
  }
}
