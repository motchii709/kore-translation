import 'dart:convert';

import 'package:kore_translation/app/constants/translation_prompt.dart';

import 'package:kore_translation/app/providers/secure_storage_provider.dart';
import 'package:llm_clients/llm_clients.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'llm_config_provider.g.dart';

const _llmStorageKey = 'llm';

/// Identifies the storage layout. Backward compatibility is a non-goal:
/// data written under any other version is discarded wholesale instead of
/// migrated. Bump on every incompatible change.
const _schemaVersion = '2';
const _schemaVersionKey = 'schema_version';

/// The profile of a fresh install: OpenAI with the standard translation
/// template materialized, so the settings form shows the values that will
/// actually be used.
const defaultLlmConfig = LlmClientConfig.openAi(
  apiKey: '',
  systemPrompt: defaultTranslationPromptTemplate,
);

/// The stored LLM profile ([LlmClientConfig] is the whole persistence
/// schema; there is nothing to configure outside of it).
@riverpod
class LlmConfigStorage extends _$LlmConfigStorage {
  @override
  Future<LlmClientConfig> build() async {
    final storage = ref.watch(secureStorageProvider);
    if (await storage.read(key: _schemaVersionKey) != _schemaVersion) {
      await storage.deleteAll();
      await storage.write(key: _schemaVersionKey, value: _schemaVersion);
    }
    return switch (await storage.read(key: _llmStorageKey)) {
      null => defaultLlmConfig,
      final json => LlmClientConfig.fromJson(jsonDecode(json) as Map<String, dynamic>),
    };
  }

  Future<void> save(LlmClientConfig config) async {
    state = await AsyncValue.guard(() async {
      await ref.read(secureStorageProvider).write(key: _llmStorageKey, value: jsonEncode(config.toJson()));
      return config;
    });
  }

  /// Deletes the stored profile wholesale; the route guard then treats the
  /// app as unconfigured again.
  Future<void> reset() async {
    state = await AsyncValue.guard(() async {
      final storage = ref.read(secureStorageProvider);
      await storage.deleteAll();
      await storage.write(key: _schemaVersionKey, value: _schemaVersion);
      return defaultLlmConfig;
    });
  }
}
