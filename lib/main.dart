import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kore_translation/app/i18n/translations.g.dart';
import 'package:kore_translation/app/models/ui_settings.dart';
import 'package:kore_translation/app/providers/ui_settings_provider.dart';
import 'package:kore_translation/app/router/app_router.dart';
import 'package:kore_translation/app/ui/theme/app_theme.dart';

/// Beta policy: no automatic retries. Riverpod's default keeps a failed
/// provider in loading state while retrying in the background, which turns
/// a deterministic error (e.g. stored data that no longer parses) into an
/// endless spinner instead of a surfaced error.
Duration? noRetry(int retryCount, Object error) => null;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(LocaleSettings.useDeviceLocale());
  runApp(
    TranslationProvider(
      child: const ProviderScope(retry: noRetry, child: KoreApp()),
    ),
  );
}

class KoreApp extends ConsumerWidget {
  const KoreApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uiSettings = switch (ref.watch(uiSettingsStorageProvider)) {
      AsyncData(:final value) => value,
      // Loading or failed: keep rendering with the defaults. This fallback
      // is only tolerable because the theme must exist for the first frame
      // (a build-time need, unlike action-path values, which are awaited
      // fresh) and because the load error surfaces on the advanced settings
      // page, which also offers the recovery and must stay reachable.
      _ => const UiSettings(),
    };
    return MaterialApp.router(
      title: 'Kore!?',
      locale: TranslationProvider.of(context).flutterLocale,
      supportedLocales: AppLocaleUtils.supportedLocales,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      theme: buildAppTheme(Brightness.light),
      darkTheme: buildAppTheme(Brightness.dark),
      themeMode: uiSettings.themeMode,
      routerConfig: ref.watch(appRouterProvider),
    );
  }
}
