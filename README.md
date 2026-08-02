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

`kore_client` は 2 層構成です。継承階層は持たず、共有処理は関数合成で行います。

```
TranslationClient (抽象)                  # UI (Flutter / CLI / TUI) が依存する唯一の抽象
├── OpenAiTranslationClient               # 各社オブジェクト → thinking/text デルタ抽出
├── AnthropicTranslationClient            #   + assembleTranslationEvents (共通組み立て)
└── GeminiTranslationClient               #   → TranslationEvent {thinking, result}

LlmClient 群 (抽象なし・各社独立の薄いラッパー)
├── OpenAiLlmClient.streamChatCompletions()  → Stream<OpenAiChatChunk>
├── AnthropicLlmClient.streamMessages()      → Stream<AnthropicStreamEvent>
└── GeminiLlmClient.streamGenerateContent()  → Stream<GeminiStreamChunk>
```

- 薄いラッパーは各社 API の型付きオブジェクト (freezed / discriminated union)
  をそのまま流します。翻訳の知識は持ちません
- `TranslationClient` 実装が各社オブジェクトから思考/本文デルタを取り出し、
  [llm_json_stream](https://pub.dev/packages/llm_json_stream) による
  逐次パース + ストリーム完了後の厳密パースで
  `TranslationEvent {thinking, result}` を流します
- 設定は sealed な `LlmClientConfig` (プロバイダ毎のバリアント、実デフォルト
  値付き)。クライアントの構築 (DI) は composition root — アプリの provider と
  CLI の main — が config バリアントの switch で行います
- トランスポートエラー (`DioException`) は変換せず生のまま UI へ届きます
  (ストリーミングのエラーボディのみ読み取って例外に残します)

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

AI エージェント (Claude Code / Codex 等) 向けの運用手順は [AGENTS.md](AGENTS.md) を参照。

```sh
flutter analyze                          # 静的解析 (yumemi_lints)
flutter test                             # アプリのウィジェットテスト
(cd packages/kore_client && dart test)   # クライアントのユニットテスト
```

コード生成 (freezed / riverpod_generator / go_router_builder / json_serializable)
を変更した場合は `build_runner` を再実行してください。
