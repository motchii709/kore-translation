/// Selectable tone identities for the translate page. Pure identifiers: the
/// prompt sentence for each tone lives with the prompt code
/// (`toneInstructionOf` in translation_prompt.dart) and the chip label with
/// the widget that renders it.
enum TonePreset {
  polite,
  casual,
  friendChat,
  genZ,
  internetThread,
  businessEmail,
  customerSupport,
  formFilling,
  socialPost,
  uiLabel,
  academicPaper,
}

/// Translation style choice: natural phrasing or literal fidelity. Pure
/// identifiers: the prompt sentence lives with the prompt builder, the
/// label with the widget.
enum TranslationStyle { natural, literal }

/// Languages offered on the translate page, the first being the default.
///
/// A selection is not a fixed destination: the default template pairs it
/// with the app language (`{{language}}` / `{{app}}`), and which of the two
/// comes out depends on the input text. Names are shown in their own
/// language (the norm for language pickers), so they are locale-invariant
/// data, not translatable UI copy.
const languagePresets = [
  'English',
  '日本語',
  '한국어',
  '中文(简体)',
  'Español',
];
