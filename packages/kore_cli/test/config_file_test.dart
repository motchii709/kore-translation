import 'dart:io';

import 'package:kore_cli/src/config_file.dart';
import 'package:llm_clients/llm_clients.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

void main() {
  group('loadCliConfig', () {
    late Directory tempDir;
    setUp(() => tempDir = Directory.systemTemp.createTempSync('kore_cli_test'));
    tearDown(() => tempDir.deleteSync(recursive: true));

    String write(String content) {
      final path = p.join(tempDir.path, 'config.yaml');
      File(path).writeAsStringSync(content);
      return path;
    }

    test('a missing file is an empty configuration', () {
      final config = loadCliConfig(p.join(tempDir.path, 'nope.yaml'));
      expect(config.llm, isNull);
      expect(config.to, isNull);
    });

    test('reads the llm union and the translation defaults', () {
      final config = loadCliConfig(
        write('''
llm:
  provider: anthropic
  api_key: sk-ant-test
  thinking: false
  system_prompt: 関西弁に翻訳して
to: 日本語
tone: フランクに
'''),
      );
      expect(
        config.llm,
        const LlmClientConfig.anthropic(apiKey: 'sk-ant-test', thinking: false, systemPrompt: '関西弁に翻訳して'),
      );
      expect(config.to, '日本語');
      expect(config.tone, 'フランクに');
    });

    test('omitted llm fields fall back to the variant defaults', () {
      expect(loadCliConfig(write('llm:\n  provider: codex')).llm, const LlmClientConfig.codex());
      expect(
        loadCliConfig(write('llm:\n  provider: acp\n  command: npx some-agent')).llm,
        const LlmClientConfig.acp(command: 'npx some-agent'),
      );
    });

    test('the union definition is the schema: missing required fields fail', () {
      expect(
        () => loadCliConfig(write('llm:\n  provider: openai')),
        throwsA(isA<FormatException>().having((e) => e.message, 'message', contains('api_key'))),
      );
    });

    test('rejects an unknown provider', () {
      expect(
        () => loadCliConfig(write('llm:\n  provider: nope')),
        throwsFormatException,
      );
    });

    test('rejects unknown top-level keys so typos fail loudly', () {
      expect(
        () => loadCliConfig(write('llms:\n  provider: codex')),
        throwsA(isA<FormatException>().having((e) => e.message, 'message', contains('llms'))),
      );
      // Keys that moved into the llm block (`thinking`, `prompt` — now
      // `system_prompt`) must fail loudly as leftovers rather than being
      // silently ignored.
      expect(
        () => loadCliConfig(write('thinking: false')),
        throwsA(isA<FormatException>().having((e) => e.message, 'message', contains('thinking'))),
      );
      expect(
        () => loadCliConfig(write('prompt: 関西弁に翻訳して')),
        throwsA(isA<FormatException>().having((e) => e.message, 'message', contains('prompt'))),
      );
    });

    test('rejects wrongly typed values', () {
      expect(() => loadCliConfig(write('llm: codex')), throwsFormatException);
      expect(() => loadCliConfig(write('to:\n  - a')), throwsFormatException);
    });

    test('rejects invalid YAML', () {
      expect(() => loadCliConfig(write('llm: [unclosed')), throwsFormatException);
    });
  });

  group('defaultCliConfigPath', () {
    test('resolves under the home directory', () {
      expect(
        defaultCliConfigPath(const {'HOME': '/home/yuki'}),
        p.join('/home/yuki', '.kore', 'config.yaml'),
      );
      expect(
        defaultCliConfigPath(const {'USERPROFILE': r'C:\Users\yuki'}),
        p.join(r'C:\Users\yuki', '.kore', 'config.yaml'),
      );
    });
  });
}
