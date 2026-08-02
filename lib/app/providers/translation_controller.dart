import 'dart:async';

import 'package:kore_client/kore_client.dart';
import 'package:kore_honyaku/app/providers/translation_client_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'translation_controller.g.dart';

/// Holds the latest translation progress. `null` means nothing has been
/// translated yet. While streaming, the model's thinking and progressively
/// richer results are reflected into [state]; the last event carries the
/// validated final result.
@riverpod
class TranslationController extends _$TranslationController {
  StreamSubscription<TranslationEvent>? _subscription;

  @override
  Future<TranslationEvent?> build() async {
    ref.onDispose(() => unawaited(_subscription?.cancel()));
    return null;
  }

  /// Cancels the previous request (if any) and starts a new streaming
  /// translation.
  Future<void> translate({
    required String systemPrompt,
    required String text,
    required bool thinking,
  }) async {
    await _subscription?.cancel();
    state = const AsyncLoading();
    final TranslationClient client;
    try {
      client = await ref.read(translationClientProvider.future);
    } on Exception catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      return;
    }
    _subscription = client
        .streamTranslation(systemPrompt: systemPrompt, text: text, thinking: thinking)
        .listen(
          (event) => state = AsyncData(event),
          onError: (Object error, StackTrace stackTrace) => state = AsyncError(error, stackTrace),
          cancelOnError: true,
        );
  }
}
