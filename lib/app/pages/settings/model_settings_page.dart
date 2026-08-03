import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kore_config/kore_config.dart';
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
import 'package:kore_translation/app/ui/scroll/use_animated_scroll_controller.dart';

/// The agent backends spawn a local subprocess, which phones cannot do.
const Set<LlmProvider> _localProcessProviders = {LlmProvider.acp, LlmProvider.codex};

class ModelSettingsPage extends ConsumerWidget {
  const ModelSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(llmConfigStorageProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(context.t.settings.model),
      ),
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
/// starts again from the saved profile; on a fresh install (null) only the
/// picker shows until a provider is chosen.
///
/// The scroll view spans the full window so the scrollbar sits at the
/// window's right edge; only the content is width-constrained.
class _ModelSettingsForm extends HookWidget {
  const _ModelSettingsForm({required this.initial});

  final LlmClientConfig? initial;

  @override
  Widget build(BuildContext context) {
    // A build-local copy, so the `is` checks below promote it: the saved
    // profile seeds only its own provider's section, the rest start from
    // their defaults.
    final saved = initial;
    final provider = useState(saved?.provider);
    final canRunLocalProcess = switch (defaultTargetPlatform) {
      TargetPlatform.android || TargetPlatform.iOS => false,
      _ => true,
    };
    return SingleChildScrollView(
      controller: useAnimatedScrollController(),
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
              if (provider.value case final selected?) ...[
                const SizedBox(height: 24),
                switch (selected) {
                  LlmProvider.openAi => OpenAiConfigSection(initial: saved is OpenAiConfig ? saved : null),
                  LlmProvider.openAiCompatible => OpenAiCompatibleConfigSection(
                    initial: saved is OpenAiCompatibleConfig ? saved : null,
                  ),
                  LlmProvider.anthropic => AnthropicConfigSection(initial: saved is AnthropicConfig ? saved : null),
                  LlmProvider.google => GeminiConfigSection(initial: saved is GeminiConfig ? saved : null),
                  LlmProvider.deepSeek => DeepSeekConfigSection(initial: saved is DeepSeekConfig ? saved : null),
                  LlmProvider.acp => AcpConfigSection(initial: saved is AcpConfig ? saved : null),
                  LlmProvider.codex => CodexConfigSection(initial: saved is CodexConfig ? saved : null),
                },
              ],
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
