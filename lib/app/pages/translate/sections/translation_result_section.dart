import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kore_client/kore_client.dart';
import 'package:kore_honyaku/app/ui/components/app_section_header.dart';

/// Renders the state of the latest translation request.
class TranslationResultSection extends StatelessWidget {
  const TranslationResultSection({required this.result, super.key});

  final AsyncValue<TranslationResult?> result;

  @override
  Widget build(BuildContext context) {
    return switch (result) {
      AsyncData(value: null) => const _EmptyHint(),
      AsyncData(value: final translation?) => _ResultView(translation),
      AsyncError(:final error) => _ErrorCard(error),
      _ => const Padding(
          padding: EdgeInsets.symmetric(vertical: 32),
          child: Center(child: CircularProgressIndicator()),
        ),
    };
  }
}

class _EmptyHint extends StatelessWidget {
  const _EmptyHint();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Center(
        child: Text(
          '翻訳結果がここに表示されます',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.outline,
          ),
        ),
      ),
    );
  }
}

class _ResultView extends StatelessWidget {
  const _ResultView(this.translation);

  final TranslationResult translation;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const AppSectionHeader(title: '翻訳結果'),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (translation.detectedLanguage.isNotEmpty) ...[
                  Text(
                    '検出言語: ${translation.detectedLanguage}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.outline,
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SelectableText(
                        translation.translation,
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                    IconButton(
                      tooltip: 'コピー',
                      icon: const Icon(Icons.copy_outlined, size: 20),
                      onPressed: () async {
                        await Clipboard.setData(
                          ClipboardData(text: translation.translation),
                        );
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('コピーしました')),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (translation.alternatives.isNotEmpty) ...[
          const SizedBox(height: 16),
          const AppSectionHeader(title: '別の言い方'),
          for (final alternative in translation.alternatives)
            Card(
              child: ListTile(
                title: SelectableText(alternative.text),
                subtitle: alternative.nuance.isEmpty
                    ? null
                    : Text(alternative.nuance),
              ),
            ),
        ],
        if (translation.explanation.isNotEmpty) ...[
          const SizedBox(height: 16),
          const AppSectionHeader(title: '解説'),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SelectableText(translation.explanation),
            ),
          ),
        ],
      ],
    );
  }
}

class _ErrorCard extends StatelessWidget {
  const _ErrorCard(this.error);

  final Object error;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      color: colorScheme.errorContainer,
      child: ListTile(
        leading: Icon(Icons.error_outline, color: colorScheme.error),
        title: const Text('翻訳に失敗しました'),
        subtitle: Text(
          switch (error) {
            final KoreClientException e => e.message,
            _ => '$error',
          },
        ),
      ),
    );
  }
}
