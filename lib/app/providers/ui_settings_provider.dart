import 'package:kore_translation/app/i18n/translations.g.dart';
import 'package:kore_translation/app/models/ui_settings.dart';
import 'package:kore_translation/app/providers/app_database_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ui_settings_provider.g.dart';

/// App-wide UI preferences, stored in the app database. Loading and saving
/// also apply the language choice to slang (theme needs no side effect —
/// `MaterialApp.themeMode` watches this provider).
@Riverpod(keepAlive: true)
class UiSettingsStorage extends _$UiSettingsStorage {
  @override
  Future<UiSettings> build() async {
    final settings = await ref.watch(appDatabaseProvider).loadUiSettings();
    await _applyLanguage(settings.language);
    return settings;
  }

  Future<void> save(UiSettings settings) async {
    await ref.read(appDatabaseProvider).saveUiSettings(settings);
    await _applyLanguage(settings.language);
    state = AsyncData(settings);
  }

  Future<void> _applyLanguage(AppLanguage language) async {
    await switch (language) {
      AppLanguage.system => LocaleSettings.useDeviceLocale(),
      AppLanguage.ja => LocaleSettings.setLocale(AppLocale.ja),
      AppLanguage.en => LocaleSettings.setLocale(AppLocale.en),
    };
  }
}
