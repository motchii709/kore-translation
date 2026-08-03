import 'dart:convert';

import 'package:kore_config/kore_config.dart';
import 'package:kore_translation/app/constants/translation_prompt.dart';
import 'package:kore_translation/app/providers/secure_storage_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'llm_config_provider.g.dart';

const _llmStorageKey = 'llm';

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
    return switch (await storage.read(key: _llmStorageKey)) {
      null => defaultLlmConfig,
      // Beta policy: no versioning, no migrations, no automatic wipes.
      // Stored data that no longer parses surfaces raw (checked fromJson)
      // and the user deletes the profile from the advanced settings.
      final json => LlmClientConfig.fromJson(jsonDecode(json) as Map<String, dynamic>),
    };
  }

  // save and reset are deliberately unguarded: a storage failure rejects
  // the caller's future (skipping its success snackbar) and surfaces as an
  // uncaught error instead of being folded into provider state where the
  // current page might not show it.
  Future<void> save(LlmClientConfig config) async {
    await ref.read(secureStorageProvider).write(key: _llmStorageKey, value: jsonEncode(config.toJson()));
    state = AsyncData(config);
  }

  /// Deletes the stored profile wholesale; the route guard then treats the
  /// app as unconfigured again.
  Future<void> reset() async {
    await ref.read(secureStorageProvider).deleteAll();
    state = const AsyncData(defaultLlmConfig);
  }
}
