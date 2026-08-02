import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kore_client/kore_client.dart';
import 'package:kore_honyaku/app/constants/llm_provider_ui.dart';
import 'package:kore_honyaku/app/constants/translation_prompt.dart';
import 'package:kore_honyaku/app/models/app_settings.dart';
import 'package:kore_honyaku/app/providers/app_settings_provider.dart';
import 'package:kore_honyaku/app/ui/components/app_section_header.dart';

/// Edits [AppSettings]. The LLM backend is freely selectable; base URL and
/// model fall back to the provider defaults when left empty.
class SettingsForm extends HookConsumerWidget {
  const SettingsForm({required this.initialSettings, super.key});

  final AppSettings initialSettings;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = useState(initialSettings.provider);
    final baseUrlController = useTextEditingController(text: initialSettings.baseUrl);
    final apiKeyController = useTextEditingController(text: initialSettings.apiKey);
    final modelController = useTextEditingController(text: initialSettings.model);
    final obscureApiKey = useState(true);
    final thinking = useState(initialSettings.thinking);
    final systemPromptController = useTextEditingController(text: initialSettings.systemPrompt);
    final defaults = LlmClientConfig.forProvider(provider.value, apiKey: '');
    // Generic OpenAI-compatible endpoints have no universal defaults, so the
    // endpoint and model must be filled in; local servers need no API key.
    final isCompatible = provider.value == LlmProvider.openAiCompatible;

    Future<void> save() async {
      FocusScope.of(context).unfocus();
      // Trim clipboard artifacts (trailing whitespace and newlines) that
      // cause hard-to-diagnose authentication failures.
      await ref
          .read(appSettingsStorageProvider.notifier)
          .save(
            AppSettings(
              provider: provider.value,
              baseUrl: baseUrlController.text.trim(),
              apiKey: apiKeyController.text.trim(),
              model: modelController.text.trim(),
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
            for (final value in LlmProvider.values) DropdownMenuEntry(value: value, label: value.label),
          ],
          onSelected: (value) {
            if (value != null) {
              provider.value = value;
            }
          },
        ),
        const SizedBox(height: 24),
        const AppSectionHeader(title: 'API設定'),
        TextField(
          controller: baseUrlController,
          keyboardType: TextInputType.url,
          decoration: InputDecoration(
            labelText: 'ベースURL',
            hintText: isCompatible ? 'http://localhost:11434/v1' : defaults.baseUrl,
            helperText: isCompatible ? '必須' : '空欄の場合はプロバイダのデフォルトを使用します',
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
            hintText: isCompatible ? 'llama3' : defaults.model,
            helperText: isCompatible ? '必須' : '空欄の場合はプロバイダのデフォルトを使用します',
          ),
        ),
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
            hintText: defaultTranslationPromptTemplate,
            helperText:
                '空欄の場合はデフォルトを使用します。{{target}} と {{tone}} が翻訳時に置換されます。\n'
                '応答フォーマットの指示は自動で付加されます',
            helperMaxLines: 3,
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
