import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/test/test_flutter_secure_storage_platform.dart';
import 'package:flutter_secure_storage_platform_interface/flutter_secure_storage_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kore_translation/app/i18n/translations.g.dart';
import 'package:kore_translation/app/pages/settings/model_settings_page.dart';
import 'package:llm_clients/llm_clients.dart';

Widget _app() => TranslationProvider(
  child: const ProviderScope(
    child: MaterialApp(home: ModelSettingsPage()),
  ),
);

void main() {
  setUp(() {
    final binding = TestWidgetsFlutterBinding.ensureInitialized();
    binding.platformDispatcher.views.first
      ..physicalSize = const Size(1200, 3000)
      ..devicePixelRatio = 1;
    addTearDown(binding.platformDispatcher.views.first.reset);
  });

  Map<String, String> useStorage() {
    final data = {'schema_version': '2'};
    FlutterSecureStoragePlatform.instance = TestFlutterSecureStoragePlatform(data);
    return data;
  }

  testWidgets('saving through the page persists the selected provider config', (tester) async {
    final data = useStorage();
    await tester.pumpWidget(_app());
    await tester.pumpAndSettle();

    await tester.tap(find.byType(DropdownMenu<LlmProvider>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Anthropic').last);
    await tester.pumpAndSettle();

    await tester.enterText(find.widgetWithText(TextField, 'APIキー'), 'sk-ant-test');
    await tester.ensureVisible(find.text('保存'));
    await tester.tap(find.text('保存'));
    await tester.pumpAndSettle();

    // The stored JSON also carries the materialized defaults (model,
    // thinking, system prompt template); this test is only about the save
    // path delivering the selection and the typed key.
    final saved = jsonDecode(data['llm']!) as Map<String, dynamic>;
    expect(saved['provider'], 'anthropic');
    expect(saved['api_key'], 'sk-ant-test');
  });

  testWidgets('phones do not offer the agent backends', (tester) async {
    useStorage();
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    await tester.pumpWidget(_app());
    await tester.pumpAndSettle();

    final menu = tester.widget<DropdownMenu<LlmProvider>>(find.byType(DropdownMenu<LlmProvider>));
    // Must be reset before the test ends, or the framework's invariant
    // check fails the test.
    debugDefaultTargetPlatformOverride = null;
    final offered = menu.dropdownMenuEntries.map((entry) => entry.value);
    expect(offered, isNot(contains(LlmProvider.acp)));
    expect(offered, isNot(contains(LlmProvider.codex)));
    expect(offered, contains(LlmProvider.openAi));
  });
}
