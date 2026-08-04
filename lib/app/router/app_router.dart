import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kore_translation/app/pages/settings/advanced_settings_page.dart';
import 'package:kore_translation/app/pages/settings/model_settings_page.dart';
import 'package:kore_translation/app/pages/translate/history_entry_page.dart';
import 'package:kore_translation/app/pages/translate/translate_page.dart';
import 'package:kore_translation/app/providers/llm_config_provider.dart';
import 'package:kore_translation/app/router/app_route_paths.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

/// Whether an LLM profile is stored; null while still loading. A load
/// error counts as unconfigured: the setup page renders it raw.
@riverpod
bool? llmConfigured(Ref ref) => switch (ref.watch(llmConfigStorageProvider)) {
  AsyncData(:final value) => value != null,
  AsyncError() => false,
  _ => null,
};

@riverpod
GoRouter appRouter(Ref ref) {
  final goRouter = GoRouter(
    initialLocation: AppRoutePaths.translate,
    routes: $appRoutes,
    // Confines the user to the setup page until a profile is saved, and
    // ejects them from it once one is. Pop never runs a redirect, so
    // back-impossibility comes from /setup being a top-level route with
    // nothing beneath it.
    redirect: (_, state) => switch (ref.read(llmConfiguredProvider)) {
      false when state.matchedLocation != AppRoutePaths.setup => AppRoutePaths.setup,
      true when state.matchedLocation == AppRoutePaths.setup => AppRoutePaths.translate,
      _ => null,
    },
  );

  // Listening to the derived provider (not the storage) matters: the router
  // refreshes synchronously, and only the derived provider is guaranteed to
  // be recomputed by the time its own listener fires.
  ref.listen(llmConfiguredProvider, (_, _) => goRouter.refresh());
  return goRouter;
}

@TypedGoRoute<TranslateRoute>(
  path: AppRoutePaths.translate,
  routes: <TypedRoute<RouteData>>[
    TypedGoRoute<ModelSettingsRoute>(path: 'settings/model'),
    TypedGoRoute<AdvancedSettingsRoute>(path: 'settings/advanced'),
    TypedGoRoute<HistoryEntryRoute>(path: 'entries/:id'),
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

/// One translation, live or stored — the narrow layout's destination after
/// submitting or picking a history entry; wide layouts use the result pane.
class HistoryEntryRoute extends GoRouteData with $HistoryEntryRoute {
  const HistoryEntryRoute({required this.id});

  final int id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return HistoryEntryPage(id: id);
  }
}

/// The model settings again, but top-level: the redirect target while no
/// usable profile exists.
@TypedGoRoute<SetupRoute>(path: AppRoutePaths.setup)
class SetupRoute extends GoRouteData with $SetupRoute {
  const SetupRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ModelSettingsPage();
  }
}
