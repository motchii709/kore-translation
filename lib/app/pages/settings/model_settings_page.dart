import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kore_translation/app/i18n/translations.g.dart';
import 'package:kore_translation/app/pages/settings/sections/acp_config_section.dart';
import 'package:kore_translation/app/pages/settings/sections/anthropic_config_section.dart';
import 'package:kore_translation/app/pages/settings/sections/codex_config_section.dart';
import 'package:kore_translation/app/pages/settings/sections/deep_seek_config_section.dart';
import 'package:kore_translation/app/pages/settings/sections/gemini_config_section.dart';
import 'package:kore_translation/app/pages/settings/sections/open_ai_compatible_config_section.dart';
import 'package:kore_translation/app/pages/settings/sections/open_ai_config_section.dart';
import 'package:kore_translation/app/providers/llm_config_provider.dart';
import 'package:kore_translation/app/ui/layout/app_breakpoints.dart';
import 'package:llm_clients/llm_clients.dart';
import 'package:silky_scroll/silky_scroll.dart';

/// The agent backends spawn a local subprocess, which phones cannot do.
const Set<LlmProvider> _localProcessProviders = {LlmProvider.acp, LlmProvider.codex};

class ModelSettingsPage extends ConsumerWidget {
  const ModelSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(llmConfigStorageProvider);
    return Scaffold(
      appBar: AppBar(title: Text(context.t.settings.model)),
      body: SafeArea(
        child: switch (config) {
          AsyncData(:final value) => _ModelSettingsForm(initial: value),
          AsyncError(:final error) => Center(child: Text(context.t.settings.loadFailed(error: '$error'))),
          _ => const Center(child: CircularProgressIndicator()),
        },
      ),
    );
  }
}

/// Provider picker plus the selected provider's own config section, which
/// owns every field of the profile and its save button. Switching providers
/// starts again from the saved profile.
///
/// The scroll view spans the full window so the scrollbar sits at the
/// window's right edge; only the content is width-constrained.
class _ModelSettingsForm extends HookWidget {
  const _ModelSettingsForm({required this.initial});

  final LlmClientConfig initial;

  @override
  Widget build(BuildContext context) {
    final provider = useState(initial.provider);
    final canRunLocalProcess = switch (defaultTargetPlatform) {
      TargetPlatform.android || TargetPlatform.iOS => false,
      _ => true,
    };
    return SilkySingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppBreakpoints.maxFormWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownMenu<LlmProvider>(
                initialSelection: provider.value,
                expandedInsets: EdgeInsets.zero,
                label: Text(context.t.settings.provider),
                dropdownMenuEntries: [
                  for (final value in LlmProvider.values)
                    if (canRunLocalProcess || !_localProcessProviders.contains(value))
                      DropdownMenuEntry(value: value, label: _providerLabelOf(context, value)),
                ],
                onSelected: (value) {
                  if (value != null) {
                    provider.value = value;
                  }
                },
              ),
              const SizedBox(height: 24),
              switch (provider.value) {
                LlmProvider.openAi => OpenAiConfigSection(initial: initial),
                LlmProvider.openAiCompatible => OpenAiCompatibleConfigSection(initial: initial),
                LlmProvider.anthropic => AnthropicConfigSection(initial: initial),
                LlmProvider.google => GeminiConfigSection(initial: initial),
                LlmProvider.deepSeek => DeepSeekConfigSection(initial: initial),
                LlmProvider.acp => AcpConfigSection(initial: initial),
                LlmProvider.codex => CodexConfigSection(initial: initial),
              },
            ],
          ),
        ),
      ),
    );
  }
}

/// Display names are this page's concern; the enum stays a pure identifier.
String _providerLabelOf(BuildContext context, LlmProvider provider) => switch (provider) {
  LlmProvider.openAi => context.t.settings.providers.openAi,
  LlmProvider.openAiCompatible => context.t.settings.providers.openAiCompatible,
  LlmProvider.anthropic => context.t.settings.providers.anthropic,
  LlmProvider.google => context.t.settings.providers.google,
  LlmProvider.deepSeek => context.t.settings.providers.deepSeek,
  LlmProvider.acp => context.t.settings.providers.acp,
  LlmProvider.codex => context.t.settings.providers.codex,
};
