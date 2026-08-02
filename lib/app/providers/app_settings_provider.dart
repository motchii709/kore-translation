import 'package:kore_honyaku/app/models/app_settings.dart';
import 'package:kore_honyaku/app/providers/secure_storage_provider.dart';
import 'package:llm_clients/llm_clients.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_settings_provider.g.dart';

const _providerStorageKey = 'provider';
const _baseUrlStorageKey = 'base_url';
const _apiKeyStorageKey = 'api_key';
const _modelStorageKey = 'model';
const _acpCommandStorageKey = 'acp_command';
const _codexCommandStorageKey = 'codex_command';
const _thinkingStorageKey = 'thinking';
const _systemPromptStorageKey = 'system_prompt';

@riverpod
class AppSettingsStorage extends _$AppSettingsStorage {
  @override
  Future<AppSettings> build() async {
    final storage = ref.watch(secureStorageProvider);
    const defaults = AppSettings();
    return AppSettings(
      provider:
          LlmProvider.fromId(
            await storage.read(key: _providerStorageKey),
          ) ??
          defaults.provider,
      baseUrl: await storage.read(key: _baseUrlStorageKey) ?? defaults.baseUrl,
      apiKey: await storage.read(key: _apiKeyStorageKey) ?? defaults.apiKey,
      model: await storage.read(key: _modelStorageKey) ?? defaults.model,
      acpCommand: await storage.read(key: _acpCommandStorageKey) ?? defaults.acpCommand,
      codexCommand: await storage.read(key: _codexCommandStorageKey) ?? defaults.codexCommand,
      thinking: switch (await storage.read(key: _thinkingStorageKey)) {
        'true' => true,
        'false' => false,
        _ => defaults.thinking,
      },
      systemPrompt: await storage.read(key: _systemPromptStorageKey) ?? defaults.systemPrompt,
    );
  }

  Future<void> save(AppSettings settings) async {
    state = await AsyncValue.guard(() async {
      final storage = ref.read(secureStorageProvider);
      await storage.write(
        key: _providerStorageKey,
        value: settings.provider.id,
      );
      await storage.write(key: _baseUrlStorageKey, value: settings.baseUrl);
      await storage.write(key: _apiKeyStorageKey, value: settings.apiKey);
      await storage.write(key: _modelStorageKey, value: settings.model);
      await storage.write(
        key: _acpCommandStorageKey,
        value: settings.acpCommand,
      );
      await storage.write(
        key: _codexCommandStorageKey,
        value: settings.codexCommand,
      );
      await storage.write(
        key: _thinkingStorageKey,
        value: '${settings.thinking}',
      );
      await storage.write(
        key: _systemPromptStorageKey,
        value: settings.systemPrompt,
      );
      return settings;
    });
  }
}
