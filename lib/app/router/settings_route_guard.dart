import 'package:kore_honyaku/app/models/app_settings.dart';
import 'package:kore_honyaku/app/providers/app_settings_provider.dart';
import 'package:kore_honyaku/app/router/app_route_paths.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_route_guard.g.dart';

enum SettingsRouteState {
  loading,
  unconfigured,
  configured,
}

SettingsRouteState settingsRouteStateFromSettings(
  AsyncValue<AppSettings> settings,
) {
  return switch (settings) {
    AsyncLoading() => SettingsRouteState.loading,
    AsyncError() => SettingsRouteState.unconfigured,
    AsyncData(:final value) => value.apiKey.isEmpty
        ? SettingsRouteState.unconfigured
        : SettingsRouteState.configured,
  };
}

String? redirectLocationForSettingsState(
  SettingsRouteState state,
  String location,
) {
  return switch (state) {
    SettingsRouteState.loading => null,
    SettingsRouteState.unconfigured =>
      location == AppRoutePaths.settings ? null : AppRoutePaths.settings,
    SettingsRouteState.configured => null,
  };
}

/// Redirects to the settings page until an API key is configured.
@riverpod
class SettingsRouteGuard extends _$SettingsRouteGuard {
  @override
  SettingsRouteState build() {
    return settingsRouteStateFromSettings(
      ref.watch(appSettingsStorageProvider),
    );
  }

  String? redirectForLocation(String location) {
    return redirectLocationForSettingsState(state, location);
  }
}
