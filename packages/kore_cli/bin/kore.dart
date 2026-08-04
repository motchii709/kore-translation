import 'dart:io';

import 'package:args/args.dart';
import 'package:dio/dio.dart';
import 'package:json_rpc_2/json_rpc_2.dart';
import 'package:kore_backends/kore_backends.dart';
import 'package:kore_cli/src/config_file.dart';
import 'package:kore_cli/src/interactive.dart';
import 'package:kore_cli/src/output.dart';
import 'package:kore_cli/src/prompt.dart';
import 'package:kore_client/kore_client.dart';
import 'package:kore_config/kore_config.dart';
import 'package:llm_sdk_core/llm_sdk_core.dart';

Future<void> main(List<String> arguments) async {
  final parser = ArgParser()
    ..addOption('to', abbr: 't', help: '翻訳先の言語 (既定: English)')
    ..addOption('tone', help: '翻訳のトーン (自由記述、例: "フランクな口調で")')
    ..addOption('config', help: '設定ファイルのパス (既定: ~/.kore/config.yaml)')
    ..addFlag('thinking', defaultsTo: true, help: '対応プロバイダの思考のオン/オフ (--no-thinking で無効)')
    ..addFlag('interactive', abbr: 'i', negatable: false, help: '対話(TUI)モード')
    ..addFlag('json', negatable: false, help: '結果をJSONで出力')
    ..addFlag('help', abbr: 'h', negatable: false, help: 'ヘルプを表示');

  final printer = ResultPrinter();

  final ArgResults args;
  try {
    args = parser.parse(arguments);
  } on FormatException catch (e) {
    printer.printError(e.message);
    stderr.writeln(parser.usage);
    exitCode = 64;
    return;
  }

  if (args.flag('help')) {
    stdout.writeln('Kore翻訳 — LLM翻訳CLI');
    stdout.writeln();
    stdout.writeln('使い方: kore [オプション] <翻訳したいテキスト>');
    stdout.writeln('        kore -i   (対話モード)');
    stdout.writeln();
    stdout.writeln(parser.usage);
    stdout.writeln();
    stdout.writeln('接続設定は設定ファイルでのみ定義します: ${defaultCliConfigPath()}');
    stdout.writeln('''
例:
  llm:
    provider: codex   # openai / openai-compatible / anthropic / google / deepseek / acp / codex
    # model: gpt-5.6-sol
    # system_prompt: ...               # プロンプト全体の差し替え (応答フォーマット指示も自前で書く)
  to: English         # 翻訳オプションの既定 (tone も可)

llm のフィールドはプロバイダごとに api_key / base_url / model / command / system_prompt です。
思考のオン/オフは実行時の --thinking / --no-thinking で選びます。''');
    return;
  }

  final configPath = args.option('config') ?? defaultCliConfigPath();
  final CliConfig cliConfig;
  try {
    cliConfig = loadCliConfig(configPath);
  } on FormatException catch (e) {
    // A broken config file is a configuration error, not a usage error.
    printer.printError(e.message);
    exitCode = 78;
    return;
  }

  final llm = cliConfig.llm;
  if (llm == null) {
    printer.printError('設定ファイル ($configPath) に llm がありません。(kore -h で設定例)');
    exitCode = 78;
    return;
  }
  switch (llm) {
    // Agent backends authenticate on their own; they need a launch command.
    case AcpConfig(command: '') || CodexConfig(command: ''):
      printer.printError('llm の command が空です。エージェントの起動コマンドを設定してください。');
      exitCode = 78;
      return;
    // Local OpenAI-compatible servers (Ollama, LM Studio) need no API key.
    case OpenAiConfig(apiKey: '') ||
        AnthropicConfig(apiKey: '') ||
        GeminiConfig(apiKey: '') ||
        DeepSeekConfig(apiKey: ''):
      printer.printError('llm の api_key が空です。');
      exitCode = 78;
      return;
    default:
      break;
  }

  final target = args.option('to') ?? cliConfig.to ?? 'English';
  final tone = args.option('tone') ?? cliConfig.tone ?? '';
  // The prompt template is part of the provider profile; empty means the
  // built-in translator instruction.
  final customPrompt = llm.systemPrompt;

  final LlmSession session;
  try {
    session = await llmClientFrom(llm).open();
  } on LlmApiException catch (e) {
    // Agent backends spawn and handshake during open, so a broken setup
    // (missing command, not an agent) fails here with the process's trail.
    printer.printError(e.message);
    exitCode = 1;
    return;
  } on RpcException catch (e) {
    printer.printError('$e\n${e.data ?? ''}');
    exitCode = 1;
    return;
  }

  try {
    if (args.flag('interactive')) {
      await InteractiveSession(
        session: session,
        printer: printer,
        initialTarget: target,
        initialTone: tone,
        customPrompt: customPrompt,
        thinking: args.flag('thinking'),
      ).run();
      return;
    }

    final text = args.rest.join(' ').trim();
    if (text.isEmpty) {
      printer.printError('翻訳するテキストを指定してください。(kore -h でヘルプ)');
      exitCode = 64;
      return;
    }

    try {
      // fold instead of .last: a turn that streams no events must not crash.
      final event = await streamTranslation(
        session,
        systemPrompt: buildCliSystemPrompt(
          targetLanguage: target,
          toneInstruction: tone,
          customPrompt: customPrompt,
        ),
        text: text,
        thinking: args.flag('thinking'),
      ).fold<TranslationEvent?>(null, (_, event) => event);
      final result = event?.result;
      if (result == null || result.translation == null) {
        // The turn completed without delivering a translation (an empty or
        // schema-less reply).
        printer.printError('翻訳結果を取得できませんでした');
        exitCode = 1;
        return;
      }
      printer.printResult(result, asJson: args.flag('json'));
    } on KoreClientException catch (e) {
      printer.printError(e.message);
      exitCode = 1;
    } on LlmApiException catch (e) {
      printer.printError(e.message);
      exitCode = 1;
    } on DioException catch (e) {
      // DioException.toString() does not include the response body, which
      // carries the API's actual error message.
      printer.printError('$e\n${e.response?.data ?? ''}');
      exitCode = 1;
    } on RpcException catch (e) {
      // ACP failures (authentication, refused sessions, ...) arrive as raw
      // JSON-RPC errors, mirroring how DioException stays raw. The message
      // is a single sentence by contract; the server detail rides in data.
      printer.printError('$e\n${e.data ?? ''}');
      exitCode = 1;
    }
  } finally {
    await session.close();
  }
}
