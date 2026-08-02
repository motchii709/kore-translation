///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'translations.g.dart';

// Path: <root>
typedef TranslationsJa = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.ja,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <ja>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	late final Translations$translate$ja translate = Translations$translate$ja.internal(_root);
	late final Translations$history$ja history = Translations$history$ja.internal(_root);
	late final Translations$tone$ja tone = Translations$tone$ja.internal(_root);
	late final Translations$settings$ja settings = Translations$settings$ja.internal(_root);
}

// Path: translate
class Translations$translate$ja {
	Translations$translate$ja.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: '設定'
	String get settingsTooltip => '設定';

	/// ja: '原文'
	String get sourceText => '原文';

	/// ja: '翻訳したいテキストを入力'
	String get inputHint => '翻訳したいテキストを入力';

	/// ja: '言語'
	String get language => '言語';

	late final Translations$translate$style$ja style = Translations$translate$style$ja.internal(_root);

	/// ja: 'トーン (複数選択可)'
	String get tones => 'トーン (複数選択可)';

	/// ja: '翻訳する'
	String get action => '翻訳する';

	/// ja: '翻訳中...'
	String get inProgress => '翻訳中...';

	late final Translations$translate$result$ja result = Translations$translate$result$ja.internal(_root);
}

// Path: history
class Translations$history$ja {
	Translations$history$ja.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: '履歴'
	String get title => '履歴';

	/// ja: '履歴はまだありません'
	String get empty => '履歴はまだありません';

	/// ja: '削除'
	String get delete => '削除';

	/// ja: '履歴を読み込めませんでした: $error'
	String loadFailed({required Object error}) => '履歴を読み込めませんでした: ${error}';
}

// Path: tone
class Translations$tone$ja {
	Translations$tone$ja.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: '🥸 丁寧'
	String get polite => '🥸 丁寧';

	/// ja: '😎 カジュアル'
	String get casual => '😎 カジュアル';

	/// ja: '💬 友達とチャット'
	String get friendChat => '💬 友達とチャット';

	/// ja: '🧢 Z世代'
	String get genZ => '🧢 Z世代';

	/// ja: '🧵 ネットスレ'
	String get internetThread => '🧵 ネットスレ';

	/// ja: '📧 仕事メール'
	String get businessEmail => '📧 仕事メール';

	/// ja: '📨 顧客対応'
	String get customerSupport => '📨 顧客対応';

	/// ja: '📝 書類の記入'
	String get formFilling => '📝 書類の記入';

	/// ja: '🫠 SNSつぶやき'
	String get socialPost => '🫠 SNSつぶやき';

	/// ja: '📱 UIラベル'
	String get uiLabel => '📱 UIラベル';

	/// ja: '🎓 論文'
	String get academicPaper => '🎓 論文';
}

// Path: settings
class Translations$settings$ja {
	Translations$settings$ja.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: 'モデル設定'
	String get model => 'モデル設定';

	/// ja: '設定を読み込めませんでした: $error'
	String loadFailed({required Object error}) => '設定を読み込めませんでした: ${error}';

	/// ja: 'LLMプロバイダ'
	String get provider => 'LLMプロバイダ';

	late final Translations$settings$providers$ja providers = Translations$settings$providers$ja.internal(_root);
	late final Translations$settings$api$ja api = Translations$settings$api$ja.internal(_root);
	late final Translations$settings$openAiCompatible$ja openAiCompatible = Translations$settings$openAiCompatible$ja.internal(_root);
	late final Translations$settings$acp$ja acp = Translations$settings$acp$ja.internal(_root);
	late final Translations$settings$codex$ja codex = Translations$settings$codex$ja.internal(_root);

	/// ja: '保存'
	String get save => '保存';

	/// ja: '設定を保存しました'
	String get saved => '設定を保存しました';

	late final Translations$settings$advanced$ja advanced = Translations$settings$advanced$ja.internal(_root);
}

// Path: translate.style
class Translations$translate$style$ja {
	Translations$translate$style$ja.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: '翻訳スタイル'
	String get title => '翻訳スタイル';

