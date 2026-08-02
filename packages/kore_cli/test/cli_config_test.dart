import 'dart:io';

import 'package:kore_cli/src/cli_config.dart';
import 'package:kore_cli/src/config_file.dart';
import 'package:llm_clients/llm_clients.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

void main() {
  group('resolveCliConfig', () {
    test('command line options win over the config file', () {
      final config = resolveCliConfig(
        providerId: 'anthropic',
        apiKey: 'from-option',
        fileConfig: const {'provider': 'openai', 'api-key': 'from-file'},
      );
      expect(config, isA<AnthropicConfig>().having((c) => c.apiKey, 'apiKey', 'from-option'));
    });

    test('falls back to the config file, then to provider defaults', () {
      final config = resolveCliConfig(
        fileConfig: const {'provider': 'openai', 'api-key': 'sk-file'},
      );
      expect(
        config,
        isA<OpenAiConfig>()
            .having((c) => c.apiKey, 'apiKey', 'sk-file')
            .having((c) => c.baseUrl, 'baseUrl', 'https://api.openai.com/v1')
            .having((c) => c.model, 'model', 'gpt-5-mini'),
      );
    });

    test('routes the agent command of the selected provider', () {
      expect(
        resolveCliConfig(
          fileConfig: const {'provider': 'acp', 'acp-command': 'npx some-agent'},
        ),
        isA<AcpConfig>().having((c) => c.command, 'command', 'npx some-agent'),
      );
      expect(
        resolveCliConfig(
          fileConfig: const {'provider': 'codex', 'codex-command': 'codex-nightly app-server'},
        ),
        isA<CodexConfig>().having((c) => c.command, 'command', 'codex-nightly app-server'),
      );
    });

    test('rejects an unknown provider id', () {
      expect(
        () => resolveCliConfig(fileConfig: const {'provider': 'nope'}),
        throwsFormatException,
      );
    });
  });

  group('loadCliConfigFile', () {
    late Directory tempDir;
    setUp(() => tempDir = Directory.systemTemp.createTempSync('kore_cli_test'));
    tearDown(() => tempDir.deleteSync(recursive: true));

    String write(String content) {
      final path = p.join(tempDir.path, 'config.yaml');
      File(path).writeAsStringSync(content);
      return path;
    }

    test('a missing file is no configuration', () {
      expect(loadCliConfigFile(p.join(tempDir.path, 'nope.yaml')), isEmpty);
    });

    test('reads scalars, stringifying booleans', () {
      final config = loadCliConfigFile(
        write('''
provider: codex
model: gpt-5.6-sol
thinking: false
to: 日本語
'''),
      );
      expect(config, {
        'provider': 'codex',
        'model': 'gpt-5.6-sol',
        'thinking': 'false',
        'to': '日本語',
      });
    });

    test('rejects unknown keys so typos fail loudly', () {
      expect(
        () => loadCliConfigFile(write('providr: openai')),
        throwsA(isA<FormatException>().having((e) => e.message, 'message', contains('providr'))),
      );
    });

    test('rejects non-scalar values', () {
      expect(
        () => loadCliConfigFile(write('model:\n  - a\n  - b')),
        throwsFormatException,
      );
    });

    test('rejects invalid YAML', () {
      expect(
        () => loadCliConfigFile(write('provider: [unclosed')),
        throwsFormatException,
      );
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
