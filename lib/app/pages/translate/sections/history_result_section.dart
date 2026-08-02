import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kore_client/kore_client.dart';
import 'package:kore_translation/app/data/app_database.dart';
import 'package:kore_translation/app/i18n/translations.g.dart';
import 'package:kore_translation/app/pages/translate/sections/translation_result_section.dart';
import 'package:kore_translation/app/ui/components/app_section_header.dart';

/// Renders a stored history entry in the result pane: the original text and
/// the saved result.
class HistoryResultSection extends StatelessWidget {
  const HistoryResultSection({required this.entry, super.key});

  final HistoryEntry entry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Stored JSON always matches this build's TranslationResult: schema
    // changes bump the database version, which wipes the store instead of
    // migrating.
    final result = TranslationResult.fromJson(jsonDecode(entry.resultJson) as Map<String, dynamic>);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppSectionHeader(title: context.t.history.title),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SelectableText(
              entry.sourceText,
              style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.outline),
            ),
          ),
        ),
        const SizedBox(height: 16),
        TranslationResultView(result),
      ],
    );
  }
}
