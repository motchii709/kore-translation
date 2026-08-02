import 'package:kore_client/kore_client.dart';
import 'package:test/test.dart';

void main() {
  group('TranslatorConfig', () {
    test('falls back to provider defaults when overrides are empty', () {
      const config = TranslatorConfig(
        provider: LlmProvider.openAi,
        apiKey: 'sk-test',
      );
      expect(config.effectiveBaseUrl, LlmProvider.openAi.defaultBaseUrl);
      expect(config.effectiveModel, LlmProvider.openAi.defaultModel);
    });

    test('prefers explicit overrides', () {
      const config = TranslatorConfig(
        provider: LlmProvider.openAi,
        apiKey: 'sk-test',
        baseUrl: 'http://localhost:11434/v1',
        model: 'llama3',
      );
      expect(config.effectiveBaseUrl, 'http://localhost:11434/v1');
      expect(config.effectiveModel, 'llama3');
    });
  });

  group('Translator.fromConfig', () {
    test('creates the backend matching the provider', () {
      Translator create(LlmProvider provider) => Translator.fromConfig(
            TranslatorConfig(provider: provider, apiKey: 'key'),
          );
      expect(create(LlmProvider.openAi), isA<OpenAiTranslator>());
      expect(create(LlmProvider.anthropic), isA<AnthropicTranslator>());
      expect(create(LlmProvider.google), isA<GeminiTranslator>());
    });
  });

  group('LlmProvider.fromId', () {
    test('resolves known ids and rejects unknown ids', () {
      expect(LlmProvider.fromId('openai'), LlmProvider.openAi);
      expect(LlmProvider.fromId('anthropic'), LlmProvider.anthropic);
      expect(LlmProvider.fromId('google'), LlmProvider.google);
      expect(LlmProvider.fromId('unknown'), isNull);
      expect(LlmProvider.fromId(null), isNull);
    });
  });
}
