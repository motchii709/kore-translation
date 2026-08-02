// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translator_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(translator)
final translatorProvider = TranslatorProvider._();

final class TranslatorProvider
    extends
        $FunctionalProvider<
          AsyncValue<Translator>,
          Translator,
          FutureOr<Translator>
        >
    with $FutureModifier<Translator>, $FutureProvider<Translator> {
  TranslatorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'translatorProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$translatorHash();

  @$internal
  @override
  $FutureProviderElement<Translator> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Translator> create(Ref ref) {
    return translator(ref);
  }
}

String _$translatorHash() => r'44499bf22e1107237d6f294687d142475b4ea7bb';
