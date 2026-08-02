// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translation_client_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(translationClient)
final translationClientProvider = TranslationClientProvider._();

final class TranslationClientProvider
    extends $FunctionalProvider<AsyncValue<TranslationClient>, TranslationClient, FutureOr<TranslationClient>>
    with $FutureModifier<TranslationClient>, $FutureProvider<TranslationClient> {
  TranslationClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'translationClientProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$translationClientHash();

  @$internal
  @override
  $FutureProviderElement<TranslationClient> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<TranslationClient> create(Ref ref) {
    return translationClient(ref);
  }
}

String _$translationClientHash() => r'740ef5db8bcf1f6725fb7040b6de5a96dd4957cb';
