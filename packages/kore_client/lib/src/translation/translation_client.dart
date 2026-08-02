import 'package:kore_client/src/translation/translation_models.dart';

/// A translation backend. UIs (Flutter app, CLI, TUI, ...) depend only on
/// this interface.
///
/// Concrete implementations pair one provider's thin LLM wrapper with the
/// shared translation pipeline, and are constructed at the composition root
/// (app providers, CLI main) by switching over the config variants.
abstract interface class TranslationClient {
  /// Streams progress snapshots; the last event carries the complete,
  /// strictly parsed result.
  Stream<TranslationEvent> streamTranslation(TranslationRequest request);
}
