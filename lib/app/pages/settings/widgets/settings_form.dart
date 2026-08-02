import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kore_client/kore_client.dart';
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
    final baseUrlController =
        useTextEditingController(text: initialSettings.baseUrl);
    final apiKeyController =
        useTextEditingController(text: initialSettings.apiKey);
    final modelController =
        useTextEditingController(text: initialSettings.model);
    final obscureApiKey = useState(true);

    Future<void> save() async {
      FocusScope.of(context).unfocus();
      await ref.read(appSettingsStorageProvider.notifier).save(
            AppSettings(
              provider: provider.value,
              baseUrl: baseUrlController.text.trim(),
              apiKey: apiKeyController.text.trim(),
              model: modelController.text.trim(),
            ),
          );
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('設定を保存しました')));
      }
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const AppSectionHeader(title: 'LLMプロバイダ'),
        SegmentedButton<LlmProvider>(
          segments: [
            for (final value in LlmProvider.values)
              ButtonSegment(value: value, label: Text(value.label)),
          ],
          selected: {provider.value},
          onSelectionChanged: (selection) => provider.value = selection.first,
        ),
        const SizedBox(height: 24),
        const AppSectionHeader(title: 'API設定'),
        TextField(
          controller: baseUrlController,
          keyboardType: TextInputType.url,
          decoration: InputDecoration(
            labelText: 'ベースURL',
            hintText: provider.value.defaultBaseUrl,
            helperText: '空欄の場合はプロバイダのデフォルトを使用します',
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: apiKeyController,
          obscureText: obscureApiKey.value,
          decoration: InputDecoration(
            labelText: 'APIキー',
            helperText: 'APIキーは端末のセキュアストレージにのみ保存されます',
            suffixIcon: IconButton(
              tooltip: obscureApiKey.value ? '表示' : '隠す',
              icon: Icon(
                obscureApiKey.value
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
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
            hintText: provider.value.defaultModel,
            helperText: '空欄の場合はプロバイダのデフォルトを使用します',
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
