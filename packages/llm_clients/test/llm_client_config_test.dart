import 'package:json_annotation/json_annotation.dart';
import 'package:llm_clients/llm_clients.dart';
import 'package:test/test.dart';

void main() {
  group('LlmClientConfig', () {
    test('variants carry real defaults', () {
      const config = LlmClientConfig.openAi(apiKey: 'sk-test');
      expect(
        config,
        isA<OpenAiConfig>()
            .having((c) => c.baseUrl, 'baseUrl', 'https://api.openai.com/v1')
            .having((c) => c.model, 'model', 'gpt-5-mini'),
      );
    });

    test('the agent variants carry real defaults too', () {
      expect(
        const LlmClientConfig.codex(),
        isA<CodexConfig>().having((c) => c.command, 'command', 'codex app-server').having((c) => c.model, 'model', ''),
      );
    });

    test('provider maps back to the identity', () {
      expect(
        const LlmClientConfig.anthropic(apiKey: 'k').provider,
        LlmProvider.anthropic,
      );
    });

    test('serializes as a union discriminated by the provider id', () {
      const config = LlmClientConfig.openAi(apiKey: 'sk-test');
      expect(config.toJson(), {
        'provider': 'openai',
        'api_key': 'sk-test',
        'base_url': 'https://api.openai.com/v1',
        'model': 'gpt-5-mini',
        'system_prompt': '',
      });
      expect(LlmClientConfig.fromJson(config.toJson()), config);
    });

    test('fromJson applies the variant defaults to omitted fields', () {
      expect(
        LlmClientConfig.fromJson({'provider': 'codex'}),
        const LlmClientConfig.codex(),
      );
      expect(
        LlmClientConfig.fromJson({'provider': 'anthropic', 'api_key': 'k'}),
        const LlmClientConfig.anthropic(apiKey: 'k'),
      );
    });

    test('fromJson rejects unknown providers and missing required fields', () {
      expect(() => LlmClientConfig.fromJson({'provider': 'nope'}), throwsA(isA<CheckedFromJsonException>()));
      expect(() => LlmClientConfig.fromJson({'provider': 'openai'}), throwsA(isA<CheckedFromJsonException>()));
    });
  });
}
