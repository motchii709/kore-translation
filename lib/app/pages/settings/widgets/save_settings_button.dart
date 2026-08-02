import 'package:flutter/material.dart';
import 'package:kore_translation/app/i18n/translations.g.dart';

/// Save button shared by the settings forms.
class SaveSettingsButton extends StatelessWidget {
  const SaveSettingsButton({required this.onPressed, super.key});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.save_outlined),
      label: Text(context.t.settings.save),
    );
  }
}
