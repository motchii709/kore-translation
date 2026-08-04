// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translation_jobs_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The session's translations, keyed by their history entry id. Pressing
/// translate inserts the pending history entry immediately and streams into
/// its slot here, so any number of translations run in parallel and the
/// result pane switches between them by selection. Completion writes the
/// result back into the entry's row; the slot keeps its final snapshot (or
/// error), so switching back to a finished stream needs no reload.

@ProviderFor(TranslationJobs)
final translationJobsProvider = TranslationJobsProvider._();

/// The session's translations, keyed by their history entry id. Pressing
/// translate inserts the pending history entry immediately and streams into
/// its slot here, so any number of translations run in parallel and the
/// result pane switches between them by selection. Completion writes the
/// result back into the entry's row; the slot keeps its final snapshot (or
/// error), so switching back to a finished stream needs no reload.
final class TranslationJobsProvider
    extends
        $NotifierProvider<
          TranslationJobs,
          Map<int, AsyncValue<TranslationEvent>>
        > {
  /// The session's translations, keyed by their history entry id. Pressing
  /// translate inserts the pending history entry immediately and streams into
  /// its slot here, so any number of translations run in parallel and the
  /// result pane switches between them by selection. Completion writes the
  /// result back into the entry's row; the slot keeps its final snapshot (or
  /// error), so switching back to a finished stream needs no reload.
  TranslationJobsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'translationJobsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$translationJobsHash();

  @$internal
  @override
  TranslationJobs create() => TranslationJobs();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<int, AsyncValue<TranslationEvent>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<Map<int, AsyncValue<TranslationEvent>>>(value),
    );
  }
}

String _$translationJobsHash() => r'18107808997f37a2c14eb12b3fb688895b6a50cc';

/// The session's translations, keyed by their history entry id. Pressing
/// translate inserts the pending history entry immediately and streams into
/// its slot here, so any number of translations run in parallel and the
/// result pane switches between them by selection. Completion writes the
/// result back into the entry's row; the slot keeps its final snapshot (or
/// error), so switching back to a finished stream needs no reload.

abstract class _$TranslationJobs
    extends $Notifier<Map<int, AsyncValue<TranslationEvent>>> {
  Map<int, AsyncValue<TranslationEvent>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              Map<int, AsyncValue<TranslationEvent>>,
              Map<int, AsyncValue<TranslationEvent>>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                Map<int, AsyncValue<TranslationEvent>>,
                Map<int, AsyncValue<TranslationEvent>>
              >,
              Map<int, AsyncValue<TranslationEvent>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
