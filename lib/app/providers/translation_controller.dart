import 'package:kore_client/kore_client.dart';
import 'package:kore_honyaku/app/providers/translator_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'translation_controller.g.dart';

/// Holds the latest translation result. `null` means nothing has been
/// translated yet.
@riverpod
class TranslationController extends _$TranslationController {
  @override
  Future<TranslationResult?> build() async {
    return null;
  }

  Future<void> translate(TranslationRequest request) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final translator = await ref.read(translatorProvider.future);
      return translator.translate(request);
    });
  }
}
