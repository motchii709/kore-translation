import 'package:kore_client/kore_client.dart';
import 'package:kore_honyaku/app/providers/app_settings_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'translator_provider.g.dart';

@riverpod
Future<Translator> translator(Ref ref) async {
  final settings = await ref.watch(appSettingsStorageProvider.future);
  return Translator.fromConfig(settings.toTranslatorConfig());
}
