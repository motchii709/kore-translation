import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kore_client/kore_client.dart';
import 'package:kore_translation/app/providers/llm_session_provider.dart';
import 'package:kore_translation/app/providers/translation_controller.dart';
import 'package:kore_translation/main.dart';
import 'package:llm_sdk_core/llm_sdk_core.dart';

/// Streams that stay open until cancelled: completion never happens, so the
/// history append (which needs sqlite, unavailable here) is never reached.
class _OpenStreamSession implements LlmSession {
  final controllers = <StreamController<LlmStreamEvent>>[];

  @override
  bool get isAlive => true;

  @override
  Future<void> close() async {}

  @override
  Stream<LlmStreamEvent> streamText({required String system, required String user, bool jsonOutput = false}) {
    final controller = StreamController<LlmStreamEvent>();
    controllers.add(controller);
    return controller.stream;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('a new translation cancels the in-flight stream', () async {
    final session = _OpenStreamSession();
    // Mirrors the app's ProviderScope: retries disabled so errors surface.
    final scope = ProviderContainer(
      retry: noRetry,
      overrides: [llmSessionProvider.overrideWith((ref) => session)],
    );
    addTearDown(scope.dispose);
    final subscription = scope.listen(translationControllerProvider, (_, _) {});
    addTearDown(subscription.close);
    final notifier = scope.read(translationControllerProvider.notifier);

    await notifier.translate(systemPrompt: 'p', text: 'a');
    expect(session.controllers, hasLength(1));
    expect(session.controllers.first.hasListener, isTrue);

    await notifier.translate(systemPrompt: 'p', text: 'b');
    expect(session.controllers, hasLength(2));
    expect(session.controllers.first.hasListener, isFalse);
  });

  test('a session open failure surfaces as state instead of escaping the action', () async {
    final scope = ProviderContainer(
      retry: noRetry,
      overrides: [
        llmSessionProvider.overrideWith((ref) => throw Exception('agent failed to start')),
      ],
    );
    addTearDown(scope.dispose);
    final subscription = scope.listen(translationControllerProvider, (_, _) {});
    addTearDown(subscription.close);

    await scope.read(translationControllerProvider.notifier).translate(systemPrompt: 'p', text: 'a');

    expect(scope.read(translationControllerProvider), isA<AsyncError<TranslationEvent?>>());
  });
}
