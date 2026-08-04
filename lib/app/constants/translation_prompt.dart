import 'package:kore_client/kore_client.dart';
import 'package:kore_translation/app/constants/translation_presets.dart';
import 'package:kore_translation/app/i18n/translations.g.dart';

/// Default system prompt template — the WHOLE prompt, nothing is appended
/// behind the user's back. `{{language}}` (the selected language), `{{app}}`
/// (the app language) and `{{tone}}` are substituted on every request.
///
/// Everything is deliberately visible and editable, including the language
/// pairing (text in the app language goes into the selected language,
/// anything else comes back into the app language), the meta-field language
/// and kore_client's response-format instruction. Editing the format part
/// can break parsing — that is the user's call, and failures surface raw.
const defaultTranslationPromptTemplate = '''
You are a professional translator. Translate the user's text into {{language}} if the text is in {{app}}, otherwise {{app}}.
{{tone}}
Write detected_language, target_language, nuance and explanation in {{app}}.
$translationSchemaPrompt''';

/// Default system prompt template for the proofread action: corrects the
/// text in its own language instead of translating it. Same contract as the
/// translation template — the WHOLE prompt, user-editable, with `{{app}}`
/// and `{{tone}}` substituted on every request (no `{{language}}`: the text
/// stays in its own language). Its response format, [proofreadSchemaPrompt],
/// keeps the translation schema's parsed keys minus the language pair, so
/// the result flows through the same stream, storage and result pane — the
/// corrected text rides in the `translation` field.
const defaultProofreadingPromptTemplate = '''
You are a professional proofreader. Correct the user's text in its original language: fix grammar, spelling and unnatural phrasing while preserving the meaning.
{{tone}}
Write proofread and nuance in {{app}}.
$proofreadSchemaPrompt''';

/// Fills the proofreading template's placeholders. The template is the
/// whole prompt, so nothing else is composed here.
String buildProofreadingSystemPrompt({
  required String template,
  required String appLanguage,
  required String toneInstruction,
}) => template.replaceAll('{{app}}', appLanguage).replaceAll('{{tone}}', toneInstruction);

/// Fills the template's placeholders. The template is the whole prompt, so
/// nothing else is composed here.
String buildTranslationSystemPrompt({
  required String template,
  required String language,
  required String appLanguage,
  required String toneInstruction,
}) => template
    .replaceAll('{{language}}', language)
    .replaceAll('{{app}}', appLanguage)
    .replaceAll('{{tone}}', toneInstruction);

/// The style instruction joined into the `{{tone}}` block.
String styleInstructionOf(TranslationStyle style) => switch (style) {
  TranslationStyle.natural => 'Translate naturally and idiomatically.',
  TranslationStyle.literal => "Translate literally, staying close to the source text's wording and structure.",
};

/// The prompt-side name of the app language for [locale] — the `{{app}}`
/// substitution and the language of the meta fields.
String appLanguageNameOf(AppLocale locale) => switch (locale) {
  AppLocale.ja => '日本語',
  AppLocale.en => 'English',
};

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
