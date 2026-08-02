# Kore!? (kore_honyaku)

LLM を使った翻訳アプリのテンプレート。[Nani翻訳](https://nani.now) 風の
「翻訳 + 別の言い方 + ニュアンス解説」をバックエンド無しで実現します。
アプリ / CLI から LLM の API (OpenAI 互換 / Anthropic / Google AI) を直接叩きます。

## 構成

pub workspace によるモノレポ構成です。

```
.
├── lib/                     # Flutter アプリ (Android / iOS / Windows / macOS / Linux)
│   └── app/
│       ├── constants/       # 定数 (翻訳先言語プリセットなど)
│       ├── models/          # アプリ内モデル (freezed)
│       ├── pages/           # ページ (translate / settings)
│       ├── providers/       # Riverpod プロバイダ
│       ├── router/          # go_router (typed routes)
│       └── ui/              # テーマ・共通コンポーネント
└── packages/
    ├── kore_client/         # 純 Dart の LLM 翻訳クライアント (Flutter 非依存)
    ├── kore_cli/            # CLI / 対話 TUI
    └── kore_lints/          # 共有 lint 設定 (yumemi_lints ベース)
```

### アーキテクチャ

UI (Flutter / CLI / TUI) は `kore_client` の `Translator` 抽象にのみ依存し、
LLM バックエンドは `TranslatorConfig` で自由に切り替えられます。

```
Translator (抽象)
├── OpenAiTranslator     # OpenAI / Groq / Ollama / LM Studio / OpenRouter ...
├── AnthropicTranslator  # Anthropic Messages API
└── GeminiTranslator     # Google AI generateContent
```

プロンプト構築 (`TranslationPromptBuilder`) と応答パース
(`parseTranslationResponse`) は全バックエンド共通で、各バックエンドは
「1 回の API 呼び出し」だけを実装します (`DioTranslator` のテンプレートメソッド)。

## セットアップ

ツールチェーンは [mise](https://mise.jdx.dev/) で管理しています。

```sh
mise install
flutter pub get
dart run build_runner build                            # アプリのコード生成
(cd packages/kore_client && dart run build_runner build) # クライアントのコード生成
```

> Windows デスクトップで実行する場合は、プラグインの symlink 作成のため
> Windows の開発者モードを有効にしてください (`start ms-settings:developers`)。

## 実行

### アプリ

```sh
flutter run -d windows   # ほか: -d <android-device> / macos / linux
```

設定画面で LLM プロバイダ・API キー (・必要ならベース URL とモデル) を設定します。
API キーは `flutter_secure_storage` で端末にのみ保存されます。

### CLI

```sh
cd packages/kore_cli
set OPENAI_API_KEY=sk-...                # PowerShell: $env:OPENAI_API_KEY = 'sk-...'
dart run bin/kore.dart "こんにちは" --to English
dart run bin/kore.dart -i                # 対話 (TUI) モード
dart run bin/kore.dart -p anthropic "Hello" -t 日本語
```

環境変数: `KORE_PROVIDER` (openai / anthropic / google), `KORE_BASE_URL`,
`KORE_MODEL`, `KORE_API_KEY` (プロバイダ標準の `OPENAI_API_KEY` /
`ANTHROPIC_API_KEY` / `GEMINI_API_KEY` も利用可)。

## 開発

```sh
flutter analyze                          # 静的解析 (yumemi_lints)
flutter test                             # アプリのウィジェットテスト
(cd packages/kore_client && dart test)   # クライアントのユニットテスト
```

コード生成 (freezed / riverpod_generator / go_router_builder / json_serializable)
を変更した場合は `build_runner` を再実行してください。
