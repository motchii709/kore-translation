import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kore_honyaku/app/models/app_settings.dart';
import 'package:kore_honyaku/app/providers/app_settings_provider.dart';
import 'package:kore_honyaku/app/providers/translation_client_provider.dart';
import 'package:llm_clients/llm_clients.dart';

/// Serves fixed settings pointing the Codex backend at the fake app-server
/// fixture, without touching secure storage.
final class _FakeAppSettingsStorage extends AppSettingsStorage {
  @override
  Future<AppSettings> build() async => const AppSettings(
    provider: LlmProvider.codex,
    codexCommand: 'dart test/fixtures/fake_codex_app_server.dart',
  );
}

void main() {
  ProviderContainer container() {
    final container = ProviderContainer(
      overrides: [appSettingsStorageProvider.overrideWith(_FakeAppSettingsStorage.new)],
    );
    addTearDown(container.dispose);
    return container;
  }

  test('the agent client outlives its first read and streams a translation', () async {
    final scope = container();
    final client = await scope.read(translationClientProvider.future);

    // Auto-dispose would kill the agent subprocess right here, before the
    // translation below ever streams.
    final events = await client.streamTranslation(systemPrompt: 'Translate.', text: 'こんにちは').toList();

    expect(events.last.result?.translation, 'Hello');
    expect(await scope.read(translationClientProvider.future), same(client));
  });

  test('a rebuild while the agent starts neither crashes nor leaks the build', () async {
    final scope = container();
    final stale = scope.read(translationClientProvider.future);
    scope.invalidate(translationClientProvider);

    final client = await scope.read(translationClientProvider.future);
    final events = await client.streamTranslation(systemPrompt: 'Translate.', text: 'こんにちは').toList();

    expect(events.last.result?.translation, 'Hello');
    // The stale future resolves to the rebuilt provider's value; before the
    // fix this path crashed with "Cannot use the Ref ... after disposed".
    expect(await stale, same(client));
  });
}
