import 'dart:io';

import 'package:args/args.dart';
import 'package:dio/dio.dart';
import 'package:json_rpc_2/json_rpc_2.dart';
import 'package:kore_cli/src/config_file.dart';
import 'package:kore_cli/src/interactive.dart';
import 'package:kore_cli/src/output.dart';
import 'package:kore_cli/src/prompt.dart';
import 'package:kore_client/kore_client.dart';
import 'package:llm_clients/llm_clients.dart';

Future<void> main(List<String> arguments) async {
  final parser = ArgParser()
    ..addOption('to', abbr: 't', help: '翻訳先の言語 (既定: English)')
    ..addOption('tone', help: '翻訳のトーン (自由記述、例: "フランクな口調で")')
    ..addOption('config', help: '設定ファイルのパス (既定: ~/.kore/config.yaml)')
    ..addFlag('interactive', abbr: 'i', negatable: false, help: '対話(TUI)モード')
    ..addFlag('json', negatable: false, help: '結果をJSONで出力')
    ..addFlag('help', abbr: 'h', negatable: false, help: 'ヘルプを表示');

  final printer = ResultPrinter();

  final ArgResults args;
  final String configPath;
  final CliConfig cliConfig;
  try {
    args = parser.parse(arguments);
    configPath = args.option('config') ?? defaultCliConfigPath();
    cliConfig = loadCliConfig(configPath);
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
    # thinking: false # 対応プロバイダの思考のオン/オフ
    # system_prompt: 関西弁に翻訳して   # 組み込みプロンプトの差し替え (応答フォーマット指示は自動で付加)
  to: English         # 翻訳オプションの既定 (tone も可)

llm のフィールドはプロバイダごとに api_key / base_url / model / command / thinking / system_prompt です。''');
    return;
  }

  final llm = cliConfig.llm;
  if (llm == null) {
    printer.printError('設定ファイル ($configPath) に llm がありません。(kore -h で設定例)');
    exitCode = 78;
    return;
  }
  switch (llm) {
    // ACP agents authenticate on their own; they need a launch command.
    case AcpConfig(command: ''):
      printer.printError('llm の command が空です。ACPエージェントの起動コマンドを設定してください。');
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

  Dio dio() => Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 120),
    ),
  );
  final TranslationClient client;
  StdioAgentProcess? agent;
  switch (llm) {
    case final OpenAiConfig config:
      client = OpenAiTranslationClient(
        llm: OpenAiLlmClient(config: config, dio: dio()),
      );
    case final OpenAiCompatibleConfig config:
      client = OpenAiCompatibleTranslationClient(
        llm: OpenAiCompatibleLlmClient(config: config, dio: dio()),
      );
    case final AnthropicConfig config:
      client = AnthropicTranslationClient(
        llm: AnthropicLlmClient(config: config, dio: dio()),
      );
    case final GeminiConfig config:
      client = GeminiTranslationClient(
        llm: GeminiLlmClient(config: config, dio: dio()),
      );
    case final DeepSeekConfig config:
      client = DeepSeekTranslationClient(
        llm: DeepSeekLlmClient(config: config, dio: dio()),
      );
    case final AcpConfig config:
      agent = await StdioAgentProcess.start(config.command);
      client = AcpTranslationClient(llm: AcpLlmClient(channel: agent.channel));
    case final CodexConfig config:
      agent = await StdioAgentProcess.start(config.command);
      client = CodexTranslationClient(
        llm: CodexLlmClient(config: config, channel: agent.channel),
      );
  }

  try {
    if (args.flag('interactive')) {
      await InteractiveSession(
        client: client,
        printer: printer,
        initialTarget: target,
        initialTone: tone,
        customPrompt: customPrompt,
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
      final event = await client
          .streamTranslation(
            systemPrompt: buildCliSystemPrompt(
              targetLanguage: target,
              toneInstruction: tone,
              customPrompt: customPrompt,
            ),
            text: text,
          )
          .last;
      final result = event.result;
      if (result == null) {
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
      // JSON-RPC errors, mirroring how DioException stays raw.
      printer.printError(e.message);
      exitCode = 1;
    }
  } finally {
    agent?.kill();
  }
}
