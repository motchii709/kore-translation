import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kore_translation/app/i18n/translations.g.dart';
import 'package:kore_translation/app/pages/translate/sections/translation_result_section.dart';
import 'package:kore_translation/app/ui/layout/app_breakpoints.dart';
import 'package:kore_translation/app/ui/scroll/use_animated_scroll_controller.dart';

/// Narrow-layout destination for one translation (`/entries/:id`), live or
/// stored; the wide layouts show the same content in the result pane
/// instead of navigating.
class HistoryEntryPage extends HookWidget {
  const HistoryEntryPage({required this.id, super.key});

  final int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.t.translate.result.title)),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: useAnimatedScrollController(),
          padding: const EdgeInsets.all(16),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: AppBreakpoints.maxSingleColumnWidth),
              child: EntryResultView(id: id),
            ),
          ),
        ),
      ),
    );
  }
}
