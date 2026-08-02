import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kore_translation/app/constants/translation_prompt.dart';
import 'package:kore_translation/app/i18n/translations.g.dart';
import 'package:kore_translation/app/pages/settings/widgets/save_settings_button.dart';
import 'package:kore_translation/app/pages/settings/widgets/thinking_switch_tile.dart';
import 'package:kore_translation/app/providers/llm_config_provider.dart';
import 'package:llm_clients/llm_clients.dart';

/// The whole settings form for the Codex app-server: the launch command, an
/// optional model override, the thinking toggle, the system prompt and save;
/// credentials come from `codex login`. Values are trimmed on save to shed
/// clipboard artifacts that cause hard-to-diagnose launch failures.
class CodexConfigSection extends HookConsumerWidget {
  const CodexConfigSection({required this.initial, super.key});

  final LlmClientConfig initial;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = switch (initial) {
      final CodexConfig config => config,
      // Coming from another provider: start from this provider's defaults.
      _ => const CodexConfig(systemPrompt: defaultTranslationPromptTemplate),
    };
    final command = useTextEditingController(text: config.command);
    final model = useTextEditingController(text: config.model);
    final thinking = useState(config.thinking);
    final systemPrompt = useTextEditingController(text: config.systemPrompt);

    Future<void> save() async {
      FocusScope.of(context).unfocus();
      await ref
          .read(llmConfigStorageProvider.notifier)
          .save(
            CodexConfig(
              command: command.text.trim(),
              model: model.text.trim(),
              thinking: thinking.value,
              systemPrompt: systemPrompt.text.trim(),
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
          controller: command,
          decoration: InputDecoration(
            labelText: context.t.settings.codex.command,
            helperText: context.t.settings.codex.commandHelper,
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: model,
          decoration: InputDecoration(
            labelText: context.t.settings.api.model,
            hintText: 'gpt-5.6-sol',
            helperText: context.t.settings.codex.modelHelper,
          ),
        ),
        const SizedBox(height: 8),
        ThinkingSwitchTile(value: thinking.value, onChanged: (value) => thinking.value = value),
        const SizedBox(height: 16),
        TextField(
          controller: systemPrompt,
          minLines: 3,
          maxLines: 16,
          decoration: InputDecoration(
            labelText: context.t.settings.api.systemPrompt,
            helperText: '${context.t.settings.api.systemPromptHelper}\n${context.t.settings.codex.promptNote}',
            helperMaxLines: 4,
          ),
        ),
        const SizedBox(height: 24),
        SaveSettingsButton(onPressed: save),
      ],
    );
  }
}
