# kore translation (Kore翻訳)

LLM を使った翻訳アプリのテンプレート。[Nani翻訳](https://nani.now) 風の
「翻訳 + 別の言い方 + ニュアンス解説」をバックエンド無しで実現します。
アプリ / CLI から LLM の API (OpenAI 互換 / Anthropic / Google AI) を直接叩くか、
コーディングエージェントに翻訳させます — [ACP (Agent Client Protocol)](https://agentclientprotocol.com)
経由の Claude Code / Gemini CLI など、および独自の app-server プロトコルで
ネイティブ接続する Codex CLI。

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
    ├── kore_client/         # 翻訳ドメイン (llm_sdk_core の上、Flutter 非依存)
    ├── kore_cli/            # CLI / 対話 TUI
    ├── kore_config/         # LLM 接続設定の sealed union (永続化スキーマ)
    ├── kore_backends/       # composition root (config バリアント → llm_sdk クライアント)
    ├── llm_sdk_core/        # プロバイダ非依存の LLM 抽象 (ai-sdk 相当の spec、依存ゼロ)
    ├── llm_sdk_openai/      # プロバイダ実装 (ワイヤ + アダプタ)。ほか openai_compatible /
    │                        #   anthropic / google / deep_seek / acp / codex の計 7 パッケージ
    ├── stdio_agent/         # エージェントサブプロセスのトランスポート (プロバイダ知識ゼロ)
    ├── sse/                 # SSE 行パース (プロバイダ知識ゼロ)
    ├── kore_lints/          # 共有 lint 設定 (yumemi_lints ベース)
    └── partial_json/        # 生成途中で切れた JSON を補完する汎用ユーティリティ
```

### アーキテクチャ

ai-sdk 型のレイヤリングです。層の境界は pub workspace のパッケージ依存で機械的に
強制され、プロバイダ実装は互いの存在を知らず (他プロバイダを import すると
コンパイル不能)、実装間の共通化もしません。

```
app / kore_cli                # UI + 入口。設定を読み llmClientFrom(config).open() で束ねる
└─ kore_client                # 翻訳ドメイン。プロバイダ知識ゼロ・実装 1 本:
   │                          #   streamTranslation(session, ...) → TranslationEvent {thinking, result}
   └─ llm_sdk_core            # 統一抽象 (依存ゼロ): LlmClient.open() → LlmSession.streamText()
      │                       #   → LlmStreamEvent (text / thinking デルタ)、isAlive / close()
      ├─ llm_sdk_openai ほか計 7  # プロバイダ実装 (ワイヤ + アダプタ)。依存は core とトランスポートのみ
      └─ stdio_agent / sse    # プロバイダ知識ゼロのトランスポート

kore_config                   # sealed union LlmClientConfig = 永続化スキーマ (LLM 層とは独立)
kore_backends                 # composition root: config バリアント → プロバイダクライアント (網羅 switch)
```

- プロバイダパッケージは各社 API の型付きオブジェクト (freezed) を内部で流し、
  統一イベント (`LlmStreamEvent`) へ写像します。`jsonOutput` のような統一
  オプションを自社パラメータ (`response_format` / レスポンス MIME) に写す判断、
  Anthropic の `max_tokens` 既定値、ACP の「system スロットが無いので本文へ
  前置」といったプロバイダ知識はすべて各パッケージに閉じます
- `streamTranslation` (kore_client) が唯一の翻訳実装で、統一イベントから
  生成途中 JSON の補完 (`partial_json` パッケージ、未完文字列と閉じ括弧を
  閉じて再パース) による逐次スナップショット + ストリーム完了後の厳密パースで
  `TranslationEvent {thinking, result}` を流します
- システムプロンプトはフロントエンド (llm 設定の `system_prompt`) が組み立て、
  ユーザーが自由に調整できます。kore_client が持つプロンプト知識は、パーサーと
  対になるレスポンススキーマ指示 (`translationSchemaPrompt`) のみです
- 設定は sealed な `LlmClientConfig` (kore_config、プロバイダ毎のバリアント、
  実デフォルト値付き)。union はそのまま永続化スキーマでもあり (`provider` を
  判別子に JSON/YAML と相互変換)、アプリの secure storage も CLI の設定ファイルも
  これを直書きします。LLM 層は永続化を知りません。構築 (DI) は kore_backends の
  `llmClientFrom` が sealed 網羅 switch で行い、資源 (Dio / サブプロセス) は
  `open()` で生まれて `LlmSession` が所有し、`close()` (HTTP は graceful、
  エージェントは EOF → 猶予 → kill) で解放されます。共有・キャッシュは利用側の
  仕事 — アプリは keepAlive provider が 1 セッションを温存し (起動時にウォーム
  アップ)、起動失敗や死んだ接続は次の翻訳操作が張り直します。CLI は 1 実行 1
  セッションです
- トランスポートエラー (`DioException`) は変換せず生のまま UI へ届きます
  (ストリーミングのエラーボディのみ読み取って例外に残します)
- エージェントバックエンド (ACP / Codex app-server) は stdio の JSON-RPC
  ([`json_rpc_2`](https://pub.dev/packages/json_rpc_2)) でサブプロセスと話します。
  サブプロセスの起動 (`StdioAgentProcess`) とプロトコルハンドシェイクは `open()`
  が完了まで待つので、壊れた設定は翻訳時ではなく起動時に表面化し、翻訳は常に
  温まった接続で走ります。
  翻訳 1 回 = ACP は 1 セッション (`session/new` + `session/prompt`)、Codex は
  1 ephemeral スレッド (`thread/start` + `turn/start`、履歴に残らない) です。
  翻訳にツールは不要なので、ACP は権限要求をすべて拒否し、Codex は
  `approvalPolicy: never` + read-only サンドボックスで開始します。
  認証はエージェント側 (Claude Code のログイン / `codex login`) に従い、
  API キーは不要です

## セットアップ

ツールチェーンは [mise](https://mise.jdx.dev/) で管理しています。

```sh
mise install
flutter pub get
dart run build_runner build   # アプリのコード生成
# freezed / json_serializable を使うパッケージ (kore_client / kore_config /
# llm_sdk_*) も、生成対象を変更した場合は同様に各ディレクトリで実行します
```

> Windows デスクトップで実行する場合は、プラグインの symlink 作成のため
> Windows の開発者モードを有効にしてください (`start ms-settings:developers`)。

## 実行

### アプリ

```sh
flutter run -d windows   # ほか: -d <android-device> / macos / linux
```

設定画面で LLM プロバイダ・API キー・ベース URL・モデルを設定します。
フィールドには実際に使われる値がそのまま入っており、プロバイダを切り替えると
そのプロバイダのデフォルト値が流し込まれます (「空欄なら既定値」のような暗黙の
挙動はありません)。API キーは `flutter_secure_storage` で端末にのみ保存されます。
プロバイダに「ACPエージェント」を選んだ場合は、API キーの代わりに起動コマンド
(例: `npx -y @agentclientprotocol/claude-agent-acp`) を設定します。
「Codex」は起動コマンドが既定で入っているので、保存するだけで使えます
(認証は `codex login`)。エージェント系はサブプロセスを起動するため、
Android / iOS では選択肢に表示されません。
システムプロンプトも同様にデフォルトの本文が入った状態から直接編集できます
(`{{language}}` (選択言語)・`{{app}}` (アプリの言語)・`{{tone}}` が翻訳時に置換されます)。

### CLI

接続設定は `~/.kore/config.yaml` (`--config` で変更可) にのみ書きます。
`llm` の中身は `LlmClientConfig` の discriminated union そのままです
(`provider` が判別子、フィールドは snake_case。必須フィールドの欠落は
union の定義どおりエラーになります):

```yaml
# ~/.kore/config.yaml
llm:
  provider: codex        # openai / openai-compatible / anthropic / google / deepseek / acp / codex
  # model: gpt-5.6-sol
  # thinking: false      # 対応プロバイダの思考のオン/オフ
  # system_prompt: 関西弁に翻訳して   # プロンプト全体の差し替え (応答フォーマット指示も自前で書く)
to: English              # 翻訳オプションの既定 (tone も可)
```

プロバイダごとの `llm` の例:

```yaml
llm: { provider: openai, api_key: sk-... }
llm: { provider: openai-compatible, base_url: "http://localhost:11434/v1", model: llama3 }
llm: { provider: acp, command: npx -y @agentclientprotocol/claude-agent-acp }  # API キー不要
llm: { provider: codex }                    # codex login 済みならこれだけで動く
```

コマンドラインの引数は翻訳オプションだけです (引数 > 設定ファイル > 既定値):

```sh
cd packages/kore_cli
dart run bin/kore.dart "こんにちは"
dart run bin/kore.dart -i                # 対話 (TUI) モード
dart run bin/kore.dart "Hello" -t 日本語
dart run bin/kore.dart "了解です" --tone "フランクな口調で"   # トーンは自由記述
```

## 開発

AI エージェント (Claude Code / Codex 等) 向けの運用手順は [AGENTS.md](AGENTS.md) を参照。

```sh
flutter analyze                          # 静的解析 (yumemi_lints)
flutter test                             # アプリのウィジェットテスト
(cd packages/kore_client && dart test)   # 翻訳層のユニットテスト
(cd packages/llm_sdk_openai && dart test)  # プロバイダのユニットテスト (他の llm_sdk_* / stdio_agent も同様)
(cd packages/partial_json && dart test)  # JSON 補完のユニットテスト
```

コード生成 (freezed / riverpod_generator / go_router_builder / json_serializable)
を変更した場合は `build_runner` を再実行してください。
