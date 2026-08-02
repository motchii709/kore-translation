// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_route_guard.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Redirects to the settings page until a usable LLM profile is configured.

@ProviderFor(SettingsRouteGuard)
final settingsRouteGuardProvider = SettingsRouteGuardProvider._();

/// Redirects to the settings page until a usable LLM profile is configured.
final class SettingsRouteGuardProvider extends $NotifierProvider<SettingsRouteGuard, SettingsRouteState> {
  /// Redirects to the settings page until a usable LLM profile is configured.
  SettingsRouteGuardProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settingsRouteGuardProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$settingsRouteGuardHash();

  @$internal
  @override
  SettingsRouteGuard create() => SettingsRouteGuard();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SettingsRouteState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SettingsRouteState>(value),
    );
  }
}

String _$settingsRouteGuardHash() => r'3d588f2c5c715f3c44e5cc1d8f1cebd559540789';

/// Redirects to the settings page until a usable LLM profile is configured.

abstract class _$SettingsRouteGuard extends $Notifier<SettingsRouteState> {
  SettingsRouteState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<SettingsRouteState, SettingsRouteState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SettingsRouteState, SettingsRouteState>,
              SettingsRouteState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
