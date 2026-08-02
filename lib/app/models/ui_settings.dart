import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ui_settings.freezed.dart';

/// Which hardware-keyboard chord submits the translate input. The unbound
/// chord does the other action (a newline).
enum SubmitShortcut { enter, shiftEnter }

/// The app display language: follow the OS, or force a supported locale.
enum AppLanguage { system, ja, en }

/// App-wide UI preferences, persisted in the app database (nothing here is
/// provider-specific or secret). Edited on the advanced settings page and
/// applied on save.
@freezed
abstract class UiSettings with _$UiSettings {
  const factory UiSettings({
    @Default(ThemeMode.system) ThemeMode themeMode,
    @Default(SubmitShortcut.enter) SubmitShortcut submitShortcut,
    @Default(AppLanguage.system) AppLanguage language,
  }) = _UiSettings;
}
