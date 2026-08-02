import 'package:kore_client/kore_client.dart';
import 'package:kore_honyaku/app/models/app_settings.dart';
import 'package:kore_honyaku/app/providers/secure_storage_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_settings_provider.g.dart';

const _providerStorageKey = 'provider';
const _baseUrlStorageKey = 'base_url';
const _apiKeyStorageKey = 'api_key';
const _modelStorageKey = 'model';

@riverpod
class AppSettingsStorage extends _$AppSettingsStorage {
  @override
  Future<AppSettings> build() async {
    final storage = ref.watch(secureStorageProvider);
    const defaults = AppSettings();
    return AppSettings(
      provider: LlmProvider.fromId(
            await storage.read(key: _providerStorageKey),
          ) ??
          defaults.provider,
      baseUrl: await storage.read(key: _baseUrlStorageKey) ?? defaults.baseUrl,
      apiKey: await storage.read(key: _apiKeyStorageKey) ?? defaults.apiKey,
      model: await storage.read(key: _modelStorageKey) ?? defaults.model,
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
      return settings;
    });
  }
}
