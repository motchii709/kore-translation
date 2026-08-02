import 'package:llm_clients/llm_clients.dart';
import 'package:test/test.dart';

void main() {
  group('LlmClientConfig', () {
    test('variants carry real defaults', () {
      const config = LlmClientConfig.openAi(apiKey: 'sk-test');
      expect(config, isA<OpenAiConfig>().having((c) => c.baseUrl, 'baseUrl', 'https://api.openai.com/v1').having((c) => c.model, 'model', 'gpt-5-mini'));
    });

    test('forProvider builds the variant matching the provider', () {
      LlmClientConfig configOf(LlmProvider provider) => LlmClientConfig.forProvider(provider, apiKey: 'key');

      expect(configOf(LlmProvider.openAi), isA<OpenAiConfig>());
      expect(configOf(LlmProvider.openAiCompatible), isA<OpenAiCompatibleConfig>());
      expect(configOf(LlmProvider.anthropic), isA<AnthropicConfig>());
      expect(configOf(LlmProvider.google), isA<GeminiConfig>());
      expect(configOf(LlmProvider.deepSeek), isA<DeepSeekConfig>());
      expect(configOf(LlmProvider.acp), isA<AcpConfig>());
      expect(configOf(LlmProvider.codex), isA<CodexConfig>());
    });

    test('forProvider treats empty strings as "use the default"', () {
      final config = LlmClientConfig.forProvider(
        LlmProvider.openAi,
        apiKey: 'sk-test',
      );
      expect(config, isA<OpenAiConfig>().having((c) => c.baseUrl, 'baseUrl', 'https://api.openai.com/v1').having((c) => c.model, 'model', 'gpt-5-mini'));
    });

    test('forProvider prefers explicit overrides', () {
      final config = LlmClientConfig.forProvider(
        LlmProvider.openAi,
        apiKey: 'sk-test',
        baseUrl: 'http://localhost:11434/v1',
        model: 'llama3',
      );
      expect(config, isA<OpenAiConfig>().having((c) => c.baseUrl, 'baseUrl', 'http://localhost:11434/v1').having((c) => c.model, 'model', 'llama3'));
    });

    test('forProvider carries the ACP command through', () {
      final config = LlmClientConfig.forProvider(
        LlmProvider.acp,
        command: 'npx -y @agentclientprotocol/claude-agent-acp',
      );
      expect(config, isA<AcpConfig>().having((c) => c.command, 'command', 'npx -y @agentclientprotocol/claude-agent-acp'));
    });

    test('forProvider merges the Codex defaults', () {
      expect(
        LlmClientConfig.forProvider(LlmProvider.codex),
        isA<CodexConfig>().having((c) => c.command, 'command', 'codex app-server').having((c) => c.model, 'model', ''),
      );
      expect(
        LlmClientConfig.forProvider(LlmProvider.codex, command: 'codex-nightly app-server', model: 'gpt-5.6-sol'),
        isA<CodexConfig>().having((c) => c.command, 'command', 'codex-nightly app-server').having((c) => c.model, 'model', 'gpt-5.6-sol'),
      );
    });

    test('provider maps back to the identity', () {
      expect(
        const LlmClientConfig.anthropic(apiKey: 'k').provider,
        LlmProvider.anthropic,
      );
    });
  });

  group('LlmProvider.fromId', () {
    test('resolves known ids and rejects unknown ids', () {
      expect(LlmProvider.fromId('openai'), LlmProvider.openAi);
      expect(LlmProvider.fromId('anthropic'), LlmProvider.anthropic);
      expect(LlmProvider.fromId('google'), LlmProvider.google);
      expect(LlmProvider.fromId('deepseek'), LlmProvider.deepSeek);
      expect(LlmProvider.fromId('acp'), LlmProvider.acp);
      expect(LlmProvider.fromId('codex'), LlmProvider.codex);
      expect(LlmProvider.fromId('unknown'), isNull);
      expect(LlmProvider.fromId(null), isNull);
    });
  });
}
