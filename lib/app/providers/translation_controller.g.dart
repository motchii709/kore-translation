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
/// validated final result.

@ProviderFor(TranslationController)
final translationControllerProvider = TranslationControllerProvider._();

/// Holds the latest translation progress. `null` means nothing has been
/// translated yet. While streaming, the model's thinking and progressively
/// richer results are reflected into [state]; the last event carries the
/// validated final result.
final class TranslationControllerProvider extends $AsyncNotifierProvider<TranslationController, TranslationEvent?> {
  /// Holds the latest translation progress. `null` means nothing has been
  /// translated yet. While streaming, the model's thinking and progressively
  /// richer results are reflected into [state]; the last event carries the
  /// validated final result.
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

String _$translationControllerHash() => r'409178b21aa259c5b2f51fd0798584ec53a6bcae';

/// Holds the latest translation progress. `null` means nothing has been
/// translated yet. While streaming, the model's thinking and progressively
/// richer results are reflected into [state]; the last event carries the
/// validated final result.

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
