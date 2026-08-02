import 'package:kore_client/kore_client.dart';
import 'package:test/test.dart';

void main() {
  group('LlmClientConfig', () {
    test('variants carry real defaults', () {
      const config = LlmClientConfig.openAi(apiKey: 'sk-test');
      expect(config.baseUrl, 'https://api.openai.com/v1');
      expect(config.model, 'gpt-5-mini');
    });

    test('forProvider builds the variant matching the provider', () {
      LlmClientConfig configOf(LlmProvider provider) => LlmClientConfig.forProvider(provider, apiKey: 'key');

      expect(configOf(LlmProvider.openAi), isA<OpenAiConfig>());
      expect(configOf(LlmProvider.openAiCompatible), isA<OpenAiCompatibleConfig>());
      expect(configOf(LlmProvider.anthropic), isA<AnthropicConfig>());
      expect(configOf(LlmProvider.google), isA<GeminiConfig>());
      expect(configOf(LlmProvider.deepSeek), isA<DeepSeekConfig>());
    });

    test('forProvider treats empty strings as "use the default"', () {
      final config = LlmClientConfig.forProvider(
        LlmProvider.openAi,
        apiKey: 'sk-test',
      );
      expect(config.baseUrl, 'https://api.openai.com/v1');
      expect(config.model, 'gpt-5-mini');
    });

    test('forProvider prefers explicit overrides', () {
      final config = LlmClientConfig.forProvider(
        LlmProvider.openAi,
        apiKey: 'sk-test',
        baseUrl: 'http://localhost:11434/v1',
        model: 'llama3',
      );
      expect(config.baseUrl, 'http://localhost:11434/v1');
      expect(config.model, 'llama3');
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
      expect(LlmProvider.fromId('unknown'), isNull);
      expect(LlmProvider.fromId(null), isNull);
    });
  });
}
