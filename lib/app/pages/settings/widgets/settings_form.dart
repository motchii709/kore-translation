import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kore_honyaku/app/constants/llm_provider_ui.dart';
import 'package:kore_honyaku/app/models/app_settings.dart';
import 'package:kore_honyaku/app/providers/app_settings_provider.dart';
import 'package:kore_honyaku/app/ui/components/app_section_header.dart';
import 'package:llm_clients/llm_clients.dart';

/// The agent backends spawn a local subprocess, which phones cannot do.
const Set<LlmProvider> _agentProviders = {LlmProvider.acp, LlmProvider.codex};

/// The endpoint defaults of [provider], materialized into the form fields so
/// they always show the values that will actually be used. Empty for the
/// providers without universal defaults (OpenAI-compatible) and for the
/// agent backends, whose fields are not endpoint fields.
({String baseUrl, String model}) _endpointDefaultsOf(LlmProvider provider) => switch (provider) {
  LlmProvider.openAi => (
    baseUrl: const OpenAiConfig(apiKey: '').baseUrl,
    model: const OpenAiConfig(apiKey: '').model,
  ),
  LlmProvider.anthropic => (
    baseUrl: const AnthropicConfig(apiKey: '').baseUrl,
    model: const AnthropicConfig(apiKey: '').model,
  ),
  LlmProvider.google => (
    baseUrl: const GeminiConfig(apiKey: '').baseUrl,
    model: const GeminiConfig(apiKey: '').model,
  ),
  LlmProvider.deepSeek => (
    baseUrl: const DeepSeekConfig(apiKey: '').baseUrl,
    model: const DeepSeekConfig(apiKey: '').model,
  ),
  LlmProvider.openAiCompatible || LlmProvider.acp || LlmProvider.codex => (baseUrl: '', model: ''),
};

/// Edits [AppSettings]. Every field holds the value that will actually be
/// used; switching the provider replaces the endpoint fields with that
/// provider's defaults, and saving builds the [LlmClientConfig] variant of
/// the selected provider from the fields.
class SettingsForm extends HookConsumerWidget {
  const SettingsForm({required this.initialSettings, super.key});

  final AppSettings initialSettings;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initial = initialSettings.llm;
    final provider = useState(initial.provider);
    final baseUrlController = useTextEditingController(
      text: switch (initial) {
        OpenAiConfig(:final baseUrl) ||
        OpenAiCompatibleConfig(:final baseUrl) ||
        AnthropicConfig(:final baseUrl) ||
        GeminiConfig(:final baseUrl) ||
        DeepSeekConfig(:final baseUrl) => baseUrl,
        AcpConfig() || CodexConfig() => '',
      },
    );
    final apiKeyController = useTextEditingController(
      text: switch (initial) {
        OpenAiConfig(:final apiKey) ||
        OpenAiCompatibleConfig(:final apiKey) ||
        AnthropicConfig(:final apiKey) ||
        GeminiConfig(:final apiKey) ||
        DeepSeekConfig(:final apiKey) => apiKey,
        AcpConfig() || CodexConfig() => '',
      },
    );
    final modelController = useTextEditingController(
      text: switch (initial) {
        OpenAiConfig(:final model) ||
        OpenAiCompatibleConfig(:final model) ||
        AnthropicConfig(:final model) ||
        GeminiConfig(:final model) ||
        DeepSeekConfig(:final model) ||
        CodexConfig(:final model) => model,
        AcpConfig() => '',
      },
    );
    final acpCommandController = useTextEditingController(
      text: switch (initial) {
        AcpConfig(:final command) => command,
        _ => '',
      },
    );
    final codexCommandController = useTextEditingController(
      text: switch (initial) {
        CodexConfig(:final command) => command,
        _ => const CodexConfig().command,
      },
    );
    final obscureApiKey = useState(true);
    final thinking = useState(initialSettings.thinking);
    final systemPromptController = useTextEditingController(text: initialSettings.systemPrompt);
    // Generic OpenAI-compatible endpoints have no universal defaults, so the
    // endpoint and model must be filled in; local servers need no API key.
    final isCompatible = provider.value == LlmProvider.openAiCompatible;
    final canRunAgents = switch (defaultTargetPlatform) {
      TargetPlatform.android || TargetPlatform.iOS => false,
      _ => true,
    };

