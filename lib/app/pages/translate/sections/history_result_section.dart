import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kore_client/kore_client.dart';
import 'package:kore_translation/app/data/app_database.dart';
import 'package:kore_translation/app/pages/translate/sections/translation_result_section.dart';

/// Renders a stored history entry in the result pane: the original text and
/// the saved result, mirroring the live view.
class HistoryResultSection extends StatelessWidget {
  const HistoryResultSection({required this.entry, super.key});

  final HistoryEntry entry;

  @override
  Widget build(BuildContext context) {
    // Stored JSON that no longer matches this build's TranslationResult
    // surfaces raw right here (beta policy: no migrations); the user
    // recovers by deleting the database from the advanced settings.
    final result = TranslationResult.fromJson(jsonDecode(entry.resultJson) as Map<String, dynamic>);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SourceTextView(entry.sourceText),
        const SizedBox(height: 16),
        TranslationResultView(result),
      ],
    );
  }
}
