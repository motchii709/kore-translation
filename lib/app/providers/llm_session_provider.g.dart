// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'llm_session_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The open LLM session, kept alive so the agent backends (ACP / Codex)
/// hold one warm subprocess across translations instead of losing it to
/// auto dispose mid-stream. `KoreApp`'s warm-up listen opens it at startup;
/// a settings change rebuilds it, closing the previous session. A failed or
/// dead session is replaced per user action — see
/// `TranslationController.translate`.

@ProviderFor(llmSession)
final llmSessionProvider = LlmSessionProvider._();

/// The open LLM session, kept alive so the agent backends (ACP / Codex)
/// hold one warm subprocess across translations instead of losing it to
/// auto dispose mid-stream. `KoreApp`'s warm-up listen opens it at startup;
/// a settings change rebuilds it, closing the previous session. A failed or
/// dead session is replaced per user action — see
/// `TranslationController.translate`.

final class LlmSessionProvider extends $FunctionalProvider<AsyncValue<LlmSession>, LlmSession, FutureOr<LlmSession>>
    with $FutureModifier<LlmSession>, $FutureProvider<LlmSession> {
  /// The open LLM session, kept alive so the agent backends (ACP / Codex)
  /// hold one warm subprocess across translations instead of losing it to
  /// auto dispose mid-stream. `KoreApp`'s warm-up listen opens it at startup;
  /// a settings change rebuilds it, closing the previous session. A failed or
  /// dead session is replaced per user action — see
  /// `TranslationController.translate`.
  LlmSessionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'llmSessionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$llmSessionHash();

  @$internal
  @override
  $FutureProviderElement<LlmSession> $createElement($ProviderPointer pointer) => $FutureProviderElement(pointer);

  @override
  FutureOr<LlmSession> create(Ref ref) {
    return llmSession(ref);
  }
}

String _$llmSessionHash() => r'0290e4f3da5fe2db41e01a57ef2fbff39a6538e3';
