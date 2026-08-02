import 'dart:io';

import 'package:dio/dio.dart';
import 'package:json_rpc_2/json_rpc_2.dart';
import 'package:kore_cli/src/output.dart';
import 'package:kore_cli/src/prompt.dart';
import 'package:kore_client/kore_client.dart';
import 'package:llm_clients/llm_clients.dart';

/// Simple interactive TUI: type text to translate, use `:` commands to
/// change settings.
class InteractiveSession {
  InteractiveSession({
    required this.client,
    required this.printer,
    this.initialTarget = 'English',
    this.initialTone = '',
    this.customPrompt = '',
  });

  final TranslationClient client;
  final ResultPrinter printer;
  final String initialTarget;
  final String initialTone;

  /// The llm block's `system_prompt`. When non-empty it replaces the
  /// built-in instruction, and `:to` and `:tone` no longer affect the prompt.
  final String customPrompt;

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
        final event = await client
            .streamTranslation(
              systemPrompt: buildCliSystemPrompt(
                targetLanguage: target,
                toneInstruction: tone,
                customPrompt: customPrompt,
              ),
              text: input,
            )
            .last;
        final result = event.result;
        if (result == null) {
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
        // raw JSON-RPC errors, mirroring how DioException stays raw.
        printer.printError(e.message);
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
      case ':tone':
        final tone = parts.sublist(1).join(' ');
        onTone(tone);
        stdout.writeln(
          printer.dim(tone.isEmpty ? 'トーン指示を解除しました' : 'トーンを "$tone" に変更しました'),
        );
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
}
