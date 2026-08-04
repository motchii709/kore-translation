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
    if (result.detectedLanguage case final detected?) {
      // The output language is the model's decision, so it is shown too
      // (mirrors the app); null means the model did not provide it.
      stdout.writeln(
        dim(switch (result.targetLanguage) {
          final target? => '$detected → $target',
          null => '検出言語: $detected',
        }),
      );
    }
    stdout.writeln(bold(result.translation ?? ''));
    // The explanation belongs right under the result it explains (mirrors
    // the app and the schema order).
    if (result.explanation case final explanation?) {
      stdout.writeln();
      stdout.writeln(yellow('解説:'));
      stdout.writeln(explanation);
    }
    if (result.alternatives case final alternatives?) {
      stdout.writeln();
      stdout.writeln(cyan('別の言い方:'));
      for (final alt in alternatives) {
        stdout.writeln('  • ${alt.text ?? ''}');
        if (alt.nuance case final nuance?) {
          stdout.writeln(dim('    $nuance'));
        }
      }
    }
  }

  void printError(Object error) {
    stderr.writeln(_style('エラー: $error', '31'));
  }
}
