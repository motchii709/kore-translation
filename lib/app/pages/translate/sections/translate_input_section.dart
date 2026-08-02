import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kore_translation/app/constants/translation_presets.dart';
import 'package:kore_translation/app/i18n/translations.g.dart';
import 'package:kore_translation/app/models/ui_settings.dart';
import 'package:kore_translation/app/ui/components/app_section_header.dart';

/// Input form: source text, target chips, style, tone chips and the
/// translate button.
class TranslateInputSection extends StatelessWidget {
  const TranslateInputSection({
    required this.controller,
    required this.language,
    required this.onLanguageChanged,
    required this.style,
    required this.onStyleChanged,
    required this.tones,
    required this.onTonesChanged,
    required this.submitShortcut,
    required this.isLoading,
    required this.onSubmit,
    super.key,
  });

  final TextEditingController controller;

  /// The selected pairing language, not a fixed destination: the input text
  /// decides whether this or the app language comes out.
  final String language;
  final ValueChanged<String> onLanguageChanged;
  final TranslationStyle style;
  final ValueChanged<TranslationStyle> onStyleChanged;
  final Set<TonePreset> tones;
  final ValueChanged<Set<TonePreset>> onTonesChanged;
  final SubmitShortcut submitShortcut;
  final bool isLoading;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
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
            }: onSubmit,
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
                selected: preset == language,
                onSelected: (selected) {
                  if (selected) {
                    onLanguageChanged(preset);
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
          selected: {style},
          onSelectionChanged: (selection) => onStyleChanged(selection.single),
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
                selected: tones.contains(tone),
                onSelected: (selected) => onTonesChanged(
                  selected ? {...tones, tone} : ({...tones}..remove(tone)),
                ),
              ),
          ],
        ),
        const SizedBox(height: 24),
        FilledButton.icon(
          onPressed: isLoading ? null : onSubmit,
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
