import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kore_translation/app/constants/translation_presets.dart';
import 'package:kore_translation/app/constants/translation_prompt.dart';
import 'package:kore_translation/app/i18n/translations.g.dart';
import 'package:kore_translation/app/models/ui_settings.dart';
import 'package:kore_translation/app/pages/translate/sections/history_result_section.dart';
import 'package:kore_translation/app/pages/translate/sections/translate_input_section.dart';
import 'package:kore_translation/app/pages/translate/sections/translation_result_section.dart';
import 'package:kore_translation/app/pages/translate/widgets/history_list.dart';
import 'package:kore_translation/app/providers/history_provider.dart';
import 'package:kore_translation/app/providers/llm_config_provider.dart';
import 'package:kore_translation/app/providers/translation_controller.dart';
import 'package:kore_translation/app/providers/ui_settings_provider.dart';
import 'package:kore_translation/app/router/app_router.dart';
import 'package:kore_translation/app/ui/layout/app_breakpoints.dart';
import 'package:silky_scroll/silky_scroll.dart';

class TranslatePage extends HookConsumerWidget {
  const TranslatePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inputController = useTextEditingController();
    final language = useState(languagePresets.first);
    final style = useState(TranslationStyle.natural);
    final tones = useState(const <TonePreset>{});
    final result = ref.watch(translationControllerProvider);
    final llmConfig = ref.watch(llmConfigStorageProvider).value;
    final uiSettings = switch (ref.watch(uiSettingsStorageProvider)) {
      AsyncData(:final value) => value,
      // Loading or failed: keep rendering with the defaults — the load
      // error surfaces on the advanced settings page, which also offers
      // the recovery (deleting the database) and must stay reachable.
      _ => const UiSettings(),
    };
    final selectedEntry = ref.watch(selectedHistoryEntryProvider);

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
              systemPrompt: buildTranslationSystemPrompt(
                // The settings form materializes the template into its
                // field, so the stored value is used verbatim; the default
                // only covers the moment before the config has loaded.
                template: llmConfig?.systemPrompt ?? defaultTranslationPromptTemplate,
                targetLanguage: targetInstructionOf(
                  selected: language.value,
                  appLanguage: appLanguageNameOf(TranslationProvider.of(context).locale),
                ),
                appLanguage: appLanguageNameOf(TranslationProvider.of(context).locale),
                // Style first, then the tones in declaration order, so the
                // prompt is deterministic.
                toneInstruction: [
                  styleInstructionOf(style.value),
                  for (final tone in TonePreset.values)
                    if (tones.value.contains(tone)) toneInstructionOf(tone),
                ].join('\n'),
              ),
              text: text,
            ),
      );
    }

    final inputSection = TranslateInputSection(
      controller: inputController,
      language: language.value,
      onLanguageChanged: (value) => language.value = value,
      style: style.value,
      onStyleChanged: (value) => style.value = value,
      tones: tones.value,
      onTonesChanged: (value) => tones.value = value,
      submitShortcut: uiSettings.submitShortcut,
      isLoading: result.isLoading,
      onSubmit: submit,
    );
    // A selected history entry takes over the result pane; a new
    // translation clears the selection again.
    final resultSection = switch (selectedEntry) {
      null => TranslationResultSection(update: result),
      final entry => HistoryResultSection(entry: entry),
    };

    return Scaffold(
      // Narrow windows reach the history with an edge swipe (or the drawer
      // button the Scaffold adds); wide windows show the persistent sidebar.
      drawer: MediaQuery.sizeOf(context).width < AppBreakpoints.historySidebar ? const _HistoryDrawer() : null,
      appBar: AppBar(
        // The brand logo, intentionally identical in every locale (the
        // localized product name lives in the OS-level labels).
        title: const Text('Kore!?'),
        actions: [
          // Both settings pages, reachable in one gesture by name.
          PopupMenuButton<_SettingsDestination>(
            tooltip: context.t.translate.settingsTooltip,
            icon: const Icon(Icons.settings_outlined),
            onSelected: (destination) {
              switch (destination) {
                case _SettingsDestination.model:
                  const ModelSettingsRoute().go(context);
                case _SettingsDestination.advanced:
                  const AdvancedSettingsRoute().go(context);
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: _SettingsDestination.model, child: Text(context.t.settings.model)),
              PopupMenuItem(value: _SettingsDestination.advanced, child: Text(context.t.settings.advanced.title)),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth >= AppBreakpoints.historySidebar) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(width: AppBreakpoints.historySidebarWidth, child: HistoryList()),
                  const VerticalDivider(width: 1),
                  Expanded(
                    child: _TwoPaneLayout(input: inputSection, result: resultSection),
                  ),
                ],
              );
            }
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

enum _SettingsDestination { model, advanced }

/// Narrow-width history access. Selecting an entry closes the drawer and
/// leaves the entry showing in the result pane.
class _HistoryDrawer extends StatelessWidget {
  const _HistoryDrawer();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(context.t.history.title, style: Theme.of(context).textTheme.titleMedium),
            ),
            Expanded(child: HistoryList(onSelected: () => Navigator.of(context).pop())),
          ],
        ),
      ),
    );
  }
}

/// Desktop and tablet: input on the left, result on the right.
///
/// Each pane's scroll view spans the pane so its scrollbar sits at the
/// pane's right edge (the right pane's at the window edge); only the
/// content is width-constrained.
class _TwoPaneLayout extends StatelessWidget {
  const _TwoPaneLayout({required this.input, required this.result});

  final Widget input;
  final Widget result;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(child: _Pane(child: input)),
        const VerticalDivider(width: 1),
        Expanded(child: _Pane(child: result)),
      ],
    );
  }
}

class _Pane extends StatelessWidget {
  const _Pane({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SilkySingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppBreakpoints.maxContentWidth / 2),
          child: child,
        ),
      ),
    );
  }
}

/// Phone and small windows: one scrollable column. The scroll view spans
/// the full window so the scrollbar sits at the window edge; only the
/// content is width-constrained.
class _SingleColumnLayout extends StatelessWidget {
  const _SingleColumnLayout({required this.input, required this.result});

  final Widget input;
  final Widget result;

  @override
  Widget build(BuildContext context) {
    return SilkySingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppBreakpoints.maxSingleColumnWidth),
          child: Column(
            children: [
              input,
              const SizedBox(height: 24),
              result,
            ],
          ),
        ),
      ),
    );
  }
}
