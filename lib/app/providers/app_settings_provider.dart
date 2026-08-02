import 'dart:convert';

import 'package:kore_honyaku/app/models/app_settings.dart';
import 'package:kore_honyaku/app/providers/secure_storage_provider.dart';
import 'package:llm_clients/llm_clients.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_settings_provider.g.dart';

const _llmStorageKey = 'llm';
const _thinkingStorageKey = 'thinking';
const _systemPromptStorageKey = 'system_prompt';

/// Identifies the storage layout. Backward compatibility is a non-goal:
/// data written under any other version is discarded wholesale instead of
/// migrated. Bump on every incompatible change.
const _schemaVersion = '1';
const _schemaVersionKey = 'schema_version';

@riverpod
class AppSettingsStorage extends _$AppSettingsStorage {
  @override
  Future<AppSettings> build() async {
    final storage = ref.watch(secureStorageProvider);
    if (await storage.read(key: _schemaVersionKey) != _schemaVersion) {
      await storage.deleteAll();
      await storage.write(key: _schemaVersionKey, value: _schemaVersion);
    }
    const defaults = AppSettings();
    return AppSettings(
      llm: switch (await storage.read(key: _llmStorageKey)) {
        null => defaults.llm,
        final json => LlmClientConfig.fromJson(jsonDecode(json) as Map<String, dynamic>),
      },
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
        key: _llmStorageKey,
        value: jsonEncode(settings.llm.toJson()),
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