	/// ja: '自然'
	String get natural => '自然';

	/// ja: '直訳'
	String get literal => '直訳';
}

// Path: translate.result
class Translations$translate$result$ja {
	Translations$translate$result$ja.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: '翻訳結果がここに表示されます'
	String get placeholder => '翻訳結果がここに表示されます';

	/// ja: '思考'
	String get thinking => '思考';

	/// ja: '翻訳結果'
	String get title => '翻訳結果';

	/// ja: '検出言語: $language'
	String detectedLanguage({required Object language}) => '検出言語: ${language}';

	/// ja: '$source → $target'
	String languagePair({required Object source, required Object target}) => '${source} → ${target}';

	/// ja: 'コピー'
	String get copy => 'コピー';

	/// ja: 'コピーしました'
	String get copied => 'コピーしました';

	/// ja: '別の言い方'
	String get alternatives => '別の言い方';

	/// ja: '解説'
	String get explanation => '解説';

	/// ja: '翻訳に失敗しました'
	String get failed => '翻訳に失敗しました';

	/// ja: 'エラーをコピー'
	String get copyError => 'エラーをコピー';
}

// Path: settings.providers
class Translations$settings$providers$ja {
	Translations$settings$providers$ja.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: 'OpenAI'
	String get openAi => 'OpenAI';

	/// ja: 'OpenAI互換'
	String get openAiCompatible => 'OpenAI互換';

	/// ja: 'Anthropic'
	String get anthropic => 'Anthropic';

	/// ja: 'Google AI'
	String get google => 'Google AI';

	/// ja: 'DeepSeek'
	String get deepSeek => 'DeepSeek';

	/// ja: 'ACPエージェント'
	String get acp => 'ACPエージェント';

	/// ja: 'Codex'
	String get codex => 'Codex';
}

// Path: settings.api
class Translations$settings$api$ja {
	Translations$settings$api$ja.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: 'ベースURL'
	String get baseUrl => 'ベースURL';

	/// ja: 'APIキー'
	String get apiKey => 'APIキー';

	/// ja: '表示'
	String get showApiKey => '表示';

	/// ja: '隠す'
	String get hideApiKey => '隠す';

	/// ja: 'モデル'
	String get model => 'モデル';

	/// ja: '思考 (thinking)'
	String get thinking => '思考 (thinking)';

	/// ja: 'モデルの思考を有効にし、ストリーミング表示します'
	String get thinkingSubtitle => 'モデルの思考を有効にし、ストリーミング表示します';

	/// ja: 'システムプロンプト'
	String get systemPrompt => 'システムプロンプト';

	/// ja: '{{language}} (選択言語)・{{app}} (アプリの言語)・{{tone}} が翻訳時に置換されます。 これがプロンプト全体です。応答フォーマット指示を変えるとパースが壊れることがあります'
	String get systemPromptHelper => '{{language}} (選択言語)・{{app}} (アプリの言語)・{{tone}} が翻訳時に置換されます。\nこれがプロンプト全体です。応答フォーマット指示を変えるとパースが壊れることがあります';
}

// Path: settings.openAiCompatible
class Translations$settings$openAiCompatible$ja {
	Translations$settings$openAiCompatible$ja.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: '必須'
	String get requiredMark => '必須';

	/// ja: 'ローカルサーバの場合は空欄可'
	String get apiKeyHelper => 'ローカルサーバの場合は空欄可';
}

// Path: settings.acp
class Translations$settings$acp$ja {
	Translations$settings$acp$ja.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: 'ACPコマンド'
	String get command => 'ACPコマンド';

	/// ja: '必須。ACPエージェントを起動するコマンドです。 認証とモデルはエージェント側の設定に従います'
	String get commandHelper => '必須。ACPエージェントを起動するコマンドです。\n認証とモデルはエージェント側の設定に従います';

