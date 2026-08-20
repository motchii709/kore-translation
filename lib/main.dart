import 'dart:async';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kore_translation/app/i18n/translations.g.dart';
import 'package:kore_translation/app/models/ui_settings.dart';
import 'package:kore_translation/app/providers/llm_session_provider.dart';
import 'package:kore_translation/app/providers/ui_settings_provider.dart';
import 'package:kore_translation/app/router/app_router.dart';
import 'package:kore_translation/app/ui/theme/app_theme.dart';
import 'package:kore_translation/app/providers/secure_storage_web.dart';

/// Beta policy: no automatic retries. Riverpod's default keeps a failed
/// provider in loading state while retrying in the background, which turns
/// a deterministic error (e.g. stored data that no longer parses) into an
/// endless spinner instead of a surfaced error.
Duration? noRetry(int retryCount, Object error) => null;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(LocaleSettings.useDeviceLocale());
  
  // Register web-specific secure storage implementation
  if (kIsWeb) {
    SecureStorageWeb.registerWith(null);
  }
  
  runApp(
    TranslationProvider(
      child: const ProviderScope(retry: noRetry, child: KoreApp()),
    ),
  );
}

/// Snackbars from above the router (see the session listener in [KoreApp])
/// need the app-level messenger; `ScaffoldMessenger.of` has no ancestor
/// there.
final _messengerKey = GlobalKey<ScaffoldMessengerState>();

class KoreApp extends ConsumerWidget {
  const KoreApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Warm-up: activating the session provider opens the backend (agent
    // spawn + handshake) at launch and right after a settings change,
    // instead of inside the first translation. Failures surface here as a
    // snackbar; a settings change rebuilds the provider and retries.
    ref.listen(llmSessionProvider, (_, value) {
      if (value case AsyncError()) {
        _messengerKey.currentState?.showSnackBar(SnackBar(content: Text(context.t.error.sessionOpenFailed)));
      } else if (value case AsyncData(value: null)) {
        _messengerKey.currentState?.showSnackBar(SnackBar(content: Text(context.t.error.sessionNotConfigured)));
      }
    });
    final uiSettings = ref.watch(uiSettingsStorageProvider).value ?? const UiSettings();
    return MaterialApp.router(
      title: 'Kore!?',
      scaffoldMessengerKey: _messengerKey,
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
