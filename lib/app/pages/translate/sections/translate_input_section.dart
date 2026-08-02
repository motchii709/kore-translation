import 'package:flutter/material.dart';
import 'package:kore_honyaku/app/constants/translation_presets.dart';
import 'package:kore_honyaku/app/ui/components/app_section_header.dart';

/// Input form: source text, target language chips, tone chips and the
/// translate button.
class TranslateInputSection extends StatelessWidget {
  const TranslateInputSection({
    required this.controller,
    required this.targetLanguage,
    required this.onTargetLanguageChanged,
    required this.tones,
    required this.onTonesChanged,
    required this.isLoading,
    required this.onSubmit,
    super.key,
  });

  final TextEditingController controller;
  final String targetLanguage;
  final ValueChanged<String> onTargetLanguageChanged;
  final Set<TonePreset> tones;
  final ValueChanged<Set<TonePreset>> onTonesChanged;
  final bool isLoading;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: controller,
          minLines: 3,
          maxLines: 8,
          textInputAction: TextInputAction.done,
          onSubmitted: (_) => onSubmit(),
          decoration: const InputDecoration(
            hintText: '翻訳したいテキストを入力',
          ),
        ),
        const SizedBox(height: 16),
        const AppSectionHeader(title: '翻訳先'),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final language in TranslationPresets.targetLanguages)
              ChoiceChip(
                label: Text(language),
                selected: language == targetLanguage,
                onSelected: (selected) {
                  if (selected) {
                    onTargetLanguageChanged(language);
                  }
                },
              ),
          ],
        ),
        const SizedBox(height: 16),
        const AppSectionHeader(title: 'トーン (複数選択可)'),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final preset in TranslationPresets.tones)
              FilterChip(
                label: Text(preset.label),
                selected: tones.contains(preset),
                onSelected: (selected) => onTonesChanged(
                  selected ? {...tones, preset} : ({...tones}..remove(preset)),
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
          label: Text(isLoading ? '翻訳中...' : '翻訳する'),
        ),
      ],
    );
  }
}
