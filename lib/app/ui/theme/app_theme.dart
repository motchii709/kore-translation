import 'package:flutter/material.dart';

const _seedColor = Color(0xFF3D5AFE);

ThemeData buildAppTheme(Brightness brightness) {
  final colorScheme = ColorScheme.fromSeed(
    seedColor: _seedColor,
    brightness: brightness,
  );
  return ThemeData(
    colorScheme: colorScheme,
    appBarTheme: const AppBarTheme(centerTitle: false),
    // The checkmark widens a selected chip and shifts the whole row;
    // selection is already conveyed by the chip's color.
    chipTheme: const ChipThemeData(showCheckmark: false),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
    snackBarTheme: const SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
    ),
  );
}
