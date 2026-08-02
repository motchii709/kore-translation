///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'translations.g.dart';

// Path: <root>
class TranslationsEn extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsEn({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	late final TranslationsEn _root = this; // ignore: unused_field

	@override 
	TranslationsEn $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsEn(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$translate$en translate = _Translations$translate$en._(_root);
	@override late final _Translations$history$en history = _Translations$history$en._(_root);
	@override late final _Translations$tone$en tone = _Translations$tone$en._(_root);
	@override late final _Translations$settings$en settings = _Translations$settings$en._(_root);
}

// Path: translate
class _Translations$translate$en extends Translations$translate$ja {
	_Translations$translate$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get settingsTooltip => 'Settings';
	@override String get sourceText => 'Source text';
	@override String get inputHint => 'Enter text to translate';
	@override String get language => 'Language';
	@override late final _Translations$translate$style$en style = _Translations$translate$style$en._(_root);
	@override String get tones => 'Tone (multi-select)';
	@override String get action => 'Translate';
	@override String get inProgress => 'Translating...';
	@override late final _Translations$translate$result$en result = _Translations$translate$result$en._(_root);
}

// Path: history
class _Translations$history$en extends Translations$history$ja {
	_Translations$history$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'History';
	@override String get empty => 'No history yet';
	@override String get delete => 'Delete';
	@override String loadFailed({required Object error}) => 'Failed to load history: ${error}';
}

// Path: tone
class _Translations$tone$en extends Translations$tone$ja {
	_Translations$tone$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get polite => '🥸 Polite';
	@override String get casual => '😎 Casual';
	@override String get friendChat => '💬 Chat with a friend';
	@override String get genZ => '🧢 Gen Z';
	@override String get internetThread => '🧵 Internet thread';
	@override String get businessEmail => '📧 Business email';
	@override String get customerSupport => '📨 Customer support';
	@override String get formFilling => '📝 Official forms';
	@override String get socialPost => '🫠 Social media post';
	@override String get uiLabel => '📱 UI label';
	@override String get academicPaper => '🎓 Academic paper';
}

// Path: settings
class _Translations$settings$en extends Translations$settings$ja {
	_Translations$settings$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get model => 'Model settings';
	@override String loadFailed({required Object error}) => 'Failed to load settings: ${error}';
	@override String get provider => 'LLM provider';
	@override late final _Translations$settings$providers$en providers = _Translations$settings$providers$en._(_root);
	@override late final _Translations$settings$api$en api = _Translations$settings$api$en._(_root);
	@override late final _Translations$settings$openAiCompatible$en openAiCompatible = _Translations$settings$openAiCompatible$en._(_root);
	@override late final _Translations$settings$acp$en acp = _Translations$settings$acp$en._(_root);
	@override late final _Translations$settings$codex$en codex = _Translations$settings$codex$en._(_root);
	@override String get save => 'Save';
	@override String get saved => 'Settings saved';
	@override late final _Translations$settings$advanced$en advanced = _Translations$settings$advanced$en._(_root);
}

// Path: translate.style
class _Translations$translate$style$en extends Translations$translate$style$ja {
	_Translations$translate$style$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Style';
	@override String get natural => 'Natural';
	@override String get literal => 'Literal';
}

// Path: translate.result
class _Translations$translate$result$en extends Translations$translate$result$ja {
	_Translations$translate$result$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get placeholder => 'The translation will appear here';
	@override String get thinking => 'Thinking';
	@override String get title => 'Translation';
	@override String detectedLanguage({required Object language}) => 'Detected language: ${language}';
	@override String languagePair({required Object source, required Object target}) => '${source} → ${target}';
	@override String get copy => 'Copy';
	@override String get copied => 'Copied';
	@override String get alternatives => 'Alternatives';
	@override String get explanation => 'Notes';
	@override String get failed => 'Translation failed';
	@override String get copyError => 'Copy error details';
}

// Path: settings.providers
class _Translations$settings$providers$en extends Translations$settings$providers$ja {
	_Translations$settings$providers$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get openAi => 'OpenAI';
	@override String get openAiCompatible => 'OpenAI-compatible';
	@override String get anthropic => 'Anthropic';
	@override String get google => 'Google AI';
	@override String get deepSeek => 'DeepSeek';
	@override String get acp => 'ACP agent';
	@override String get codex => 'Codex';
}

// Path: settings.api
class _Translations$settings$api$en extends Translations$settings$api$ja {
	_Translations$settings$api$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get baseUrl => 'Base URL';
	@override String get apiKey => 'API key';
	@override String get showApiKey => 'Show';
	@override String get hideApiKey => 'Hide';
	@override String get model => 'Model';
	@override String get thinking => 'Thinking';
	@override String get thinkingSubtitle => 'Enable the model\'s thinking and stream it live';
	@override String get systemPrompt => 'System prompt';
	@override String get systemPromptHelper => '{{language}} (selected), {{app}} (app language) and {{tone}} are substituted at translation time.\nThis is the entire prompt — changing the response-format part can break parsing';
}

// Path: settings.openAiCompatible
class _Translations$settings$openAiCompatible$en extends Translations$settings$openAiCompatible$ja {
	_Translations$settings$openAiCompatible$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get requiredMark => 'Required';
	@override String get apiKeyHelper => 'Optional for local servers';
}

// Path: settings.acp
class _Translations$settings$acp$en extends Translations$settings$acp$ja {
	_Translations$settings$acp$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get command => 'ACP command';
	@override String get commandHelper => 'Required. The command that starts the ACP agent.\nCredentials and model follow the agent\'s own configuration';
	@override String get promptNote => 'ACP has no system-prompt slot, so this is prepended to the text being translated';
}

// Path: settings.codex
class _Translations$settings$codex$en extends Translations$settings$codex$ja {
	_Translations$settings$codex$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get command => 'Codex command';
	@override String get commandHelper => 'Authentication follows codex login';
	@override String get modelHelper => 'Overrides Codex\'s default model when set';
	@override String get promptNote => 'Replaces Codex\'s base (coding) instructions';
}

// Path: settings.advanced
class _Translations$settings$advanced$en extends Translations$settings$advanced$ja {
	_Translations$settings$advanced$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Advanced';
	@override String get language => 'Language';
	@override String get languageSystem => 'System';
	@override String get theme => 'Theme';
	@override String get themeSystem => 'System';
	@override String get themeLight => 'Light';
	@override String get themeDark => 'Dark';
	@override String get submit => 'Send shortcut';
	@override String get submitEnter => 'Enter to send';
	@override String get submitShiftEnter => 'Shift+Enter to send';
	@override String get dangerTitle => 'Delete data';
	@override String get delete => 'Delete';
	@override String get deleteDatabase => 'Delete the database';
	@override String get deleteDatabaseConfirm => 'Delete the entire database (history and advanced settings)?';
	@override String get deleteModel => 'Delete model settings';
	@override String get deleteModelConfirm => 'Delete the model settings (including the API key)?';
	@override String get deleted => 'Deleted';
	@override String get cancel => 'Cancel';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsEn {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'translate.settingsTooltip' => 'Settings',
			'translate.sourceText' => 'Source text',
			'translate.inputHint' => 'Enter text to translate',
			'translate.language' => 'Language',
			'translate.style.title' => 'Style',
			'translate.style.natural' => 'Natural',
			'translate.style.literal' => 'Literal',
			'translate.tones' => 'Tone (multi-select)',
			'translate.action' => 'Translate',
			'translate.inProgress' => 'Translating...',
			'translate.result.placeholder' => 'The translation will appear here',
			'translate.result.thinking' => 'Thinking',
			'translate.result.title' => 'Translation',
			'translate.result.detectedLanguage' => ({required Object language}) => 'Detected language: ${language}',
			'translate.result.languagePair' => ({required Object source, required Object target}) => '${source} → ${target}',
			'translate.result.copy' => 'Copy',
			'translate.result.copied' => 'Copied',
			'translate.result.alternatives' => 'Alternatives',
			'translate.result.explanation' => 'Notes',
			'translate.result.failed' => 'Translation failed',
			'translate.result.copyError' => 'Copy error details',
			'history.title' => 'History',
			'history.empty' => 'No history yet',
			'history.delete' => 'Delete',
			'history.loadFailed' => ({required Object error}) => 'Failed to load history: ${error}',
			'tone.polite' => '🥸 Polite',
			'tone.casual' => '😎 Casual',
			'tone.friendChat' => '💬 Chat with a friend',
			'tone.genZ' => '🧢 Gen Z',
			'tone.internetThread' => '🧵 Internet thread',
			'tone.businessEmail' => '📧 Business email',
			'tone.customerSupport' => '📨 Customer support',
			'tone.formFilling' => '📝 Official forms',
			'tone.socialPost' => '🫠 Social media post',
			'tone.uiLabel' => '📱 UI label',
			'tone.academicPaper' => '🎓 Academic paper',
			'settings.model' => 'Model settings',
			'settings.loadFailed' => ({required Object error}) => 'Failed to load settings: ${error}',
			'settings.provider' => 'LLM provider',
			'settings.providers.openAi' => 'OpenAI',
			'settings.providers.openAiCompatible' => 'OpenAI-compatible',
			'settings.providers.anthropic' => 'Anthropic',
			'settings.providers.google' => 'Google AI',
			'settings.providers.deepSeek' => 'DeepSeek',
			'settings.providers.acp' => 'ACP agent',
			'settings.providers.codex' => 'Codex',
			'settings.api.baseUrl' => 'Base URL',
			'settings.api.apiKey' => 'API key',
			'settings.api.showApiKey' => 'Show',
			'settings.api.hideApiKey' => 'Hide',
			'settings.api.model' => 'Model',
			'settings.api.thinking' => 'Thinking',
			'settings.api.thinkingSubtitle' => 'Enable the model\'s thinking and stream it live',
			'settings.api.systemPrompt' => 'System prompt',
			'settings.api.systemPromptHelper' => '{{language}} (selected), {{app}} (app language) and {{tone}} are substituted at translation time.\nThis is the entire prompt — changing the response-format part can break parsing',
			'settings.openAiCompatible.requiredMark' => 'Required',
			'settings.openAiCompatible.apiKeyHelper' => 'Optional for local servers',
			'settings.acp.command' => 'ACP command',
			'settings.acp.commandHelper' => 'Required. The command that starts the ACP agent.\nCredentials and model follow the agent\'s own configuration',
			'settings.acp.promptNote' => 'ACP has no system-prompt slot, so this is prepended to the text being translated',
			'settings.codex.command' => 'Codex command',
			'settings.codex.commandHelper' => 'Authentication follows codex login',
			'settings.codex.modelHelper' => 'Overrides Codex\'s default model when set',
			'settings.codex.promptNote' => 'Replaces Codex\'s base (coding) instructions',
			'settings.save' => 'Save',
			'settings.saved' => 'Settings saved',
			'settings.advanced.title' => 'Advanced',
			'settings.advanced.language' => 'Language',
			'settings.advanced.languageSystem' => 'System',
			'settings.advanced.theme' => 'Theme',
			'settings.advanced.themeSystem' => 'System',
			'settings.advanced.themeLight' => 'Light',
			'settings.advanced.themeDark' => 'Dark',
			'settings.advanced.submit' => 'Send shortcut',
			'settings.advanced.submitEnter' => 'Enter to send',
			'settings.advanced.submitShiftEnter' => 'Shift+Enter to send',
			'settings.advanced.dangerTitle' => 'Delete data',
			'settings.advanced.delete' => 'Delete',
			'settings.advanced.deleteDatabase' => 'Delete the database',
			'settings.advanced.deleteDatabaseConfirm' => 'Delete the entire database (history and advanced settings)?',
			'settings.advanced.deleteModel' => 'Delete model settings',
			'settings.advanced.deleteModelConfirm' => 'Delete the model settings (including the API key)?',
			'settings.advanced.deleted' => 'Deleted',
			'settings.advanced.cancel' => 'Cancel',
			_ => null,
		};
	}
}
