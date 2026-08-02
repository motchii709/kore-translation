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
    extends $FunctionalProvider<AsyncValue<List<HistoryEntry>>, List<HistoryEntry>, Stream<List<HistoryEntry>>>
    with $FutureModifier<List<HistoryEntry>>, $StreamProvider<List<HistoryEntry>> {
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

/// The history entry shown in the result pane; null shows the live
/// translation instead.

@ProviderFor(SelectedHistoryEntry)
final selectedHistoryEntryProvider = SelectedHistoryEntryProvider._();

/// The history entry shown in the result pane; null shows the live
/// translation instead.
final class SelectedHistoryEntryProvider extends $NotifierProvider<SelectedHistoryEntry, HistoryEntry?> {
  /// The history entry shown in the result pane; null shows the live
  /// translation instead.
  SelectedHistoryEntryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedHistoryEntryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedHistoryEntryHash();

  @$internal
  @override
  SelectedHistoryEntry create() => SelectedHistoryEntry();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HistoryEntry? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HistoryEntry?>(value),
    );
  }
}

String _$selectedHistoryEntryHash() => r'84b0369e36c410e75ff57c5550b59942fd688eff';

/// The history entry shown in the result pane; null shows the live
/// translation instead.

abstract class _$SelectedHistoryEntry extends $Notifier<HistoryEntry?> {
  HistoryEntry? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<HistoryEntry?, HistoryEntry?>;
    final element =
        ref.element
            as $ClassProviderElement<AnyNotifier<HistoryEntry?, HistoryEntry?>, HistoryEntry?, Object?, Object?>;
    return element.handleCreate(ref, build);
  }
}