	/// ja: 'ACPにはシステムプロンプト枠がないため、翻訳テキストの先頭に付加されます'
	String get promptNote => 'ACPにはシステムプロンプト枠がないため、翻訳テキストの先頭に付加されます';
}

// Path: settings.codex
class Translations$settings$codex$ja {
	Translations$settings$codex$ja.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: 'Codexコマンド'
	String get command => 'Codexコマンド';

	/// ja: '認証は codex login に従います'
	String get commandHelper => '認証は codex login に従います';

	/// ja: '指定すると Codex の既定モデルを上書きします'
	String get modelHelper => '指定すると Codex の既定モデルを上書きします';

	/// ja: 'Codexの既定指示 (コーディング用) を置き換えます'
	String get promptNote => 'Codexの既定指示 (コーディング用) を置き換えます';
}

// Path: settings.advanced
class Translations$settings$advanced$ja {
	Translations$settings$advanced$ja.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: '詳細設定'
	String get title => '詳細設定';

	/// ja: '言語'
	String get language => '言語';

	/// ja: 'システム'
	String get languageSystem => 'システム';

	/// ja: 'テーマ'
	String get theme => 'テーマ';

	/// ja: 'システム'
	String get themeSystem => 'システム';

	/// ja: 'ライト'
	String get themeLight => 'ライト';

	/// ja: 'ダーク'
	String get themeDark => 'ダーク';

	/// ja: '送信ショートカット'
	String get submit => '送信ショートカット';

	/// ja: 'Enterで送信'
	String get submitEnter => 'Enterで送信';

	/// ja: 'Shift+Enterで送信'
	String get submitShiftEnter => 'Shift+Enterで送信';

	/// ja: 'データ削除'
	String get dangerTitle => 'データ削除';

	/// ja: '削除'
	String get delete => '削除';

	/// ja: 'データベースを削除'
	String get deleteDatabase => 'データベースを削除';

	/// ja: 'データベース (履歴と詳細設定) をすべて削除します。よろしいですか？'
	String get deleteDatabaseConfirm => 'データベース (履歴と詳細設定) をすべて削除します。よろしいですか？';

	/// ja: 'モデル設定を削除'
	String get deleteModel => 'モデル設定を削除';

	/// ja: 'モデル設定 (APIキーを含む) を削除します。よろしいですか？'
	String get deleteModelConfirm => 'モデル設定 (APIキーを含む) を削除します。よろしいですか？';

	/// ja: '削除しました'
	String get deleted => '削除しました';

	/// ja: 'キャンセル'
	String get cancel => 'キャンセル';
}

