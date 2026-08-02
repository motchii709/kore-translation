import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kore_client/kore_client.dart';
import 'package:kore_honyaku/app/constants/translation_presets.dart';
import 'package:kore_honyaku/app/pages/translate/sections/translate_input_section.dart';
import 'package:kore_honyaku/app/pages/translate/sections/translation_result_section.dart';
import 'package:kore_honyaku/app/providers/app_settings_provider.dart';
import 'package:kore_honyaku/app/providers/translation_controller.dart';
import 'package:kore_honyaku/app/router/app_router.dart';
import 'package:kore_honyaku/app/ui/layout/app_breakpoints.dart';

class TranslatePage extends HookConsumerWidget {
  const TranslatePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inputController = useTextEditingController();
    final targetLanguage = useState(TranslationPresets.targetLanguages.first);
    final tone = useState(ToneStyle.auto);
    final result = ref.watch(translationControllerProvider);
    final settings = ref.watch(appSettingsStorageProvider).value;

    void submit() {
      final text = inputController.text.trim();
      if (text.isEmpty) {
        return;
      }
      FocusScope.of(context).unfocus();
      unawaited(
        ref
            .read(translationControllerProvider.notifier)
            .translate(
              TranslationRequest(
                text: text,
                targetLanguage: targetLanguage.value,
                tone: tone.value,
                thinking: settings?.thinking ?? true,
              ),
            ),
      );
    }

    final inputSection = TranslateInputSection(
      controller: inputController,
      targetLanguage: targetLanguage.value,
      onTargetLanguageChanged: (value) => targetLanguage.value = value,
      tone: tone.value,
      onToneChanged: (value) => tone.value = value,
      isLoading: result.isLoading,
      onSubmit: submit,
    );
    final resultSection = TranslationResultSection(update: result);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kore!?'),
        actions: [
          IconButton(
            onPressed: () => const SettingsRoute().go(context),
            tooltip: '設定',
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth >= AppBreakpoints.twoPane) {
              return _TwoPaneLayout(
                input: inputSection,
                result: resultSection,
              );
            }
            return _SingleColumnLayout(
              input: inputSection,
              result: resultSection,
            );
          },
        ),
      ),
    );
  }
}

/// Desktop and tablet: input on the left, result on the right.
class _TwoPaneLayout extends StatelessWidget {
  const _TwoPaneLayout({required this.input, required this.result});

  final Widget input;
  final Widget result;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: AppBreakpoints.maxContentWidth),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: input,
              ),
            ),
            const VerticalDivider(width: 1),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: result,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Phone and small windows: one scrollable column.
class _SingleColumnLayout extends StatelessWidget {
  const _SingleColumnLayout({required this.input, required this.result});

  final Widget input;
  final Widget result;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: AppBreakpoints.maxSingleColumnWidth),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            input,
            const SizedBox(height: 24),
            result,
          ],
        ),
      ),
    );
  }
}
