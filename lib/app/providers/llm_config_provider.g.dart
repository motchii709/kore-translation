// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'llm_config_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The stored LLM profile ([LlmClientConfig] is the whole persistence
/// schema; there is nothing to configure outside of it).

@ProviderFor(LlmConfigStorage)
final llmConfigStorageProvider = LlmConfigStorageProvider._();

/// The stored LLM profile ([LlmClientConfig] is the whole persistence
/// schema; there is nothing to configure outside of it).
final class LlmConfigStorageProvider extends $AsyncNotifierProvider<LlmConfigStorage, LlmClientConfig> {
  /// The stored LLM profile ([LlmClientConfig] is the whole persistence
  /// schema; there is nothing to configure outside of it).
  LlmConfigStorageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'llmConfigStorageProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$llmConfigStorageHash();

  @$internal
  @override
  LlmConfigStorage create() => LlmConfigStorage();
}

String _$llmConfigStorageHash() => r'189386149334a05aae330eb9951bf2078cd49466';

/// The stored LLM profile ([LlmClientConfig] is the whole persistence
/// schema; there is nothing to configure outside of it).

abstract class _$LlmConfigStorage extends $AsyncNotifier<LlmClientConfig> {
  FutureOr<LlmClientConfig> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<LlmClientConfig>, LlmClientConfig>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<LlmClientConfig>, LlmClientConfig>,
              AsyncValue<LlmClientConfig>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
