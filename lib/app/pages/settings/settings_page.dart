import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kore_honyaku/app/pages/settings/widgets/settings_form.dart';
import 'package:kore_honyaku/app/providers/app_settings_provider.dart';
import 'package:kore_honyaku/app/ui/layout/app_breakpoints.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(appSettingsStorageProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('設定')),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: AppBreakpoints.maxFormWidth),
            child: switch (settings) {
              AsyncData(:final value) => SettingsForm(initialSettings: value),
              AsyncError(:final error) => Center(child: Text('設定を読み込めませんでした: $error')),
              _ => const Center(child: CircularProgressIndicator()),
            },
          ),
        ),
      ),
    );
  }
}
