// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translation_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Holds the latest translation progress. `null` means nothing has been
/// translated yet. While streaming, the model's thinking and progressively
/// richer results are reflected into [state]; the last event carries the
/// validated final result, which is also appended to the history.

@ProviderFor(TranslationController)
final translationControllerProvider = TranslationControllerProvider._();

/// Holds the latest translation progress. `null` means nothing has been
/// translated yet. While streaming, the model's thinking and progressively
/// richer results are reflected into [state]; the last event carries the
/// validated final result, which is also appended to the history.
final class TranslationControllerProvider extends $AsyncNotifierProvider<TranslationController, TranslationEvent?> {
  /// Holds the latest translation progress. `null` means nothing has been
  /// translated yet. While streaming, the model's thinking and progressively
  /// richer results are reflected into [state]; the last event carries the
  /// validated final result, which is also appended to the history.
  TranslationControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'translationControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$translationControllerHash();

  @$internal
  @override
  TranslationController create() => TranslationController();
}

String _$translationControllerHash() => r'c6584e181f070099a4b9eb098bb7f2431b1feedb';

/// Holds the latest translation progress. `null` means nothing has been
/// translated yet. While streaming, the model's thinking and progressively
/// richer results are reflected into [state]; the last event carries the
/// validated final result, which is also appended to the history.

abstract class _$TranslationController extends $AsyncNotifier<TranslationEvent?> {
  FutureOr<TranslationEvent?> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<TranslationEvent?>, TranslationEvent?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<TranslationEvent?>, TranslationEvent?>,
              AsyncValue<TranslationEvent?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
