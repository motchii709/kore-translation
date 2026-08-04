import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kore_config/kore_config.dart';
import 'package:kore_translation/app/constants/translation_presets.dart';
import 'package:kore_translation/app/constants/translation_prompt.dart';
import 'package:kore_translation/app/i18n/translations.g.dart';
import 'package:kore_translation/app/models/ui_settings.dart';
import 'package:kore_translation/app/providers/llm_config_provider.dart';
import 'package:kore_translation/app/providers/llm_session_provider.dart';
import 'package:kore_translation/app/providers/translation_jobs_provider.dart';
import 'package:kore_translation/app/providers/ui_settings_provider.dart';
import 'package:kore_translation/app/router/app_router.dart';
import 'package:kore_translation/app/ui/components/app_section_header.dart';
import 'package:kore_translation/app/ui/scroll/use_animated_scroll_controller.dart';

/// Input form: source text with the translate button right under it, then
/// the language, style and tone chips. Owns its state and submits itself,
/// so edits here never rebuild the rest of the page.
class TranslateInputSection extends HookConsumerWidget {
  const TranslateInputSection({this.navigateToResult = false, super.key});

  /// Whether submitting pushes the new entry's page — the narrow layout has
  /// no result pane to show it in.
  final bool navigateToResult;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
    // Rebuild on every edit so the empty-input disable below tracks the text.
    useListenable(controller);
    final language = useState(languagePresets.first);
    final style = useState(TranslationStyle.natural);
    final tones = useState(const <TonePreset>{});
    final thinking = useState(true);

    final session = ref.watch(llmSessionProvider);
    final llmConfig = ref.watch(llmConfigStorageProvider);

    // Submitting needs an open session, a stored profile and some text;
    // `session.value!` / `llmConfig.value!` in submit lean on this gate.
    // Running translations never disable the form: they run in parallel.
    final isDisable = session.value == null || llmConfig.value == null || controller.text.trim().isEmpty;

    // Build-time binding: the chords must exist before any keypress, so
    // loading/error fall back to the defaults here (the load error itself
    // surfaces on the advanced settings page). Action-path values are
    // awaited fresh in submit instead.
    final (submitShortcut, submitAction) = ref.watch(
      uiSettingsStorageProvider.select(
        (settings) => switch (settings) {
          AsyncData(:final value) => (value.submitShortcut, value.submitAction),
          _ => (SubmitShortcut.enter, SubmitAction.translate),
        },
      ),
    );

    Future<void> submitWith(String systemPrompt) async {
      FocusScope.of(context).unfocus();
      final text = controller.text.trim();
      // The request owns the text now; clearing readies the field for the
      // next input.
      controller.clear();
      final id = await ref
          .read(translationJobsProvider.notifier)
          .translate(
            session: session.value!,
            systemPrompt: systemPrompt,
            text: text,
            thinking: thinking.value,
          );
      if (navigateToResult && context.mounted) {
        unawaited(HistoryEntryRoute(id: id).push<void>(context));
      }
    }

    Future<void> submit() => submitWith(
      buildTranslationSystemPrompt(
        // The settings form materializes the template into its field,
        // so the stored value is used verbatim. A load *error* cannot
        // reach this page: the route guard redirects to the model
        // settings, where it surfaces raw.
        template: llmConfig.value!.systemPrompt,
        language: language.value,
        appLanguage: appLanguageNameOf(TranslationProvider.of(context).locale),
        // Style first, then the tones in declaration order, so the
        // prompt is deterministic.
        toneInstruction: [
          styleInstructionOf(style.value),
          for (final tone in TonePreset.values)
            if (tones.value.contains(tone)) toneInstructionOf(tone),
        ].join('\n'),
      ),
    );

    // Proofreading keeps the text in its own language, so the language chip
    // and the translation style don't apply — only the tones do.
    Future<void> proofread() => submitWith(
      buildProofreadingSystemPrompt(
        template: llmConfig.value!.proofreadPrompt,
        appLanguage: appLanguageNameOf(TranslationProvider.of(context).locale),
        toneInstruction: [
          for (final tone in TonePreset.values)
            if (tones.value.contains(tone)) toneInstructionOf(tone),
        ].join('\n'),
      ),
    );

