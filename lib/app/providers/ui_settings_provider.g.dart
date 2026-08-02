// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ui_settings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// App-wide UI preferences, stored in the app database. Loading and saving
/// also apply the language choice to slang (theme needs no side effect —
/// `MaterialApp.themeMode` watches this provider).

@ProviderFor(UiSettingsStorage)
final uiSettingsStorageProvider = UiSettingsStorageProvider._();

/// App-wide UI preferences, stored in the app database. Loading and saving
/// also apply the language choice to slang (theme needs no side effect —
/// `MaterialApp.themeMode` watches this provider).
final class UiSettingsStorageProvider extends $AsyncNotifierProvider<UiSettingsStorage, UiSettings> {
  /// App-wide UI preferences, stored in the app database. Loading and saving
  /// also apply the language choice to slang (theme needs no side effect —
  /// `MaterialApp.themeMode` watches this provider).
  UiSettingsStorageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'uiSettingsStorageProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$uiSettingsStorageHash();

  @$internal
  @override
  UiSettingsStorage create() => UiSettingsStorage();
}

String _$uiSettingsStorageHash() => r'493f9b1bc93031154c2aa748b6fce7b0ed03345c';

/// App-wide UI preferences, stored in the app database. Loading and saving
/// also apply the language choice to slang (theme needs no side effect —
/// `MaterialApp.themeMode` watches this provider).

abstract class _$UiSettingsStorage extends $AsyncNotifier<UiSettings> {
  FutureOr<UiSettings> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<UiSettings>, UiSettings>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<UiSettings>, UiSettings>,
              AsyncValue<UiSettings>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
