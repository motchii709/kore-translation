import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kore_client/kore_client.dart';
import 'package:kore_translation/app/providers/translation_client_provider.dart';
import 'package:kore_translation/app/providers/translation_controller.dart';
import 'package:kore_translation/main.dart';

/// Streams that stay open until cancelled: completion never happens, so the
/// history append (which needs sqlite, unavailable here) is never reached.
class _OpenStreamClient implements TranslationClient {
  final controllers = <StreamController<TranslationEvent>>[];

  @override
  Stream<TranslationEvent> streamTranslation({required String systemPrompt, required String text}) {
    final controller = StreamController<TranslationEvent>();
    controllers.add(controller);
    return controller.stream;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('a new translation cancels the in-flight stream', () async {
    final client = _OpenStreamClient();
    // Mirrors the app's ProviderScope: retries disabled so errors surface.
    final scope = ProviderContainer(
      retry: noRetry,
      overrides: [translationClientProvider.overrideWith((ref) => client)],
    );
    addTearDown(scope.dispose);
    final subscription = scope.listen(translationControllerProvider, (_, _) {});
    addTearDown(subscription.close);
    final notifier = scope.read(translationControllerProvider.notifier);

    await notifier.translate(systemPrompt: 'p', text: 'a');
    expect(client.controllers, hasLength(1));
    expect(client.controllers.first.hasListener, isTrue);

    await notifier.translate(systemPrompt: 'p', text: 'b');
    expect(client.controllers, hasLength(2));
    expect(client.controllers.first.hasListener, isFalse);
  });

  test('a client build failure surfaces as state instead of escaping the action', () async {
    final scope = ProviderContainer(
      retry: noRetry,
      overrides: [
        translationClientProvider.overrideWith((ref) => throw Exception('agent failed to start')),
      ],
    );
    addTearDown(scope.dispose);
    final subscription = scope.listen(translationControllerProvider, (_, _) {});
    addTearDown(subscription.close);

    await scope.read(translationControllerProvider.notifier).translate(systemPrompt: 'p', text: 'a');

    expect(scope.read(translationControllerProvider), isA<AsyncError<TranslationEvent?>>());
  });
}
