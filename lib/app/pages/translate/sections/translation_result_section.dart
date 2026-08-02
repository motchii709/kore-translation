import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kore_client/kore_client.dart';
import 'package:kore_translation/app/i18n/translations.g.dart';
import 'package:kore_translation/app/ui/components/app_section_header.dart';
import 'package:llm_clients/llm_clients.dart';

/// Renders the state of the latest translation request.
class TranslationResultSection extends StatelessWidget {
  const TranslationResultSection({required this.update, super.key});

  final AsyncValue<TranslationEvent?> update;

  @override
  Widget build(BuildContext context) {
    return switch (update) {
      AsyncData(value: null) => const _EmptyHint(),
      AsyncData(value: final update?) => _UpdateView(update),
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
          context.t.translate.result.placeholder,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.outline,
          ),
        ),
      ),
    );
  }
}

class _UpdateView extends StatelessWidget {
  const _UpdateView(this.update);

  final TranslationEvent update;

  @override
  Widget build(BuildContext context) {
    final result = update.result;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (update.thinking.isNotEmpty) ...[
          _ThinkingView(update.thinking),
          const SizedBox(height: 16),
        ],
        if (result != null)
          TranslationResultView(result)
        else if (update.thinking.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 32),
            child: Center(child: CircularProgressIndicator()),
          ),
      ],
    );
  }
}

/// The model's reasoning, streamed live.
class _ThinkingView extends StatelessWidget {
  const _ThinkingView(this.thinking);

  final String thinking;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppSectionHeader(title: context.t.translate.result.thinking),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SelectableText(
              thinking,
              style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.outline),
            ),
          ),
        ),
      ],
    );
  }
}

/// A [TranslationResult], as shown for both live translations and stored
/// history entries.
class TranslationResultView extends StatelessWidget {
  const TranslationResultView(this.translation, {super.key});

  final TranslationResult translation;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppSectionHeader(title: context.t.translate.result.title),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (translation.detectedLanguage.isNotEmpty) ...[
                  Text(
                    // The output language is the model's decision (language
                    // pairing), so it is shown too. History entries from
                    // before target_language existed fall back to the
                    // detected language alone.
                    translation.targetLanguage.isEmpty
                        ? context.t.translate.result.detectedLanguage(language: translation.detectedLanguage)
                        : context.t.translate.result.languagePair(
                            source: translation.detectedLanguage,
                            target: translation.targetLanguage,
                          ),
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
                      tooltip: context.t.translate.result.copy,
                      icon: const Icon(Icons.copy_outlined, size: 20),
                      onPressed: () async {
                        await Clipboard.setData(
                          ClipboardData(text: translation.translation),
                        );
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(context.t.translate.result.copied)),
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
          AppSectionHeader(title: context.t.translate.result.alternatives),
          for (final alternative in translation.alternatives)
            Card(
              child: ListTile(
                title: SelectableText(alternative.text),
                subtitle: alternative.nuance.isEmpty ? null : Text(alternative.nuance),
              ),
            ),
        ],
        if (translation.explanation.isNotEmpty) ...[
          const SizedBox(height: 16),
          AppSectionHeader(title: context.t.translate.result.explanation),
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
    final message = switch (error) {
      final KoreClientException e => e.message,
      final LlmApiException e => e.message,
      // DioException.toString() does not include the response body, which
      // carries the API's actual error message.
      final DioException e when e.response?.data != null => '$e\n${e.response?.data}',
      _ => '$error',
    };
    return Card(
      color: colorScheme.errorContainer,
      child: ListTile(
        leading: Icon(Icons.error_outline, color: colorScheme.error),
        title: Text(context.t.translate.result.failed),
        subtitle: SelectableText(message),
        trailing: IconButton(
          tooltip: context.t.translate.result.copyError,
          icon: const Icon(Icons.copy_outlined, size: 20),
          onPressed: () async {
            await Clipboard.setData(ClipboardData(text: message));
            if (context.mounted) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(context.t.translate.result.copied)));
            }
          },
        ),
      ),
    );
  }
}
