import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kore_client/kore_client.dart';
import 'package:kore_config/kore_config.dart';
import 'package:kore_translation/app/providers/llm_config_provider.dart';
import 'package:kore_translation/app/providers/llm_session_provider.dart';

/// Serves a fixed profile pointing the Codex backend at the fake app-server
/// fixture, without touching secure storage.
final class _FakeLlmConfigStorage extends LlmConfigStorage {
  @override
  Future<LlmClientConfig?> build() async =>
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

  test('the agent session outlives its first read and streams a translation', () async {
    final scope = container();
    final session = await scope.read(llmSessionProvider.future);

    // Auto-dispose would kill the agent subprocess right here, before the
    // translation below ever streams.
    final events = await streamTranslation(session, systemPrompt: 'Translate.', text: 'こんにちは').toList();

    expect(events.last.result?.translation, 'Hello');
    expect(await scope.read(llmSessionProvider.future), same(session));
  });

  test('a rebuild while the agent starts neither crashes nor leaks the build', () async {
    final scope = container();
    final stale = scope.read(llmSessionProvider.future);
    scope.invalidate(llmSessionProvider);

    final session = await scope.read(llmSessionProvider.future);
    final events = await streamTranslation(session, systemPrompt: 'Translate.', text: 'こんにちは').toList();

    expect(events.last.result?.translation, 'Hello');
    // The stale future resolves to the rebuilt provider's value; before the
    // fix this path crashed with "Cannot use the Ref ... after disposed".
    expect(await stale, same(session));
  });
}