    Future<void> run(SubmitAction action) => switch (action) {
      SubmitAction.translate => submit(),
      SubmitAction.proofread => proofread(),
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppSectionHeader(title: context.t.translate.sourceText),
        // The submit chords only exist on hardware keyboards; plain Enter
        // (or the unbound chord) inserts a newline, and soft keyboards
        // submit through the buttons. While the IME is composing, Enter
        // belongs to it (confirming the conversion), so the bindings drop
        // out entirely — a matched shortcut swallows the keypress before
        // the IME sees it, even if its callback does nothing. The
        // controller listener above rebuilds this on every composing
        // change.
        CallbackShortcuts(
          bindings: controller.value.composing.isValid
              ? const {}
              : {
                  switch (submitShortcut) {
                    SubmitShortcut.enter => const SingleActivator(LogicalKeyboardKey.enter),
                    SubmitShortcut.shiftEnter => const SingleActivator(LogicalKeyboardKey.enter, shift: true),
                  }: () {
                    // Mirror the button gate. Submitting mid-stream just
                    // starts another parallel translation.
                    if (!isDisable) {
                      unawaited(run(submitAction));
                    }
                  },
                  // Ctrl+Enter runs the other action, so both actions stay
                  // one keypress away whichever way the setting points.
                  const SingleActivator(LogicalKeyboardKey.enter, control: true): () {
                    if (!isDisable) {
                      unawaited(
                        run(switch (submitAction) {
                          SubmitAction.translate => SubmitAction.proofread,
                          SubmitAction.proofread => SubmitAction.translate,
                        }),
                      );
                    }
                  },
                },
          child: TextField(
            controller: controller,
            scrollController: useAnimatedScrollController(),
            minLines: 3,
            maxLines: 8,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              hintText: context.t.translate.inputHint,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: FilledButton.icon(
                // Translations run in parallel, so streaming neither disables
                // the button nor puts it into a loading look.
                onPressed: isDisable ? null : proofread,
                icon: const Icon(Icons.spellcheck),
                label: Text(context.t.translate.proofreadAction),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: FilledButton.icon(
                onPressed: isDisable ? null : submit,
                icon: const Icon(Icons.translate),
                label: Text(context.t.translate.action),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        AppSectionHeader(title: context.t.translate.language),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final preset in languagePresets)
              ChoiceChip(
                label: Text(preset),
                selected: preset == language.value,
                onSelected: (selected) {
                  if (selected) {
                    language.value = preset;
                  }
                },
              ),
          ],
        ),
        const SizedBox(height: 16),
        AppSectionHeader(title: context.t.translate.style.title),
        SegmentedButton<TranslationStyle>(
          showSelectedIcon: false,
          segments: [
            ButtonSegment(
              value: TranslationStyle.natural,
              label: Text(context.t.translate.style.natural),
            ),
            ButtonSegment(
              value: TranslationStyle.literal,
              label: Text(context.t.translate.style.literal),
            ),
          ],
          selected: {style.value},
          onSelectionChanged: (selection) => style.value = selection.single,
        ),
        const SizedBox(height: 16),
        AppSectionHeader(title: context.t.translate.tones),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final tone in TonePreset.values)
              FilterChip(
                label: Text(_toneLabelOf(context, tone)),
                selected: tones.value.contains(tone),
                onSelected: (selected) =>
                    tones.value = selected ? {...tones.value, tone} : ({...tones.value}..remove(tone)),
              ),
          ],
        ),
        if (llmConfig.value?.canThink ?? false) ...[
          const SizedBox(height: 16),
          AppSectionHeader(title: context.t.translate.thinking),
          SegmentedButton<bool>(
            showSelectedIcon: false,
            segments: [
              ButtonSegment(value: false, label: Text(context.t.translate.thinkingOff)),
              ButtonSegment(value: true, label: Text(context.t.translate.thinkingOn)),
            ],
            selected: {thinking.value},
            onSelectionChanged: (selection) => thinking.value = selection.single,
          ),
        ],
      ],
    );
  }
}

/// Chip labels for the tone presets. Display text is this widget's concern;
/// the enum stays a pure identifier and the prompt sentence lives with the
/// prompt builder.
String _toneLabelOf(BuildContext context, TonePreset tone) => switch (tone) {
  TonePreset.polite => context.t.tone.polite,
  TonePreset.casual => context.t.tone.casual,
  TonePreset.friendChat => context.t.tone.friendChat,
  TonePreset.genZ => context.t.tone.genZ,
  TonePreset.internetThread => context.t.tone.internetThread,
  TonePreset.businessEmail => context.t.tone.businessEmail,
  TonePreset.customerSupport => context.t.tone.customerSupport,
  TonePreset.formFilling => context.t.tone.formFilling,
  TonePreset.socialPost => context.t.tone.socialPost,
  TonePreset.uiLabel => context.t.tone.uiLabel,
  TonePreset.academicPaper => context.t.tone.academicPaper,
};
