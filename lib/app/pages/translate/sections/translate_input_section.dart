import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kore_translation/app/constants/translation_presets.dart';
import 'package:kore_translation/app/constants/translation_prompt.dart';
import 'package:kore_translation/app/i18n/translations.g.dart';
import 'package:kore_translation/app/models/ui_settings.dart';
import 'package:kore_translation/app/providers/llm_config_provider.dart';
import 'package:kore_translation/app/providers/translation_controller.dart';
import 'package:kore_translation/app/providers/ui_settings_provider.dart';
import 'package:kore_translation/app/ui/components/app_section_header.dart';

/// Input form: source text, language chips, style, tone chips and the
/// translate button. Owns its state and submits itself, so edits here never
/// rebuild the rest of the page.
class TranslateInputSection extends HookConsumerWidget {
  const TranslateInputSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
    final language = useState(languagePresets.first);
    final style = useState(TranslationStyle.natural);
    final tones = useState(const <TonePreset>{});
    // select keeps streaming deltas from rebuilding the form.
    final isLoading = ref.watch(translationControllerProvider.select((result) => result.isLoading));
    // Build-time binding: the chord must exist before any keypress, so
    // loading/error fall back to the default here (the load error itself
    // surfaces on the advanced settings page). Action-path values are
    // awaited fresh in submit instead.
    final submitShortcut = ref.watch(
      uiSettingsStorageProvider.select(
        (settings) => switch (settings) {
          AsyncData(:final value) => value.submitShortcut,
          _ => SubmitShortcut.enter,
        },
      ),
    );

    Future<void> submit() async {
      final text = controller.text.trim();
      if (text.isEmpty) {
        return;
      }

      final llmConfig = await ref.read(llmConfigStorageProvider.future);
      if (!context.mounted) {
        return;
      }

      FocusScope.of(context).unfocus();
      await ref
          .read(translationControllerProvider.notifier)
          .translate(
            systemPrompt: buildTranslationSystemPrompt(
              // The settings form materializes the template into its field,
              // so the stored value is used verbatim. A load *error* cannot
              // reach this page: the route guard redirects to the model
              // settings, where it surfaces raw.
              template: llmConfig.systemPrompt,
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
            text: text,
          );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // The submit chord only exists on hardware keyboards; plain Enter
        // (or the unbound chord) inserts a newline, and soft keyboards
        // submit through the button.
        CallbackShortcuts(
          bindings: {
            switch (submitShortcut) {
              SubmitShortcut.enter => const SingleActivator(LogicalKeyboardKey.enter),
              SubmitShortcut.shiftEnter => const SingleActivator(LogicalKeyboardKey.enter, shift: true),
            }: submit,
          },
          child: TextField(
            controller: controller,
            minLines: 3,
            maxLines: 8,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              hintText: context.t.translate.inputHint,
            ),
          ),
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
        const SizedBox(height: 24),
        FilledButton.icon(
          onPressed: isLoading ? null : submit,
          icon: isLoading
              ? const SizedBox.square(
                  dimension: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.translate),
          label: Text(isLoading ? context.t.translate.inProgress : context.t.translate.action),
        ),
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
