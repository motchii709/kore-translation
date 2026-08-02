import 'dart:io';

import 'package:args/args.dart';
import 'package:kore_cli/src/cli_config.dart';
import 'package:kore_cli/src/interactive.dart';
import 'package:kore_cli/src/output.dart';
import 'package:kore_client/kore_client.dart';

Future<void> main(List<String> arguments) async {
  final parser = ArgParser()
    ..addOption(
      'provider',
      abbr: 'p',
      allowed: LlmProvider.values.map((p) => p.id),
      help: 'LLMプロバイダ (既定: KORE_PROVIDER または openai)',
    )
    ..addOption('to', abbr: 't', defaultsTo: 'English', help: '翻訳先の言語')
    ..addOption(
      'tone',
      defaultsTo: ToneStyle.auto.name,
      allowed: ToneStyle.values.map((t) => t.name),
      help: '翻訳のトーン',
    )
    ..addOption('model', abbr: 'm', help: '使用するモデル (既定: KORE_MODEL)')
    ..addOption('base-url', help: 'APIのベースURL (既定: KORE_BASE_URL)')
    ..addOption('api-key', help: 'APIキー (既定: KORE_API_KEY など)')
    ..addFlag('interactive', abbr: 'i', negatable: false, help: '対話(TUI)モード')
    ..addFlag('json', negatable: false, help: '結果をJSONで出力')
    ..addFlag('help', abbr: 'h', negatable: false, help: 'ヘルプを表示');

  final printer = ResultPrinter();

  final ArgResults args;
  final TranslatorConfig config;
  try {
    args = parser.parse(arguments);
    config = resolveCliConfig(
      providerId: args.option('provider'),
      baseUrl: args.option('base-url'),
      apiKey: args.option('api-key'),
      model: args.option('model'),
    );
  } on FormatException catch (e) {
    printer.printError(e.message);
    stderr.writeln(parser.usage);
    exitCode = 64;
    return;
  }

  if (args.flag('help')) {
    stdout.writeln('Kore!? — LLM翻訳CLI');
    stdout.writeln();
    stdout.writeln('使い方: kore [オプション] <翻訳したいテキスト>');
    stdout.writeln('        kore -i   (対話モード)');
    stdout.writeln();
    stdout.writeln(parser.usage);
    stdout.writeln();
    stdout.writeln('環境変数: KORE_PROVIDER / KORE_BASE_URL / KORE_MODEL / '
        'KORE_API_KEY');
    stdout.writeln(
      'APIキーは ${LlmProvider.values.map((p) => p.apiKeyEnvName).join(' / ')} '
      'からも読み込まれます。',
    );
    return;
  }

  if (config.apiKey.isEmpty) {
    printer.printError(
      'APIキーが設定されていません。KORE_API_KEY か '
      '${config.provider.apiKeyEnvName} 環境変数、または --api-key を指定してください。',
    );
    exitCode = 78;
    return;
  }

  final translator = Translator.fromConfig(config);

  if (args.flag('interactive')) {
    await InteractiveSession(
      translator: translator,
      printer: printer,
      initialTarget: args.option('to')!,
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
    final result = await translator.translate(
      TranslationRequest(
        text: text,
        targetLanguage: args.option('to')!,
        tone: ToneStyle.values.byName(args.option('tone')!),
      ),
    );
    printer.printResult(result, asJson: args.flag('json'));
  } on KoreClientException catch (e) {
    printer.printError(e.message);
    exitCode = 1;
  }
}
