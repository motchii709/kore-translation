import 'package:flutter/material.dart';
import 'package:kore_client/kore_client.dart';
import 'package:kore_honyaku/app/constants/translation_presets.dart';
import 'package:kore_honyaku/app/ui/components/app_section_header.dart';

/// Input form: source text, target language chips, tone selector and the
/// translate button.
class TranslateInputSection extends StatelessWidget {
  const TranslateInputSection({
    required this.controller,
    required this.targetLanguage,
    required this.onTargetLanguageChanged,
    required this.tone,
    required this.onToneChanged,
    required this.isLoading,
    required this.onSubmit,
    super.key,
  });

  final TextEditingController controller;
  final String targetLanguage;
  final ValueChanged<String> onTargetLanguageChanged;
  final ToneStyle tone;
  final ValueChanged<ToneStyle> onToneChanged;
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
        const AppSectionHeader(title: 'トーン'),
        SegmentedButton<ToneStyle>(
          segments: [
            for (final style in ToneStyle.values)
              ButtonSegment(value: style, label: Text(style.label)),
          ],
          selected: {tone},
          onSelectionChanged: (selection) => onToneChanged(selection.first),
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
