// Launches the real app, captures its UI to a PNG, and exits. No API calls.
//
//   mise exec -- flutter run -d <device> -t scripts/capture_ui.dart
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kore_translation/app/i18n/translations.g.dart';
import 'package:kore_translation/main.dart';

import 'ui_capture.dart';

final GlobalKey _boundaryKey = GlobalKey();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    RepaintBoundary(
      key: _boundaryKey,
      child: TranslationProvider(child: const ProviderScope(child: KoreApp())),
    ),
  );

  // Let the first frames render and async providers resolve.
  await Future<void>.delayed(const Duration(seconds: 3));
  final path = await captureUi(_boundaryKey, 'ui');
  stdout.writeln('SCREENSHOT: $path');
  exit(0);
}
