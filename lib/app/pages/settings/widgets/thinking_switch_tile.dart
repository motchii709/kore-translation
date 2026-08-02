import 'package:flutter/material.dart';
import 'package:kore_translation/app/i18n/translations.g.dart';

/// Thinking toggle, shown only by the config sections whose backend can
/// control reasoning (their config variant carries a `thinking` field).
class ThinkingSwitchTile extends StatelessWidget {
  const ThinkingSwitchTile({required this.value, required this.onChanged, super.key});

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(context.t.settings.api.thinking),
      subtitle: Text(context.t.settings.api.thinkingSubtitle),
      value: value,
      onChanged: onChanged,
    );
  }
}
