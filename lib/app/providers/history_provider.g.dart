// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// History entries, newest first.

@ProviderFor(historyEntries)
final historyEntriesProvider = HistoryEntriesProvider._();

/// History entries, newest first.

final class HistoryEntriesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<HistoryEntry>>,
          List<HistoryEntry>,
          Stream<List<HistoryEntry>>
        >
    with
        $FutureModifier<List<HistoryEntry>>,
        $StreamProvider<List<HistoryEntry>> {
  /// History entries, newest first.
  HistoryEntriesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'historyEntriesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$historyEntriesHash();

  @$internal
  @override
  $StreamProviderElement<List<HistoryEntry>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<HistoryEntry>> create(Ref ref) {
    return historyEntries(ref);
  }
}

String _$historyEntriesHash() => r'14cc572795e5c126f31fe290ab13fce77e02f24d';

/// The id of the history entry shown in the result pane; null shows the
/// placeholder. Starting a translation selects its just-inserted entry, so
/// the pane follows the newest stream until the user picks another one.

@ProviderFor(SelectedHistoryEntryId)
final selectedHistoryEntryIdProvider = SelectedHistoryEntryIdProvider._();

/// The id of the history entry shown in the result pane; null shows the
/// placeholder. Starting a translation selects its just-inserted entry, so
/// the pane follows the newest stream until the user picks another one.
final class SelectedHistoryEntryIdProvider
    extends $NotifierProvider<SelectedHistoryEntryId, int?> {
  /// The id of the history entry shown in the result pane; null shows the
  /// placeholder. Starting a translation selects its just-inserted entry, so
  /// the pane follows the newest stream until the user picks another one.
  SelectedHistoryEntryIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedHistoryEntryIdProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedHistoryEntryIdHash();

  @$internal
  @override
  SelectedHistoryEntryId create() => SelectedHistoryEntryId();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int?>(value),
    );
  }
}

String _$selectedHistoryEntryIdHash() =>
    r'3ab3cb8acc67699b058d6df2be3a8adea395ac23';

/// The id of the history entry shown in the result pane; null shows the
/// placeholder. Starting a translation selects its just-inserted entry, so
/// the pane follows the newest stream until the user picks another one.

abstract class _$SelectedHistoryEntryId extends $Notifier<int?> {
  int? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<int?, int?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int?, int?>,
              int?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
