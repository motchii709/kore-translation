import 'package:kore_config/kore_config.dart';
import 'package:kore_translation/app/providers/llm_config_provider.dart';
import 'package:kore_translation/app/router/app_route_paths.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_route_guard.g.dart';

enum SettingsRouteState {
  loading,
  unconfigured,
  configured,
}

/// Whether translation can be attempted with this profile — the route
/// guard's definition of "configured".
///
/// OpenAI-compatible endpoints may be local servers without authentication,
/// so they require an endpoint and model instead of an API key. Agent
/// backends hold their own credentials and only need a launch command.
extension on LlmClientConfig {
  bool get isConfigured => switch (this) {
    OpenAiCompatibleConfig(:final baseUrl, :final model) => baseUrl.isNotEmpty && model.isNotEmpty,
    AcpConfig(:final command) || CodexConfig(:final command) => command.isNotEmpty,
    OpenAiConfig(:final apiKey) ||
    AnthropicConfig(:final apiKey) ||
    GeminiConfig(:final apiKey) ||
    DeepSeekConfig(:final apiKey) => apiKey.isNotEmpty,
  };
}

SettingsRouteState settingsRouteStateFromConfig(
  AsyncValue<LlmClientConfig> config,
) {
  return switch (config) {
    AsyncLoading() => SettingsRouteState.loading,
    // A load error redirects like a missing profile: the model settings
    // page renders the raw error, and the advanced settings (with the
    // delete buttons) stay reachable from there.
    AsyncError() => SettingsRouteState.unconfigured,
    AsyncData(:final value) => value.isConfigured ? SettingsRouteState.configured : SettingsRouteState.unconfigured,
  };
}

String? redirectLocationForSettingsState(
  SettingsRouteState state,
  String location,
) {
  return switch (state) {
    SettingsRouteState.loading => null,
    // Any settings page may be visited while unconfigured; everything else
    // lands on the model settings, where the missing profile lives.
    SettingsRouteState.unconfigured => location.startsWith(AppRoutePaths.settings) ? null : AppRoutePaths.modelSettings,
    SettingsRouteState.configured => null,
  };
}

/// Redirects to the settings page until a usable LLM profile is configured.
@riverpod
class SettingsRouteGuard extends _$SettingsRouteGuard {
  @override
  SettingsRouteState build() {
    return settingsRouteStateFromConfig(
      ref.watch(llmConfigStorageProvider),
    );
  }

  String? redirectForLocation(String location) {
    return redirectLocationForSettingsState(state, location);
  }
}
