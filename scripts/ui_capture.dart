// Shared helper for the Flutter driver scripts in this directory.
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// Renders the widget tree under [boundaryKey] to a PNG in `ai/screenshots/`
/// (gitignored) and returns the file path. Pure Flutter rendering, so it
/// works the same on every desktop platform.
Future<String> captureUi(GlobalKey boundaryKey, String prefix) async {
  final boundary = boundaryKey.currentContext!.findRenderObject()! as RenderRepaintBoundary;
  final pixelRatio = ui.PlatformDispatcher.instance.views.first.devicePixelRatio;
  final image = await boundary.toImage(pixelRatio: pixelRatio);
  final data = await image.toByteData(format: ui.ImageByteFormat.png);
  final file = File('ai/screenshots/$prefix-${DateTime.now().millisecondsSinceEpoch}.png')
    ..createSync(recursive: true);
  file.writeAsBytesSync(data!.buffer.asUint8List());
  return file.path;
}
