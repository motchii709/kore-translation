import 'package:kore_config/kore_config.dart';
import 'package:llm_sdk_acp/llm_sdk_acp.dart';
import 'package:llm_sdk_anthropic/llm_sdk_anthropic.dart';
import 'package:llm_sdk_codex/llm_sdk_codex.dart';
import 'package:llm_sdk_core/llm_sdk_core.dart';
import 'package:llm_sdk_deep_seek/llm_sdk_deep_seek.dart';
import 'package:llm_sdk_google/llm_sdk_google.dart';
import 'package:llm_sdk_openai/llm_sdk_openai.dart';
import 'package:llm_sdk_openai_compatible/llm_sdk_openai_compatible.dart';

/// Maps a config variant onto its provider client — field-to-argument only,
/// no logic. The union is sealed, so adding a variant breaks this switch at
/// compile time until it is handled here.
LlmClient llmClientFrom(LlmClientConfig config) => switch (config) {
  final OpenAiConfig config => OpenAiClient(
    apiKey: config.apiKey,
    baseUrl: config.baseUrl,
    model: config.model,
  ),
  final OpenAiCompatibleConfig config => OpenAiCompatibleClient(
    apiKey: config.apiKey,
    baseUrl: config.baseUrl,
    model: config.model,
  ),
  final AnthropicConfig config => AnthropicClient(
    apiKey: config.apiKey,
    baseUrl: config.baseUrl,
    model: config.model,
  ),
  final GeminiConfig config => GeminiClient(
    apiKey: config.apiKey,
    baseUrl: config.baseUrl,
    model: config.model,
  ),
  final DeepSeekConfig config => DeepSeekClient(
    apiKey: config.apiKey,
    baseUrl: config.baseUrl,
    model: config.model,
  ),
  final AcpConfig config => AcpClient(command: config.command),
  final CodexConfig config => CodexClient(
    command: config.command,
    model: config.model,
  ),
};
