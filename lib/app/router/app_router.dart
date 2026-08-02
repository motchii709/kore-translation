import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kore_translation/app/pages/settings/advanced_settings_page.dart';
import 'package:kore_translation/app/pages/settings/model_settings_page.dart';
import 'package:kore_translation/app/pages/translate/translate_page.dart';
import 'package:kore_translation/app/router/app_route_paths.dart';
import 'package:kore_translation/app/router/settings_route_guard.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(Ref ref) {
  final goRouter = GoRouter(
    initialLocation: AppRoutePaths.translate,
    routes: $appRoutes,
    redirect: (_, state) => ref.read(settingsRouteGuardProvider.notifier).redirectForLocation(state.matchedLocation),
  );

  ref.listen(
    settingsRouteGuardProvider,
    (previous, next) => goRouter.refresh(),
  );
  return goRouter;
}

@TypedGoRoute<TranslateRoute>(
  path: AppRoutePaths.translate,
  routes: <TypedRoute<RouteData>>[
    TypedGoRoute<ModelSettingsRoute>(path: 'settings/model'),
    TypedGoRoute<AdvancedSettingsRoute>(path: 'settings/advanced'),
  ],
)
class TranslateRoute extends GoRouteData with $TranslateRoute {
  const TranslateRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const TranslatePage();
  }
}

class ModelSettingsRoute extends GoRouteData with $ModelSettingsRoute {
  const ModelSettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ModelSettingsPage();
  }
}

class AdvancedSettingsRoute extends GoRouteData with $AdvancedSettingsRoute {
  const AdvancedSettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AdvancedSettingsPage();
  }
}
