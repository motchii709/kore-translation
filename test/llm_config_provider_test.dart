import 'dart:convert';

import 'package:flutter_secure_storage/test/test_flutter_secure_storage_platform.dart';
import 'package:flutter_secure_storage_platform_interface/flutter_secure_storage_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kore_config/kore_config.dart';
import 'package:kore_translation/app/providers/llm_config_provider.dart';
import 'package:kore_translation/main.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Map<String, String> useStorage(Map<String, String> data) {
    FlutterSecureStoragePlatform.instance = TestFlutterSecureStoragePlatform(data);
    return data;
  }

  ProviderContainer container() {
    // Mirrors the app's ProviderScope: retries disabled so errors surface.
    final container = ProviderContainer(retry: noRetry);
    addTearDown(container.dispose);
    return container;
  }

  test('empty storage yields null — the unconfigured state', () async {
    useStorage({});
    final config = await container().read(llmConfigStorageProvider.future);

    expect(config, isNull);
  });

  test('stored data that no longer parses surfaces the error raw', () async {
    // Beta policy: no versioning, no migrations, no automatic wipes — the
    // user deletes the profile from the advanced settings instead.
    useStorage({'llm': '{"provider":"no-such-provider"}'});
    final scope = container();
    // Keep the auto-dispose provider alive while its future settles.
    final subscription = scope.listen(llmConfigStorageProvider, (_, _) {});
    addTearDown(subscription.close);

    await expectLater(
      scope.read(llmConfigStorageProvider.future),
      throwsA(isA<CheckedFromJsonException>()),
    );
  });

  test('reset deletes the stored profile wholesale', () async {
    final data = useStorage({'llm': '{"provider":"anthropic","api_key":"sk-ant"}'});
    final scope = container();
    final subscription = scope.listen(llmConfigStorageProvider, (_, _) {});
    addTearDown(subscription.close);
    await scope.read(llmConfigStorageProvider.future);

    await scope.read(llmConfigStorageProvider.notifier).reset();

    expect(data, isEmpty);
    expect(scope.read(llmConfigStorageProvider).value, isNull);
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
