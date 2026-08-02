import 'dart:convert';

import 'package:flutter_secure_storage/test/test_flutter_secure_storage_platform.dart';
import 'package:flutter_secure_storage_platform_interface/flutter_secure_storage_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kore_honyaku/app/constants/translation_prompt.dart';
import 'package:kore_honyaku/app/models/app_settings.dart';
import 'package:kore_honyaku/app/providers/app_settings_provider.dart';
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

  test('empty storage yields the defaults', () async {
    useStorage({});
    final settings = await container().read(appSettingsStorageProvider.future);

    expect(settings, const AppSettings());
    expect(settings.systemPrompt, defaultTranslationPromptTemplate);
  });

  test('data from another schema version is discarded wholesale', () async {
    final data = useStorage({
      // A pre-union layout: flat keys and no schema version.
      'provider': 'openai',
      'api_key': 'sk-old',
      'system_prompt': '',
    });
    final settings = await container().read(appSettingsStorageProvider.future);

    expect(settings, const AppSettings());
    expect(data, {'schema_version': '1'});
  });

  test('save round-trips the llm union through storage', () async {
    const settings = AppSettings(
      llm: LlmClientConfig.acp(command: 'npx some-agent'),
      thinking: false,
      systemPrompt: 'custom prompt',
    );
    final data = useStorage({});
    final scope = container();
    await scope.read(appSettingsStorageProvider.future);
    await scope.read(appSettingsStorageProvider.notifier).save(settings);

    expect(jsonDecode(data['llm']!), {'provider': 'acp', 'command': 'npx some-agent'});
    expect(await scope.read(appSettingsStorageProvider.future), settings);

    final reloaded = container();
    expect(await reloaded.read(appSettingsStorageProvider.future), settings);
  });
}
