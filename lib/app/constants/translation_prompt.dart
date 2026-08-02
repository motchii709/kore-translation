import 'package:kore_client/kore_client.dart';
import 'package:kore_translation/app/constants/translation_presets.dart';
import 'package:kore_translation/app/i18n/translations.g.dart';

/// Default system prompt template. Locale-independent: the response-format
/// and meta-language instructions are appended per request by
/// [buildTranslationSystemPrompt]. Users can replace it in the settings;
/// `{{target}}` and `{{tone}}` are substituted on every request.
const defaultTranslationPromptTemplate = '''
You are a professional translator. Translate the user's text into {{target}}.
{{tone}}''';

/// Composes the final system prompt: the user-adjustable instruction with
/// its placeholders filled in, the meta-language instruction, and the
/// response schema kore_client's parsers rely on.
///
/// The meta fields (detected_language, target_language, nuance,
/// explanation) follow [appLanguage] at request time — never seeded into
/// the stored template, where they would go stale when the app language
/// changes.
String buildTranslationSystemPrompt({
  required String template,
  required String targetLanguage,
  required String toneInstruction,
  required String appLanguage,
}) {
  final instruction = template.replaceAll('{{target}}', targetLanguage).replaceAll('{{tone}}', toneInstruction);
  return '$instruction\n'
      'Write detected_language, target_language, nuance and explanation in $appLanguage.\n'
      '$translationSchemaPrompt';
}

/// The style instruction joined into the `{{tone}}` block.
String styleInstructionOf(TranslationStyle style) => switch (style) {
  TranslationStyle.natural => 'Translate naturally and idiomatically.',
  TranslationStyle.literal => "Translate literally, staying close to the source text's wording and structure.",
};

/// The prompt-side name of the app language for [locale] — the language the
/// pairing in [targetInstructionOf] falls back to.
String appLanguageNameOf(AppLocale locale) => switch (locale) {
  AppLocale.ja => '日本語',
  AppLocale.en => 'English',
};

/// The `{{target}}` substitution: text written in the app's language goes
/// into the selected language, anything else comes back into the app's
/// language. The model already detects the input language, so the pairing
/// is expressed as an instruction instead of client-side detection.
String targetInstructionOf({required String selected, required String appLanguage}) =>
    selected == appLanguage ? appLanguage : '$selected if the text is in $appLanguage, otherwise $appLanguage';

/// The prompt sentence substituted for [tone]. Prompt knowledge, kept next
/// to the prompt builder rather than the UI that lists the tones.
String toneInstructionOf(TonePreset tone) => switch (tone) {
  TonePreset.polite => 'Use polite, courteous language.',
  TonePreset.casual => 'Use a casual, friendly tone.',
  TonePreset.friendChat => 'Write like a chat message to a close friend.',
  TonePreset.genZ => 'Use Gen-Z slang and vibes.',
  TonePreset.internetThread => 'Write like an anonymous internet forum post.',
  TonePreset.businessEmail => 'Write like a professional business email.',
  TonePreset.customerSupport => 'Write like a courteous customer support reply.',
  TonePreset.formFilling => 'Use formal wording suitable for official documents and forms.',
  TonePreset.socialPost => 'Write like a short social media post.',
  TonePreset.uiLabel => 'Write like a concise UI label.',
  TonePreset.academicPaper => 'Use formal academic writing style.',
};
