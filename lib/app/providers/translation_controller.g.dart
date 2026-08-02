// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translation_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Holds the latest translation result. `null` means nothing has been
/// translated yet.

@ProviderFor(TranslationController)
final translationControllerProvider = TranslationControllerProvider._();

/// Holds the latest translation result. `null` means nothing has been
/// translated yet.
final class TranslationControllerProvider
    extends $AsyncNotifierProvider<TranslationController, TranslationResult?> {
  /// Holds the latest translation result. `null` means nothing has been
  /// translated yet.
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

String _$translationControllerHash() =>
    r'0158426b7fe86ae5d8fdbb3821daa36955be6dbd';

/// Holds the latest translation result. `null` means nothing has been
/// translated yet.

abstract class _$TranslationController
    extends $AsyncNotifier<TranslationResult?> {
  FutureOr<TranslationResult?> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<TranslationResult?>, TranslationResult?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<TranslationResult?>, TranslationResult?>,
              AsyncValue<TranslationResult?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
