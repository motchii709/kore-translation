import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kore_config/kore_config.dart';
import 'package:kore_translation/app/constants/translation_prompt.dart';
import 'package:kore_translation/app/i18n/translations.g.dart';
import 'package:kore_translation/app/pages/settings/widgets/api_key_field.dart';
import 'package:kore_translation/app/pages/settings/widgets/save_settings_button.dart';
import 'package:kore_translation/app/providers/llm_config_provider.dart';
import 'package:kore_translation/app/ui/scroll/use_animated_scroll_controller.dart';

/// The whole API settings form for generic OpenAI-compatible endpoints
/// (Ollama, LM Studio, Groq, OpenRouter, vLLM, ...). No universal defaults
/// exist, so endpoint and model are required here; local servers need no API
/// key. Values are trimmed on save to shed clipboard artifacts that cause
/// hard-to-diagnose authentication failures.
class OpenAiCompatibleConfigSection extends HookConsumerWidget {
  const OpenAiCompatibleConfigSection({required this.initial, super.key});

  final OpenAiCompatibleConfig? initial;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Fresh install or another provider: start from this provider's defaults.
    final config =
        initial ??
        const OpenAiCompatibleConfig(
          systemPrompt: defaultTranslationPromptTemplate,
          proofreadPrompt: defaultProofreadingPromptTemplate,
        );
    final baseUrl = useTextEditingController(text: config.baseUrl);
    final apiKey = useTextEditingController(text: config.apiKey);
    final model = useTextEditingController(text: config.model);
    final systemPrompt = useTextEditingController(text: config.systemPrompt);
    final proofreadPrompt = useTextEditingController(text: config.proofreadPrompt);

    Future<void> save() async {
      FocusScope.of(context).unfocus();
      await ref
          .read(llmConfigStorageProvider.notifier)
          .save(
            OpenAiCompatibleConfig(
              apiKey: apiKey.text.trim(),
              baseUrl: baseUrl.text.trim(),
              model: model.text.trim(),
              systemPrompt: systemPrompt.text.trim(),
              proofreadPrompt: proofreadPrompt.text.trim(),
            ),
          );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.t.settings.saved)));
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: baseUrl,
          keyboardType: TextInputType.url,
          decoration: InputDecoration(
            labelText: context.t.settings.api.baseUrl,
            hintText: 'http://localhost:11434/v1',
            helperText: context.t.settings.openAiCompatible.requiredMark,
          ),
        ),
        const SizedBox(height: 16),
        ApiKeyField(controller: apiKey, helperText: context.t.settings.openAiCompatible.apiKeyHelper),
        const SizedBox(height: 16),
        TextField(
          controller: model,
          decoration: InputDecoration(
            labelText: context.t.settings.api.model,
            hintText: 'llama3',
            helperText: context.t.settings.openAiCompatible.requiredMark,
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: systemPrompt,
          scrollController: useAnimatedScrollController(),
          minLines: 3,
          maxLines: 16,
          decoration: InputDecoration(
            labelText: context.t.settings.api.systemPrompt,
            helperText: context.t.settings.api.systemPromptHelper,
            helperMaxLines: 3,
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: proofreadPrompt,
          scrollController: useAnimatedScrollController(),
          minLines: 3,
          maxLines: 16,
          decoration: InputDecoration(
            labelText: context.t.settings.api.proofreadPrompt,
            helperText: context.t.settings.api.proofreadPromptHelper,
            helperMaxLines: 3,
          ),
        ),
        const SizedBox(height: 24),
        SaveSettingsButton(onPressed: save),
      ],
    );
  }
}
