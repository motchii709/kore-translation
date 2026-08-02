import 'dart:io';

import 'package:kore_cli/src/output.dart';
import 'package:kore_client/kore_client.dart';

/// Simple interactive TUI: type text to translate, use `:` commands to
/// change settings.
class InteractiveSession {
  InteractiveSession({
    required this.translator,
    required this.printer,
    this.initialTarget = 'English',
  });

  final Translator translator;
  final ResultPrinter printer;
  final String initialTarget;

  Future<void> run() async {
    var target = initialTarget;
    var tone = ToneStyle.auto;

    stdout.writeln(printer.bold('Kore!? 対話モード'));
    stdout.writeln(
      printer.dim('テキストを入力すると翻訳します。:help でコマンド一覧、:q で終了。'),
    );

    while (true) {
      stdout.write(printer.cyan('kore($target/${tone.name})> '));
      final line = stdin.readLineSync();
      if (line == null) {
        return;
      }
      final input = line.trim();
      if (input.isEmpty) {
        continue;
      }

      if (input.startsWith(':')) {
        final shouldExit = _handleCommand(input, onTarget: (value) {
          target = value;
        }, onTone: (value) {
          tone = value;
        });
        if (shouldExit) {
          return;
        }
        continue;
      }

      stdout.writeln(printer.dim('翻訳中...'));
      try {
        final result = await translator.translate(
          TranslationRequest(
            text: input,
            targetLanguage: target,
            tone: tone,
          ),
        );
        printer.printResult(result);
      } on KoreClientException catch (e) {
        printer.printError(e.message);
      }
      stdout.writeln();
    }
  }

  /// Returns `true` when the session should exit.
  bool _handleCommand(
    String input, {
    required void Function(String) onTarget,
    required void Function(ToneStyle) onTone,
  }) {
    final parts = input.split(RegExp(r'\s+'));
    switch (parts.first) {
      case ':q' || ':quit' || ':exit':
        return true;
      case ':to' when parts.length > 1:
        final target = parts.sublist(1).join(' ');
        onTarget(target);
        stdout.writeln(printer.dim('翻訳先を $target に変更しました'));
      case ':tone' when parts.length > 1:
        final tone = ToneStyle.values.asNameMap()[parts[1]];
        if (tone == null) {
          printer.printError(
            'トーンは ${ToneStyle.values.map((t) => t.name).join(' / ')} から選んでください',
          );
        } else {
          onTone(tone);
          stdout.writeln(printer.dim('トーンを ${tone.name} に変更しました'));
        }
      case ':help':
        stdout.writeln('''
:to <言語>     翻訳先の言語を変更 (例: :to 日本語)
:tone <トーン>  トーンを変更 (${ToneStyle.values.map((t) => t.name).join(' / ')})
:help          このヘルプを表示
:q             終了''');
      default:
        printer.printError('不明なコマンドです: $input (:help でヘルプ)');
    }
    return false;
  }
}