    Future<void> save() async {
      FocusScope.of(context).unfocus();
      // Trim clipboard artifacts (trailing whitespace and newlines) that
      // cause hard-to-diagnose authentication failures.
      final llm = switch (provider.value) {
        LlmProvider.openAi => LlmClientConfig.openAi(
          apiKey: apiKeyController.text.trim(),
          baseUrl: baseUrlController.text.trim(),
          model: modelController.text.trim(),
        ),
        LlmProvider.openAiCompatible => LlmClientConfig.openAiCompatible(
          apiKey: apiKeyController.text.trim(),
          baseUrl: baseUrlController.text.trim(),
          model: modelController.text.trim(),
        ),
        LlmProvider.anthropic => LlmClientConfig.anthropic(
          apiKey: apiKeyController.text.trim(),
          baseUrl: baseUrlController.text.trim(),
          model: modelController.text.trim(),
        ),
        LlmProvider.google => LlmClientConfig.google(
          apiKey: apiKeyController.text.trim(),
          baseUrl: baseUrlController.text.trim(),
          model: modelController.text.trim(),
        ),
        LlmProvider.deepSeek => LlmClientConfig.deepSeek(
          apiKey: apiKeyController.text.trim(),
          baseUrl: baseUrlController.text.trim(),
          model: modelController.text.trim(),
        ),
        LlmProvider.acp => LlmClientConfig.acp(command: acpCommandController.text.trim()),
        LlmProvider.codex => LlmClientConfig.codex(
          command: codexCommandController.text.trim(),
          model: modelController.text.trim(),
        ),
      };
      await ref
          .read(appSettingsStorageProvider.notifier)
          .save(
            AppSettings(
              llm: llm,
              thinking: thinking.value,
              systemPrompt: systemPromptController.text.trim(),
            ),
          );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('設定を保存しました')));
      }
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const AppSectionHeader(title: 'LLMプロバイダ'),
        DropdownMenu<LlmProvider>(
          initialSelection: provider.value,
          expandedInsets: EdgeInsets.zero,
          dropdownMenuEntries: [
            for (final value in LlmProvider.values)
              if (canRunAgents || !_agentProviders.contains(value))
                DropdownMenuEntry(value: value, label: value.label),
          ],
          onSelected: (value) {
            if (value == null || value == provider.value) {
              return;
            }
            provider.value = value;
            final defaults = _endpointDefaultsOf(value);
            baseUrlController.text = defaults.baseUrl;
            modelController.text = defaults.model;
          },
        ),
        const SizedBox(height: 24),
        if (provider.value == LlmProvider.acp) ...[
          const AppSectionHeader(title: 'エージェント設定'),
          TextField(
            controller: acpCommandController,
            decoration: const InputDecoration(
              labelText: 'ACPコマンド',
              hintText: 'npx -y @agentclientprotocol/claude-agent-acp',
              helperText:
                  '必須。ACPエージェントを起動するコマンドです。\n'
                  '認証とモデルはエージェント側の設定に従います',
              helperMaxLines: 2,
            ),
          ),
        ] else if (provider.value == LlmProvider.codex) ...[
          const AppSectionHeader(title: 'エージェント設定'),
          TextField(
            controller: codexCommandController,
            decoration: const InputDecoration(
              labelText: 'Codexコマンド',
              helperText: '認証は codex login に従います',
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: modelController,
            decoration: const InputDecoration(
              labelText: 'モデル',
              hintText: 'gpt-5.6-sol',
              helperText: '指定すると Codex の既定モデルを上書きします',
            ),
          ),
        ] else ...[
          const AppSectionHeader(title: 'API設定'),
          TextField(
            controller: baseUrlController,
            keyboardType: TextInputType.url,
            decoration: InputDecoration(
              labelText: 'ベースURL',
              hintText: isCompatible ? 'http://localhost:11434/v1' : null,
              helperText: isCompatible ? '必須' : null,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: apiKeyController,
            obscureText: obscureApiKey.value,
            decoration: InputDecoration(
              labelText: 'APIキー',
              helperText: isCompatible ? 'ローカルサーバの場合は空欄可。端末のセキュアストレージにのみ保存されます' : 'APIキーは端末のセキュアストレージにのみ保存されます',
              suffixIcon: IconButton(
                tooltip: obscureApiKey.value ? '表示' : '隠す',
                icon: Icon(
                  obscureApiKey.value ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                ),
                onPressed: () => obscureApiKey.value = !obscureApiKey.value,
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: modelController,
            decoration: InputDecoration(
              labelText: 'モデル',
              hintText: isCompatible ? 'llama3' : null,
              helperText: isCompatible ? '必須' : null,
            ),
          ),
        ],
        const SizedBox(height: 24),
        const AppSectionHeader(title: '翻訳オプション'),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('思考 (thinking)'),
          subtitle: const Text('対応モデルの思考を有効にし、ストリーミング表示します'),
          value: thinking.value,
          onChanged: (value) => thinking.value = value,
        ),
        const SizedBox(height: 16),
        TextField(
          controller: systemPromptController,
          minLines: 3,
          maxLines: 8,
          decoration: const InputDecoration(
            labelText: 'システムプロンプト',
            helperText:
                '{{target}} と {{tone}} が翻訳時に置換されます。\n'
                '応答フォーマットの指示は自動で付加されます',
            helperMaxLines: 2,
          ),
        ),
        const SizedBox(height: 24),
        FilledButton.icon(
          onPressed: save,
          icon: const Icon(Icons.save_outlined),
          label: const Text('保存'),
        ),
      ],
    );
  }
}
