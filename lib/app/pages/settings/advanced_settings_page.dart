import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kore_translation/app/i18n/translations.g.dart';
import 'package:kore_translation/app/models/ui_settings.dart';
import 'package:kore_translation/app/pages/settings/widgets/save_settings_button.dart';
import 'package:kore_translation/app/providers/app_database_provider.dart';
import 'package:kore_translation/app/providers/history_provider.dart';
import 'package:kore_translation/app/providers/llm_config_provider.dart';
import 'package:kore_translation/app/providers/ui_settings_provider.dart';
import 'package:kore_translation/app/ui/components/app_section_header.dart';
import 'package:kore_translation/app/ui/layout/app_breakpoints.dart';
import 'package:silky_scroll/silky_scroll.dart';

class AdvancedSettingsPage extends ConsumerWidget {
  const AdvancedSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(uiSettingsStorageProvider);
    return Scaffold(
      appBar: AppBar(title: Text(context.t.settings.advanced.title)),
      body: SafeArea(
        child: SilkySingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: AppBreakpoints.maxFormWidth),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // The preferences need the stored value, so a load error
                  // surfaces here — while the danger zone below stays
                  // reachable, because deleting the database is the recovery
                  // path for exactly that error.
                  switch (settings) {
                    AsyncData(:final value) => _PreferencesForm(initial: value),
                    AsyncError(:final error) => Text(context.t.settings.loadFailed(error: '$error')),
                    _ => const Center(child: CircularProgressIndicator()),
                  },
                  const SizedBox(height: 32),
                  const _DangerZone(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Edits [UiSettings]; the choices apply when saved.
class _PreferencesForm extends HookConsumerWidget {
  const _PreferencesForm({required this.initial});

  final UiSettings initial;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final language = useState(initial.language);
    final themeMode = useState(initial.themeMode);
    final submitShortcut = useState(initial.submitShortcut);
    final theme = Theme.of(context);

    Future<void> save() async {
      await ref
          .read(uiSettingsStorageProvider.notifier)
          .save(
            UiSettings(
              themeMode: themeMode.value,
              submitShortcut: submitShortcut.value,
              language: language.value,
            ),
          );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.t.settings.saved)));
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(context.t.settings.advanced.language, style: theme.textTheme.labelLarge),
        const SizedBox(height: 8),
        SegmentedButton<AppLanguage>(
          showSelectedIcon: false,
          segments: [
            ButtonSegment(
              value: AppLanguage.system,
              label: Text(context.t.settings.advanced.languageSystem),
            ),
            // Language names in their own language, like the picker chips
            // on the translate page.
            const ButtonSegment(value: AppLanguage.ja, label: Text('日本語')),
            const ButtonSegment(value: AppLanguage.en, label: Text('English')),
          ],
          selected: {language.value},
          onSelectionChanged: (selection) => language.value = selection.single,
        ),
        const SizedBox(height: 16),
        Text(context.t.settings.advanced.theme, style: theme.textTheme.labelLarge),
        const SizedBox(height: 8),
        SegmentedButton<ThemeMode>(
          showSelectedIcon: false,
          segments: [
            ButtonSegment(value: ThemeMode.system, label: Text(context.t.settings.advanced.themeSystem)),
            ButtonSegment(value: ThemeMode.light, label: Text(context.t.settings.advanced.themeLight)),
            ButtonSegment(value: ThemeMode.dark, label: Text(context.t.settings.advanced.themeDark)),
          ],
          selected: {themeMode.value},
          onSelectionChanged: (selection) => themeMode.value = selection.single,
        ),
        const SizedBox(height: 16),
        Text(context.t.settings.advanced.submit, style: theme.textTheme.labelLarge),
        const SizedBox(height: 8),
        SegmentedButton<SubmitShortcut>(
          showSelectedIcon: false,
          segments: [
            ButtonSegment(
              value: SubmitShortcut.enter,
              label: Text(context.t.settings.advanced.submitEnter),
            ),
            ButtonSegment(
              value: SubmitShortcut.shiftEnter,
              label: Text(context.t.settings.advanced.submitShiftEnter),
            ),
          ],
          selected: {submitShortcut.value},
          onSelectionChanged: (selection) => submitShortcut.value = selection.single,
        ),
        const SizedBox(height: 24),
        SaveSettingsButton(onPressed: save),
      ],
    );
  }
}

/// The wholesale deletions, one per store — the beta recovery path, since
/// migrations do not exist.
class _DangerZone extends ConsumerWidget {
  const _DangerZone();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    Future<void> deleteDatabase() async {
      if (!await _confirm(context, context.t.settings.advanced.deleteDatabaseConfirm)) {
        return;
      }
      // The result pane must not keep showing a deleted entry.
      ref.read(selectedHistoryEntryProvider.notifier).select(null);
      await ref.read(appDatabaseProvider).close();
      await deleteAppDatabaseFiles();
      // Recreated lazily as a fresh, empty database.
      ref.invalidate(appDatabaseProvider);
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(context.t.settings.advanced.deleted)));
      }
    }

    Future<void> deleteModelSettings() async {
      if (!await _confirm(context, context.t.settings.advanced.deleteModelConfirm)) {
        return;
      }
      await ref.read(llmConfigStorageProvider.notifier).reset();
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(context.t.settings.advanced.deleted)));
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppSectionHeader(title: context.t.settings.advanced.dangerTitle),
        OutlinedButton.icon(
          style: OutlinedButton.styleFrom(foregroundColor: theme.colorScheme.error),
          icon: const Icon(Icons.delete_outline),
          label: Text(context.t.settings.advanced.deleteDatabase),
          onPressed: deleteDatabase,
        ),
        const SizedBox(height: 8),
        OutlinedButton.icon(
          style: OutlinedButton.styleFrom(foregroundColor: theme.colorScheme.error),
          icon: const Icon(Icons.delete_outline),
          label: Text(context.t.settings.advanced.deleteModel),
          onPressed: deleteModelSettings,
        ),
      ],
    );
  }
}

Future<bool> _confirm(BuildContext context, String message) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(context.t.settings.advanced.cancel),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(context.t.history.delete),
        ),
      ],
    ),
  );
  return confirmed ?? false;
}
