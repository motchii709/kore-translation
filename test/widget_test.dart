import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kore_translation/app/i18n/translations.g.dart';
import 'package:kore_translation/app/providers/llm_config_provider.dart';
import 'package:kore_translation/main.dart';
import 'package:llm_clients/llm_clients.dart';

class _ConfiguredStorage extends LlmConfigStorage {
  @override
  Future<LlmClientConfig> build() async => const LlmClientConfig.openAi(apiKey: 'test-key');
}

class _UnconfiguredStorage extends LlmConfigStorage {
  @override
  Future<LlmClientConfig> build() async => defaultLlmConfig;
}

Widget _app(LlmConfigStorage Function() storage) => TranslationProvider(
  child: ProviderScope(
    overrides: [llmConfigStorageProvider.overrideWith(storage)],
    child: const KoreApp(),
  ),
);

void main() {
  testWidgets('APIキー設定済みなら翻訳ページを表示する', (tester) async {
    await tester.pumpWidget(_app(_ConfiguredStorage.new));
    await tester.pumpAndSettle();

    expect(find.text('翻訳する'), findsOneWidget);
  });

  testWidgets('APIキー未設定なら設定ページへリダイレクトする', (tester) async {
    await tester.pumpWidget(_app(_UnconfiguredStorage.new));
    await tester.pumpAndSettle();

    // '設定' also exists as a tooltip on the translate page, so the page
    // marker is the provider picker, which only the settings page has.
    expect(find.text('LLMプロバイダ'), findsOneWidget);
  });
}
