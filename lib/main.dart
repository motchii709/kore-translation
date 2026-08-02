import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kore_translation/app/i18n/translations.g.dart';
import 'package:kore_translation/app/models/ui_settings.dart';
import 'package:kore_translation/app/providers/ui_settings_provider.dart';
import 'package:kore_translation/app/router/app_router.dart';
import 'package:kore_translation/app/ui/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(LocaleSettings.useDeviceLocale());
  runApp(TranslationProvider(child: const ProviderScope(child: KoreApp())));
}

class KoreApp extends ConsumerWidget {
  const KoreApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uiSettings = switch (ref.watch(uiSettingsStorageProvider)) {
      AsyncData(:final value) => value,
      // Loading or failed: keep rendering with the defaults — the load
      // error surfaces on the advanced settings page, which also offers
      // the recovery (deleting the database) and must stay reachable.
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
