/// A selectable tone: UI label plus the instruction sentence substituted
/// into the prompt template.
typedef TonePreset = ({String label, String instruction});

/// Preset choices shown on the translate page. Both the target language and
/// the tones end up as plain prompt text, so these are UI conveniences, not
/// an exhaustive list of what the backend supports.
abstract final class TranslationPresets {
  static const targetLanguages = [
    'English',
    '日本語',
    '한국어',
    '中文(简体)',
    'Español',
  ];

  /// Tones are multi-selectable; the selected instructions are joined into
  /// the prompt. Selecting none leaves the tone up to the model.
  static const List<TonePreset> tones = [
    (label: '🥸 丁寧', instruction: 'Use polite, courteous language.'),
    (label: '😎 カジュアル', instruction: 'Use a casual, friendly tone.'),
    (label: '💬 友達とチャット', instruction: 'Write like a chat message to a close friend.'),
    (label: '🧢 Z世代', instruction: 'Use Gen-Z slang and vibes.'),
    (label: '🧵 ネットスレ', instruction: 'Write like an anonymous internet forum post.'),
    (label: '📧 仕事メール', instruction: 'Write like a professional business email.'),
    (label: '📨 顧客対応', instruction: 'Write like a courteous customer support reply.'),
    (label: '📝 書類の記入', instruction: 'Use formal wording suitable for official documents and forms.'),
    (label: '🫠 SNSつぶやき', instruction: 'Write like a short social media post.'),
    (label: '📱 UIラベル', instruction: 'Write like a concise UI label.'),
    (label: '🎓 論文', instruction: 'Use formal academic writing style.'),
  ];
}
