// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$translateRoute, $setupRoute];

RouteBase get $translateRoute => GoRouteData.$route(
  path: '/',
  hasOverriddenOnExit: false,
  factory: $TranslateRoute._fromState,
  routes: [
    GoRouteData.$route(
      path: 'settings/model',
      hasOverriddenOnExit: false,
      factory: $ModelSettingsRoute._fromState,
    ),
    GoRouteData.$route(
      path: 'settings/advanced',
      hasOverriddenOnExit: false,
      factory: $AdvancedSettingsRoute._fromState,
    ),
    GoRouteData.$route(
      path: 'entries/:id',
      hasOverriddenOnExit: false,
      factory: $HistoryEntryRoute._fromState,
    ),
  ],
);

mixin $TranslateRoute on GoRouteData {
  static TranslateRoute _fromState(GoRouterState state) =>
      const TranslateRoute();

  @override
  String get location => GoRouteData.$location('/');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ModelSettingsRoute on GoRouteData {
  static ModelSettingsRoute _fromState(GoRouterState state) =>
      const ModelSettingsRoute();

  @override
  String get location => GoRouteData.$location('/settings/model');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $AdvancedSettingsRoute on GoRouteData {
  static AdvancedSettingsRoute _fromState(GoRouterState state) =>
      const AdvancedSettingsRoute();

  @override
  String get location => GoRouteData.$location('/settings/advanced');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $HistoryEntryRoute on GoRouteData {
  static HistoryEntryRoute _fromState(GoRouterState state) =>
      HistoryEntryRoute(id: int.parse(state.pathParameters['id']!));

  HistoryEntryRoute get _self => this as HistoryEntryRoute;

  @override
  String get location => GoRouteData.$location(
    '/entries/${Uri.encodeComponent(_self.id.toString())}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $setupRoute => GoRouteData.$route(
  path: '/setup',
  hasOverriddenOnExit: false,
  factory: $SetupRoute._fromState,
);

mixin $SetupRoute on GoRouteData {
  static SetupRoute _fromState(GoRouterState state) => const SetupRoute();

  @override
  String get location => GoRouteData.$location('/setup');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Whether an LLM profile is stored; null while still loading. A load
/// error counts as unconfigured: the setup page renders it raw.

@ProviderFor(llmConfigured)
final llmConfiguredProvider = LlmConfiguredProvider._();

/// Whether an LLM profile is stored; null while still loading. A load
/// error counts as unconfigured: the setup page renders it raw.

final class LlmConfiguredProvider
    extends $FunctionalProvider<bool?, bool?, bool?>
    with $Provider<bool?> {
  /// Whether an LLM profile is stored; null while still loading. A load
  /// error counts as unconfigured: the setup page renders it raw.
  LlmConfiguredProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'llmConfiguredProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$llmConfiguredHash();

  @$internal
  @override
  $ProviderElement<bool?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool? create(Ref ref) {
    return llmConfigured(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool?>(value),
    );
  }
}

String _$llmConfiguredHash() => r'205e1dafca110e3ce18e52e21fbee5d1e98de62c';

@ProviderFor(appRouter)
final appRouterProvider = AppRouterProvider._();

final class AppRouterProvider
    extends $FunctionalProvider<GoRouter, GoRouter, GoRouter>
    with $Provider<GoRouter> {
  AppRouterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appRouterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appRouterHash();

  @$internal
  @override
  $ProviderElement<GoRouter> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GoRouter create(Ref ref) {
    return appRouter(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoRouter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoRouter>(value),
    );
  }
}

String _$appRouterHash() => r'566c1e8cf1f89a743208fc3fd2611338ae00f3ab';
