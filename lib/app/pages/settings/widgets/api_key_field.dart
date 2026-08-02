import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kore_translation/app/i18n/translations.g.dart';

/// Obscured API-key input with a visibility toggle. Shared presentation atom
/// for the provider config sections; each section decides for itself whether
/// an API key exists at all.
class ApiKeyField extends HookWidget {
  const ApiKeyField({required this.controller, this.helperText, super.key});

  final TextEditingController controller;
  final String? helperText;

  @override
  Widget build(BuildContext context) {
    final obscure = useState(true);
    return TextField(
      controller: controller,
      obscureText: obscure.value,
      decoration: InputDecoration(
        labelText: context.t.settings.api.apiKey,
        helperText: helperText,
        suffixIcon: IconButton(
          tooltip: obscure.value ? context.t.settings.api.showApiKey : context.t.settings.api.hideApiKey,
          icon: Icon(obscure.value ? Icons.visibility_outlined : Icons.visibility_off_outlined),
          onPressed: () => obscure.value = !obscure.value,
        ),
      ),
    );
  }
}
