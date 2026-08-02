import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kore_honyaku/app/pages/settings/settings_page.dart';
import 'package:kore_honyaku/app/pages/translate/translate_page.dart';
import 'package:kore_honyaku/app/router/app_route_paths.dart';
import 'package:kore_honyaku/app/router/settings_route_guard.dart';
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
    TypedGoRoute<SettingsRoute>(path: 'settings'),
  ],
)
class TranslateRoute extends GoRouteData with $TranslateRoute {
  const TranslateRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const TranslatePage();
  }
}

class SettingsRoute extends GoRouteData with $SettingsRoute {
  const SettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SettingsPage();
  }
}
