import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/test/test_flutter_secure_storage_platform.dart';
import 'package:flutter_secure_storage_platform_interface/flutter_secure_storage_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kore_honyaku/app/constants/translation_prompt.dart';
import 'package:kore_honyaku/app/models/app_settings.dart';
import 'package:kore_honyaku/app/pages/settings/widgets/settings_form.dart';
import 'package:kore_honyaku/app/providers/app_settings_provider.dart';
import 'package:llm_clients/llm_clients.dart';

Widget _app(AppSettings settings) => ProviderScope(
  child: MaterialApp(home: Scaffold(body: SettingsForm(initialSettings: settings))),
);

void main() {
  setUp(() {
    final binding = TestWidgetsFlutterBinding.ensureInitialized();
    binding.platformDispatcher.views.first
      ..physicalSize = const Size(1200, 3000)
      ..devicePixelRatio = 1;
    addTearDown(binding.platformDispatcher.views.first.reset);
  });

  testWidgets('materializes the provider defaults into the fields', (tester) async {
    await tester.pumpWidget(_app(const AppSettings()));

    expect(find.widgetWithText(TextField, 'https://api.openai.com/v1'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'gpt-5-mini'), findsOneWidget);
    expect(find.textContaining('You are a professional translator'), findsOneWidget);
  });

  testWidgets('shows stored values verbatim once saved', (tester) async {
    await tester.pumpWidget(
      _app(
        const AppSettings(
          llm: LlmClientConfig.openAi(apiKey: '', baseUrl: 'https://proxy.example/v1', model: 'my-model'),
          systemPrompt: 'custom prompt',
        ),
      ),
    );

    expect(find.widgetWithText(TextField, 'https://proxy.example/v1'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'my-model'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'custom prompt'), findsOneWidget);
  });

  testWidgets('switching the provider replaces the endpoint fields with its defaults', (tester) async {
    await tester.pumpWidget(_app(const AppSettings()));

    await tester.tap(find.byType(DropdownMenu<LlmProvider>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Anthropic').last);
    await tester.pumpAndSettle();

    expect(find.widgetWithText(TextField, 'https://api.anthropic.com'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'claude-sonnet-5'), findsOneWidget);
  });

  testWidgets('saves the fields verbatim, cleared system prompt included', (tester) async {
    final data = <String, String>{};
    FlutterSecureStoragePlatform.instance = TestFlutterSecureStoragePlatform(data);
    await tester.pumpWidget(_app(const AppSettings()));
    // In the app the settings page watches the storage provider; without a
    // listener the auto-dispose provider would die mid-save here.
    final container = ProviderScope.containerOf(tester.element(find.byType(SettingsForm)));
    final subscription = container.listen(appSettingsStorageProvider, (_, _) {});
    addTearDown(subscription.close);

    await tester.enterText(
      find.widgetWithText(TextField, defaultTranslationPromptTemplate),
      '',
    );
    await tester.ensureVisible(find.text('保存'));
    await tester.tap(find.text('保存'));
    await tester.pumpAndSettle();

    expect(data['system_prompt'], '');
  });

  testWidgets('phones do not offer the agent backends', (tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    await tester.pumpWidget(_app(const AppSettings()));

    final menu = tester.widget<DropdownMenu<LlmProvider>>(find.byType(DropdownMenu<LlmProvider>));
    final offered = menu.dropdownMenuEntries.map((entry) => entry.value);
    // Must be reset before the test ends, or the framework's invariant
    // check fails the test.
    debugDefaultTargetPlatformOverride = null;
    expect(offered, isNot(contains(LlmProvider.acp)));
    expect(offered, isNot(contains(LlmProvider.codex)));
    expect(offered, contains(LlmProvider.openAi));
  });
}
