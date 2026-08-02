// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translation_client_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The translation backend. Kept alive so the agent backends (ACP / Codex)
/// hold one subprocess across translations instead of losing it to auto
/// dispose mid-stream; a settings change rebuilds this provider, which
/// disposes the previous agent.

@ProviderFor(translationClient)
final translationClientProvider = TranslationClientProvider._();

/// The translation backend. Kept alive so the agent backends (ACP / Codex)
/// hold one subprocess across translations instead of losing it to auto
/// dispose mid-stream; a settings change rebuilds this provider, which
/// disposes the previous agent.

final class TranslationClientProvider
    extends
        $FunctionalProvider<
          AsyncValue<TranslationClient>,
          TranslationClient,
          FutureOr<TranslationClient>
        >
    with
        $FutureModifier<TranslationClient>,
        $FutureProvider<TranslationClient> {
  /// The translation backend. Kept alive so the agent backends (ACP / Codex)
  /// hold one subprocess across translations instead of losing it to auto
  /// dispose mid-stream; a settings change rebuilds this provider, which
  /// disposes the previous agent.
  TranslationClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'translationClientProvider',
        isAutoDispose: false,
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

String _$translationClientHash() => r'a6b4cbdf28c0b681c3a1193308fdf338371bbf97';
