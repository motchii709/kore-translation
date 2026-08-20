import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kore_client/kore_client.dart';
import 'package:kore_translation/app/data/app_database.dart';
import 'package:kore_translation/app/i18n/translations.g.dart';
import 'package:kore_translation/app/pages/translate/sections/history_result_section.dart';
import 'package:kore_translation/app/providers/history_provider.dart';
import 'package:kore_translation/app/providers/translation_jobs_provider.dart';
import 'package:kore_translation/app/ui/components/app_section_header.dart';
import 'package:llm_sdk_core/llm_sdk_core.dart';
import 'package:llm_sdk_http/llm_sdk_http.dart';

/// The result pane: the selected history entry — live translations are
/// history entries from the moment they start, so selecting one switches
/// between streams. Watches its own providers, so streaming deltas rebuild
/// only this pane.
class TranslationResultSection extends ConsumerWidget {
  const TranslationResultSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedId = ref.watch(selectedHistoryEntryIdProvider);
    if (selectedId == null) {
      return const _EmptyHint();
    }
    return EntryResultView(id: selectedId);
  }
}

/// One history entry by id, shared by the result pane and the narrow
/// layout's entry page: this session's job wins over the stored row — it
/// has the streaming progress, the thinking text and any error.
class EntryResultView extends ConsumerWidget {
  const EntryResultView({required this.id, super.key});

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final job = ref.watch(translationJobsProvider.select((jobs) => jobs[id]));
    if (job != null) {
      return switch (job) {
        AsyncData(:final value) => _UpdateView(value),
        AsyncError(:final error) => _ErrorCard(error),
        _ => const Padding(
          padding: EdgeInsets.symmetric(vertical: 32),
          child: Center(child: CircularProgressIndicator()),
        ),
      };
    }
    // No job (an entry from an earlier session): the stored row.
    final entry = ref.watch(
      historyEntriesProvider.select((entries) {
        for (final entry in entries.value ?? const <HistoryEntry>[]) {
          if (entry.id == id) {
            return entry;
          }
        }
        return null;
      }),
    );
    return entry == null ? const _EmptyHint() : HistoryResultSection(entry: entry);
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
        if (update.sourceText case final sourceText?) ...[
          SourceTextView(sourceText),
          const SizedBox(height: 16),
        ],
        if (update.thinking case final thinking?) ...[
          _ThinkingView(thinking),
          const SizedBox(height: 16),
        ],
        if (result != null && result.translation != null)
          TranslationResultView(result)
        else if (update.thinking == null)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 32),
            child: Center(child: CircularProgressIndicator()),
          ),
      ],
    );
  }
}

/// The request's source text, as shown for both live translations and
/// stored history entries.
class SourceTextView extends StatelessWidget {
  const SourceTextView(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppSectionHeader(title: context.t.translate.sourceText),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SelectableText(
              text,
              style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.outline),
            ),
          ),
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
        // A proofread result announces itself by its `proofread` notes
        // (translations carry `explanation` instead), so the header can
        // label it without the job being threaded through storage.
        AppSectionHeader(
          title: translation.proofread != null
              ? context.t.translate.result.proofreadTitle
              : context.t.translate.result.title,
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (translation.detectedLanguage case final detected?) ...[
                  Text(
                    // The output language is the model's decision (language
                    // pairing), so it is shown too. Like every meta field,
                    // null means the model has not provided it (see
                    // TranslationResult) — then only the detected language
                    // is worth a line.
                    switch (translation.targetLanguage) {
                      final target? => context.t.translate.result.languagePair(source: detected, target: target),
                      null => context.t.translate.result.detectedLanguage(language: detected),
                    },
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
                        translation.translation ?? '',
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                    IconButton(
                      tooltip: context.t.translate.result.copy,
                      icon: const Icon(Icons.copy_outlined, size: 20),
                      onPressed: () async {
                        await Clipboard.setData(
                          ClipboardData(text: translation.translation ?? ''),
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
        // The explanation belongs right under the result it explains; the
        // alternatives come after. The schema requests the same order so
        // streaming reveals the sections top to bottom.
        if (translation.explanation ?? translation.proofread case final notes?) ...[
          const SizedBox(height: 16),
          AppSectionHeader(title: context.t.translate.result.explanation),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SelectableText(notes),
            ),
          ),
        ],
        if (translation.alternatives case final alternatives?) ...[
          const SizedBox(height: 16),
          AppSectionHeader(title: context.t.translate.result.alternatives),
          for (final alternative in alternatives)
            Card(
              child: ListTile(
                title: SelectableText(alternative.text ?? ''),
                subtitle: switch (alternative.nuance) {
                  final nuance? => Text(nuance),
                  null => null,
                },
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
        final StreamingHttpException e => e.body != null ? '${e.message}\n${e.body}' : e.message,
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