/// The flat map containing all translations for locale <ja>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'translate.settingsTooltip' => '設定',
			'translate.sourceText' => '原文',
			'translate.inputHint' => '翻訳したいテキストを入力',
			'translate.language' => '言語',
			'translate.style.title' => '翻訳スタイル',
			'translate.style.natural' => '自然',
			'translate.style.literal' => '直訳',
			'translate.tones' => 'トーン (複数選択可)',
			'translate.action' => '翻訳する',
			'translate.inProgress' => '翻訳中...',
			'translate.result.placeholder' => '翻訳結果がここに表示されます',
			'translate.result.thinking' => '思考',
			'translate.result.title' => '翻訳結果',
			'translate.result.detectedLanguage' => ({required Object language}) => '検出言語: ${language}',
			'translate.result.languagePair' => ({required Object source, required Object target}) => '${source} → ${target}',
			'translate.result.copy' => 'コピー',
			'translate.result.copied' => 'コピーしました',
			'translate.result.alternatives' => '別の言い方',
			'translate.result.explanation' => '解説',
			'translate.result.failed' => '翻訳に失敗しました',
			'translate.result.copyError' => 'エラーをコピー',
			'history.title' => '履歴',
			'history.empty' => '履歴はまだありません',
			'history.delete' => '削除',
			'history.loadFailed' => ({required Object error}) => '履歴を読み込めませんでした: ${error}',
			'tone.polite' => '🥸 丁寧',
			'tone.casual' => '😎 カジュアル',
			'tone.friendChat' => '💬 友達とチャット',
			'tone.genZ' => '🧢 Z世代',
			'tone.internetThread' => '🧵 ネットスレ',
			'tone.businessEmail' => '📧 仕事メール',
			'tone.customerSupport' => '📨 顧客対応',
			'tone.formFilling' => '📝 書類の記入',
			'tone.socialPost' => '🫠 SNSつぶやき',
			'tone.uiLabel' => '📱 UIラベル',
			'tone.academicPaper' => '🎓 論文',
			'settings.model' => 'モデル設定',
			'settings.loadFailed' => ({required Object error}) => '設定を読み込めませんでした: ${error}',
			'settings.provider' => 'LLMプロバイダ',
			'settings.providers.openAi' => 'OpenAI',
			'settings.providers.openAiCompatible' => 'OpenAI互換',
			'settings.providers.anthropic' => 'Anthropic',
			'settings.providers.google' => 'Google AI',
			'settings.providers.deepSeek' => 'DeepSeek',
			'settings.providers.acp' => 'ACPエージェント',
			'settings.providers.codex' => 'Codex',
			'settings.api.baseUrl' => 'ベースURL',
			'settings.api.apiKey' => 'APIキー',
			'settings.api.showApiKey' => '表示',
			'settings.api.hideApiKey' => '隠す',
			'settings.api.model' => 'モデル',
			'settings.api.thinking' => '思考 (thinking)',
			'settings.api.thinkingSubtitle' => 'モデルの思考を有効にし、ストリーミング表示します',
			'settings.api.systemPrompt' => 'システムプロンプト',
			'settings.api.systemPromptHelper' => '{{language}} (選択言語)・{{app}} (アプリの言語)・{{tone}} が翻訳時に置換されます。\nこれがプロンプト全体です。応答フォーマット指示を変えるとパースが壊れることがあります',
			'settings.openAiCompatible.requiredMark' => '必須',
			'settings.openAiCompatible.apiKeyHelper' => 'ローカルサーバの場合は空欄可',
			'settings.acp.command' => 'ACPコマンド',
			'settings.acp.commandHelper' => '必須。ACPエージェントを起動するコマンドです。\n認証とモデルはエージェント側の設定に従います',
			'settings.acp.promptNote' => 'ACPにはシステムプロンプト枠がないため、翻訳テキストの先頭に付加されます',
			'settings.codex.command' => 'Codexコマンド',
			'settings.codex.commandHelper' => '認証は codex login に従います',
			'settings.codex.modelHelper' => '指定すると Codex の既定モデルを上書きします',
			'settings.codex.promptNote' => 'Codexの既定指示 (コーディング用) を置き換えます',
			'settings.save' => '保存',
			'settings.saved' => '設定を保存しました',
			'settings.advanced.title' => '詳細設定',
			'settings.advanced.language' => '言語',
			'settings.advanced.languageSystem' => 'システム',
			'settings.advanced.theme' => 'テーマ',
			'settings.advanced.themeSystem' => 'システム',
			'settings.advanced.themeLight' => 'ライト',
			'settings.advanced.themeDark' => 'ダーク',
			'settings.advanced.submit' => '送信ショートカット',
			'settings.advanced.submitEnter' => 'Enterで送信',
			'settings.advanced.submitShiftEnter' => 'Shift+Enterで送信',
			'settings.advanced.dangerTitle' => 'データ削除',
			'settings.advanced.delete' => '削除',
			'settings.advanced.deleteDatabase' => 'データベースを削除',
			'settings.advanced.deleteDatabaseConfirm' => 'データベース (履歴と詳細設定) をすべて削除します。よろしいですか？',
			'settings.advanced.deleteModel' => 'モデル設定を削除',
			'settings.advanced.deleteModelConfirm' => 'モデル設定 (APIキーを含む) を削除します。よろしいですか？',
			'settings.advanced.deleted' => '削除しました',
			'settings.advanced.cancel' => 'キャンセル',
			_ => null,
		};
	}
}
