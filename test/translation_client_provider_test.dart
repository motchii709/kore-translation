import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kore_translation/app/providers/llm_config_provider.dart';
import 'package:kore_translation/app/providers/translation_client_provider.dart';
import 'package:llm_clients/llm_clients.dart';

/// Serves a fixed profile pointing the Codex backend at the fake app-server
/// fixture, without touching secure storage.
final class _FakeLlmConfigStorage extends LlmConfigStorage {
  @override
  Future<LlmClientConfig> build() async =>
      const LlmClientConfig.codex(command: 'dart test/fixtures/fake_codex_app_server.dart');
}

void main() {
  ProviderContainer container() {
    final container = ProviderContainer(
      overrides: [llmConfigStorageProvider.overrideWith(_FakeLlmConfigStorage.new)],
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
