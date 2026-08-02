import 'dart:convert';
import 'dart:io';

import 'package:kore_client/kore_client.dart';

/// Renders a [TranslationResult] to stdout, with ANSI colors when supported.
class ResultPrinter {
  ResultPrinter({bool? ansi}) : _ansi = ansi ?? stdout.supportsAnsiEscapes;

  final bool _ansi;

  String _style(String text, String code) => _ansi ? '\x1B[${code}m$text\x1B[0m' : text;

  String bold(String text) => _style(text, '1');
  String dim(String text) => _style(text, '2');
  String cyan(String text) => _style(text, '36');
  String yellow(String text) => _style(text, '33');

  void printResult(TranslationResult result, {bool asJson = false}) {
    if (asJson) {
      const encoder = JsonEncoder.withIndent('  ');
      stdout.writeln(encoder.convert(result.toJson()));
      return;
    }
    if (result.detectedLanguage.isNotEmpty) {
      stdout.writeln(dim('検出言語: ${result.detectedLanguage}'));
    }
    stdout.writeln(bold(result.translation));
    if (result.alternatives.isNotEmpty) {
      stdout.writeln();
      stdout.writeln(cyan('別の言い方:'));
      for (final alt in result.alternatives) {
        stdout.writeln('  • ${alt.text}');
        if (alt.nuance.isNotEmpty) {
          stdout.writeln(dim('    ${alt.nuance}'));
        }
      }
    }
    if (result.explanation.isNotEmpty) {
      stdout.writeln();
      stdout.writeln(yellow('解説:'));
      stdout.writeln(result.explanation);
    }
  }

  void printError(Object error) {
    stderr.writeln(_style('エラー: $error', '31'));
  }
}
