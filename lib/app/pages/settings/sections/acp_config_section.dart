import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kore_translation/app/constants/translation_prompt.dart';
import 'package:kore_translation/app/i18n/translations.g.dart';
import 'package:kore_translation/app/pages/settings/widgets/save_settings_button.dart';
import 'package:kore_translation/app/providers/llm_config_provider.dart';
import 'package:llm_clients/llm_clients.dart';

/// The whole settings form for an Agent Client Protocol agent: the launch
/// command, the system prompt and save. The agent brings its own credentials
/// and model. Values are trimmed on save to shed clipboard artifacts that
/// cause hard-to-diagnose launch failures.
class AcpConfigSection extends HookConsumerWidget {
  const AcpConfigSection({required this.initial, super.key});

  final LlmClientConfig initial;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = switch (initial) {
      final AcpConfig config => config,
      // Coming from another provider: start from this provider's defaults.
      _ => const AcpConfig(systemPrompt: defaultTranslationPromptTemplate),
    };
    final command = useTextEditingController(text: config.command);
    final systemPrompt = useTextEditingController(text: config.systemPrompt);

    Future<void> save() async {
      FocusScope.of(context).unfocus();
      await ref
          .read(llmConfigStorageProvider.notifier)
          .save(
            AcpConfig(
              command: command.text.trim(),
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
            labelText: context.t.settings.acp.command,
            hintText: 'npx -y @agentclientprotocol/claude-agent-acp',
            helperText: context.t.settings.acp.commandHelper,
            helperMaxLines: 2,
          ),
        ),
        // No thinking toggle: ACP agents reason at their own discretion; AcpConfig has no thinking field.
        const SizedBox(height: 16),
        TextField(
          controller: systemPrompt,
          minLines: 3,
          maxLines: 16,
          decoration: InputDecoration(
            labelText: context.t.settings.api.systemPrompt,
            helperText: '${context.t.settings.api.systemPromptHelper}\n${context.t.settings.acp.promptNote}',
            helperMaxLines: 4,
          ),
        ),
        const SizedBox(height: 24),
        SaveSettingsButton(onPressed: save),
      ],
    );
  }
}
