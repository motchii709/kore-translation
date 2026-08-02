import 'dart:io';

import 'package:args/args.dart';
import 'package:dio/dio.dart';
import 'package:json_rpc_2/json_rpc_2.dart';
import 'package:kore_cli/src/cli_config.dart';
import 'package:kore_cli/src/config_file.dart';
import 'package:kore_cli/src/interactive.dart';
import 'package:kore_cli/src/output.dart';
import 'package:kore_cli/src/prompt.dart';
import 'package:kore_client/kore_client.dart';
import 'package:llm_clients/llm_clients.dart';

Future<void> main(List<String> arguments) async {
  final parser = ArgParser()
    ..addOption(
      'provider',
      abbr: 'p',
      allowed: LlmProvider.values.map((p) => p.id),
      help: 'LLMプロバイダ (既定: openai)',
    )
    ..addOption('to', abbr: 't', help: '翻訳先の言語 (既定: English)')
    ..addOption('tone', help: '翻訳のトーン (自由記述、例: "フランクな口調で")')
    ..addOption('prompt', help: 'システムプロンプトを差し替える (応答フォーマットの指示は自動で付加)')
    ..addOption('model', abbr: 'm', help: '使用するモデル')
    ..addOption('base-url', help: 'APIのベースURL')
    ..addOption('api-key', help: 'APIキー')
    ..addOption('acp-command', help: 'ACPエージェントの起動コマンド (-p acp 用)')
    ..addOption(
      'codex-command',
      help: 'Codex app-server の起動コマンド (既定: "codex app-server"、-p codex 用)',
    )
    ..addFlag('thinking', defaultsTo: true, help: '対応モデルの思考を有効にする')
    ..addOption('config', help: '設定ファイルのパス (既定: ~/.kore/config.yaml)')
    ..addFlag('interactive', abbr: 'i', negatable: false, help: '対話(TUI)モード')
    ..addFlag('json', negatable: false, help: '結果をJSONで出力')
    ..addFlag('help', abbr: 'h', negatable: false, help: 'ヘルプを表示');

  final printer = ResultPrinter();

  final ArgResults args;
  final Map<String, String> fileConfig;
  final LlmClientConfig config;
  try {
    args = parser.parse(arguments);
    fileConfig = loadCliConfigFile(args.option('config') ?? defaultCliConfigPath());
    config = resolveCliConfig(
      providerId: args.option('provider'),
      baseUrl: args.option('base-url'),
      apiKey: args.option('api-key'),
      model: args.option('model'),
      acpCommand: args.option('acp-command'),
      codexCommand: args.option('codex-command'),
      fileConfig: fileConfig,
    );
  } on FormatException catch (e) {
    printer.printError(e.message);
    stderr.writeln(parser.usage);
    exitCode = 64;
    return;
  }

  final target = args.option('to') ?? fileConfig['to'] ?? 'English';
  final tone = args.option('tone') ?? fileConfig['tone'] ?? '';
  final customPrompt = args.option('prompt') ?? fileConfig['prompt'];
  final thinking = args.wasParsed('thinking') ? args.flag('thinking') : fileConfig['thinking'] != 'false';

  if (args.flag('help')) {
    stdout.writeln('Kore!? — LLM翻訳CLI');
    stdout.writeln();
    stdout.writeln('使い方: kore [オプション] <翻訳したいテキスト>');
    stdout.writeln('        kore -i   (対話モード)');
    stdout.writeln();
    stdout.writeln(parser.usage);
    stdout.writeln();
    stdout.writeln('設定ファイル: ${defaultCliConfigPath()} (YAML、--config で変更可)');
    stdout.writeln('キー: ${cliConfigKeys.join(' / ')}');
    stdout.writeln('優先順位: オプション > 設定ファイル > 既定値');
    return;
  }

  switch (config) {
    // ACP agents authenticate on their own; they need a launch command.
    case AcpConfig(command: ''):
      printer.printError(
        'ACPコマンドが設定されていません。--acp-command か、設定ファイル '
        '(${defaultCliConfigPath()}) の acp-command を指定してください。',
      );
      exitCode = 78;
      return;
    // Local OpenAI-compatible servers (Ollama, LM Studio) need no API key.
    case OpenAiConfig(apiKey: '') ||
        AnthropicConfig(apiKey: '') ||
        GeminiConfig(apiKey: '') ||
        DeepSeekConfig(apiKey: ''):
      printer.printError(
        'APIキーが設定されていません。--api-key か、設定ファイル '
        '(${defaultCliConfigPath()}) の api-key を指定してください。',
      );
      exitCode = 78;
      return;
    default:
      break;
  }

  Dio dio() => Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 120),
    ),
  );
  final TranslationClient client;
  StdioAgentProcess? agent;
  switch (config) {
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
        thinking: thinking,
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
            thinking: thinking,
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
