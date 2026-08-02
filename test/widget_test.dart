import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kore_honyaku/app/models/app_settings.dart';
import 'package:kore_honyaku/app/providers/app_settings_provider.dart';
import 'package:kore_honyaku/main.dart';

class _ConfiguredStorage extends AppSettingsStorage {
  @override
  Future<AppSettings> build() async => const AppSettings(apiKey: 'test-key');
}

class _UnconfiguredStorage extends AppSettingsStorage {
  @override
  Future<AppSettings> build() async => const AppSettings();
}

void main() {
  testWidgets('APIキー設定済みなら翻訳ページを表示する', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appSettingsStorageProvider.overrideWith(_ConfiguredStorage.new),
        ],
        child: const KoreApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Kore!?'), findsOneWidget);
    expect(find.text('翻訳する'), findsOneWidget);
  });

  testWidgets('APIキー未設定なら設定ページへリダイレクトする', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appSettingsStorageProvider.overrideWith(_UnconfiguredStorage.new),
        ],
        child: const KoreApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('設定'), findsOneWidget);
    expect(find.text('保存'), findsOneWidget);
  });
}
