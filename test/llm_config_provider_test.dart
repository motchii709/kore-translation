import 'dart:convert';

import 'package:flutter_secure_storage/test/test_flutter_secure_storage_platform.dart';
import 'package:flutter_secure_storage_platform_interface/flutter_secure_storage_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kore_translation/app/constants/translation_prompt.dart';
import 'package:kore_translation/app/i18n/translations.g.dart';
import 'package:kore_translation/app/providers/llm_config_provider.dart';
import 'package:llm_clients/llm_clients.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Map<String, String> useStorage(Map<String, String> data) {
    FlutterSecureStoragePlatform.instance = TestFlutterSecureStoragePlatform(data);
    return data;
  }

  ProviderContainer container() {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    return container;
  }

  test('empty storage yields the fresh-install default', () async {
    useStorage({});
    final config = await container().read(llmConfigStorageProvider.future);

    // Tests run under the base locale (ja), so the seeded template is the
    // Japanese-language one.
    expect(config, defaultLlmConfig);
    expect(config.systemPrompt, defaultTranslationPromptTemplate);
  });

  test('data from another schema version is discarded wholesale', () async {
    final data = useStorage({
      // The version-1 layout: the system prompt lived outside the union.
      'schema_version': '1',
      'llm': '{"provider":"openai","api_key":"sk-old"}',
      'system_prompt': 'old prompt',
    });
    final config = await container().read(llmConfigStorageProvider.future);

    expect(config, defaultLlmConfig);
    expect(data, {'schema_version': '2'});
  });

  test('save round-trips thinking and system prompt inside the union JSON', () async {
    const config = LlmClientConfig.anthropic(
      apiKey: 'sk-ant',
      thinking: false,
      systemPrompt: 'custom prompt',
    );
    final data = useStorage({});
    final scope = container();
    await scope.read(llmConfigStorageProvider.future);
    await scope.read(llmConfigStorageProvider.notifier).save(config);

    expect(jsonDecode(data['llm']!), {
      'provider': 'anthropic',
      'api_key': 'sk-ant',
      'base_url': 'https://api.anthropic.com',
      'model': 'claude-sonnet-5',
      'thinking': false,
      'system_prompt': 'custom prompt',
    });
    expect(await scope.read(llmConfigStorageProvider.future), config);

    final reloaded = container();
    expect(await reloaded.read(llmConfigStorageProvider.future), config);
  });
}
