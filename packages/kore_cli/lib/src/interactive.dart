import 'dart:io';

import 'package:dio/dio.dart';
import 'package:json_rpc_2/json_rpc_2.dart';
import 'package:kore_cli/src/output.dart';
import 'package:kore_cli/src/prompt.dart';
import 'package:kore_client/kore_client.dart';
import 'package:llm_sdk_core/llm_sdk_core.dart';

/// Simple interactive TUI: type text to translate, use `:` commands to
/// change settings.
class InteractiveSession {
  InteractiveSession({
    required this.session,
    required this.printer,
    this.initialTarget = 'English',
    this.initialTone = '',
    this.customPrompt = '',
    this.thinking = false,
  });

  final LlmSession session;
  final ResultPrinter printer;
  final String initialTarget;
  final String initialTone;

  /// The llm block's `system_prompt`. When non-empty it replaces the
  /// built-in instruction, and `:to` and `:tone` no longer affect the prompt.
  final String customPrompt;

  /// The profile's thinking flag, passed through to every turn.
  final bool thinking;

  Future<void> run() async {
    var target = initialTarget;
    var tone = initialTone;

    stdout.writeln(printer.bold('Kore翻訳 対話モード'));
    stdout.writeln(
      printer.dim('テキストを入力すると翻訳します。:help でコマンド一覧、:q で終了。'),
    );

    while (true) {
      final label = tone.isEmpty ? target : '$target/$tone';
      stdout.write(printer.cyan('kore($label)> '));
      final line = stdin.readLineSync();
      if (line == null) {
        return;
      }
      final input = line.trim();
      if (input.isEmpty) {
        continue;
      }

      if (input.startsWith(':')) {
        final shouldExit = _handleCommand(
          input,
          onTarget: (value) {
            target = value;
          },
          onTone: (value) {
            tone = value;
          },
        );
        if (shouldExit) {
          return;
        }
        continue;
      }

      stdout.writeln(printer.dim('翻訳中...'));
      try {
        // fold instead of .last: a turn that streams no events must not crash.
        final event = await streamTranslation(
          session,
          systemPrompt: buildCliSystemPrompt(
            targetLanguage: target,
            toneInstruction: tone,
            customPrompt: customPrompt,
          ),
          text: input,
          thinking: thinking,
        ).fold<TranslationEvent?>(null, (_, event) => event);
        final result = event?.result;
        if (result == null || result.translation == null) {
          // The turn completed without delivering a translation (an empty
          // or schema-less reply).
          printer.printError('翻訳結果を取得できませんでした');
        } else {
          printer.printResult(result);
        }
      } on KoreClientException catch (e) {
        printer.printError(e.message);
      } on LlmApiException catch (e) {
        printer.printError(e.message);
      } on DioException catch (e) {
        printer.printError('$e\n${e.response?.data ?? ''}');
      } on RpcException catch (e) {
        // ACP failures (authentication, refused sessions, ...) arrive as
        // raw JSON-RPC errors, mirroring how DioException stays raw. The
        // message is a single sentence by contract; the server detail
        // rides in data.
        printer.printError('$e\n${e.data ?? ''}');
      }
      stdout.writeln();
    }
  }

  /// Returns `true` when the session should exit.
  bool _handleCommand(
    String input, {
    required void Function(String) onTarget,
    required void Function(String) onTone,
  }) {
    final parts = input.split(RegExp(r'\s+'));
    switch (parts.first) {
      case ':q' || ':quit' || ':exit':
        return true;
      case ':to' when parts.length > 1:
        final target = parts.sublist(1).join(' ');
        onTarget(target);
        stdout.writeln(printer.dim('翻訳先を $target に変更しました'));
        _warnIfCustomPrompt();
      case ':to':
        printer.printError(':to には言語を指定してください (例: :to 日本語)');
      case ':tone':
        final tone = parts.sublist(1).join(' ');
        onTone(tone);
        stdout.writeln(
          printer.dim(tone.isEmpty ? 'トーン指示を解除しました' : 'トーンを "$tone" に変更しました'),
        );
        _warnIfCustomPrompt();
      case ':help':
        stdout.writeln('''
:to <言語>     翻訳先の言語を変更 (例: :to 日本語)
:tone <指示>   トーンを自由記述で変更 (例: :tone フランクな口調で) — :tone のみで解除
:help          このヘルプを表示
:q             終了''');
      default:
        printer.printError('不明なコマンドです: $input (:help でヘルプ)');
    }
    return false;
  }

  void _warnIfCustomPrompt() {
    if (customPrompt.isNotEmpty) {
      stdout.writeln(printer.dim('注意: system_prompt が設定されているため、この変更はプロンプトに反映されません'));
    }
  }
}
