// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'llm_client_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OpenAiConfig _$OpenAiConfigFromJson(Map<String, dynamic> json) => $checkedCreate(
  'OpenAiConfig',
  json,
  ($checkedConvert) {
    final val = OpenAiConfig(
      apiKey: $checkedConvert('api_key', (v) => v as String),
      baseUrl: $checkedConvert(
        'base_url',
        (v) => v as String? ?? 'https://api.openai.com/v1',
      ),
      model: $checkedConvert('model', (v) => v as String? ?? 'gpt-5-mini'),
      systemPrompt: $checkedConvert(
        'system_prompt',
        (v) => v as String? ?? '',
      ),
      $type: $checkedConvert('provider', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {
    'apiKey': 'api_key',
    'baseUrl': 'base_url',
    'systemPrompt': 'system_prompt',
    r'$type': 'provider',
  },
);

Map<String, dynamic> _$OpenAiConfigToJson(OpenAiConfig instance) => <String, dynamic>{
  'api_key': instance.apiKey,
  'base_url': instance.baseUrl,
  'model': instance.model,
  'system_prompt': instance.systemPrompt,
  'provider': instance.$type,
};

OpenAiCompatibleConfig _$OpenAiCompatibleConfigFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'OpenAiCompatibleConfig',
  json,
  ($checkedConvert) {
    final val = OpenAiCompatibleConfig(
      apiKey: $checkedConvert('api_key', (v) => v as String? ?? ''),
      baseUrl: $checkedConvert('base_url', (v) => v as String? ?? ''),
      model: $checkedConvert('model', (v) => v as String? ?? ''),
      systemPrompt: $checkedConvert('system_prompt', (v) => v as String? ?? ''),
      $type: $checkedConvert('provider', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {
    'apiKey': 'api_key',
    'baseUrl': 'base_url',
    'systemPrompt': 'system_prompt',
    r'$type': 'provider',
  },
);

Map<String, dynamic> _$OpenAiCompatibleConfigToJson(
  OpenAiCompatibleConfig instance,
) => <String, dynamic>{
  'api_key': instance.apiKey,
  'base_url': instance.baseUrl,
  'model': instance.model,
  'system_prompt': instance.systemPrompt,
  'provider': instance.$type,
};

AnthropicConfig _$AnthropicConfigFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'AnthropicConfig',
  json,
  ($checkedConvert) {
    final val = AnthropicConfig(
      apiKey: $checkedConvert('api_key', (v) => v as String),
      baseUrl: $checkedConvert(
        'base_url',
        (v) => v as String? ?? 'https://api.anthropic.com',
      ),
      model: $checkedConvert('model', (v) => v as String? ?? 'claude-sonnet-5'),
      thinking: $checkedConvert('thinking', (v) => v as bool? ?? true),
      systemPrompt: $checkedConvert('system_prompt', (v) => v as String? ?? ''),
      $type: $checkedConvert('provider', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {
    'apiKey': 'api_key',
    'baseUrl': 'base_url',
    'systemPrompt': 'system_prompt',
    r'$type': 'provider',
  },
);

Map<String, dynamic> _$AnthropicConfigToJson(AnthropicConfig instance) => <String, dynamic>{
  'api_key': instance.apiKey,
  'base_url': instance.baseUrl,
  'model': instance.model,
  'thinking': instance.thinking,
  'system_prompt': instance.systemPrompt,
  'provider': instance.$type,
};

GeminiConfig _$GeminiConfigFromJson(Map<String, dynamic> json) => $checkedCreate(
  'GeminiConfig',
  json,
  ($checkedConvert) {
    final val = GeminiConfig(
      apiKey: $checkedConvert('api_key', (v) => v as String),
      baseUrl: $checkedConvert(
        'base_url',
        (v) => v as String? ?? 'https://generativelanguage.googleapis.com',
      ),
      model: $checkedConvert(
        'model',
        (v) => v as String? ?? 'gemini-2.5-flash',
      ),
      thinking: $checkedConvert('thinking', (v) => v as bool? ?? true),
      systemPrompt: $checkedConvert(
        'system_prompt',
        (v) => v as String? ?? '',
      ),
      $type: $checkedConvert('provider', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {
    'apiKey': 'api_key',
    'baseUrl': 'base_url',
    'systemPrompt': 'system_prompt',
    r'$type': 'provider',
  },
);

Map<String, dynamic> _$GeminiConfigToJson(GeminiConfig instance) => <String, dynamic>{
  'api_key': instance.apiKey,
  'base_url': instance.baseUrl,
  'model': instance.model,
  'thinking': instance.thinking,
  'system_prompt': instance.systemPrompt,
  'provider': instance.$type,
};

DeepSeekConfig _$DeepSeekConfigFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'DeepSeekConfig',
  json,
  ($checkedConvert) {
    final val = DeepSeekConfig(
      apiKey: $checkedConvert('api_key', (v) => v as String),
      baseUrl: $checkedConvert(
        'base_url',
        (v) => v as String? ?? 'https://api.deepseek.com',
      ),
      model: $checkedConvert('model', (v) => v as String? ?? 'deepseek-chat'),
      thinking: $checkedConvert('thinking', (v) => v as bool? ?? true),
      systemPrompt: $checkedConvert('system_prompt', (v) => v as String? ?? ''),
      $type: $checkedConvert('provider', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {
    'apiKey': 'api_key',
    'baseUrl': 'base_url',
    'systemPrompt': 'system_prompt',
    r'$type': 'provider',
  },
);

Map<String, dynamic> _$DeepSeekConfigToJson(DeepSeekConfig instance) => <String, dynamic>{
  'api_key': instance.apiKey,
  'base_url': instance.baseUrl,
  'model': instance.model,
  'thinking': instance.thinking,
  'system_prompt': instance.systemPrompt,
  'provider': instance.$type,
};

AcpConfig _$AcpConfigFromJson(Map<String, dynamic> json) => $checkedCreate(
  'AcpConfig',
  json,
  ($checkedConvert) {
    final val = AcpConfig(
      command: $checkedConvert('command', (v) => v as String? ?? ''),
      systemPrompt: $checkedConvert('system_prompt', (v) => v as String? ?? ''),
      $type: $checkedConvert('provider', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {'systemPrompt': 'system_prompt', r'$type': 'provider'},
);

Map<String, dynamic> _$AcpConfigToJson(AcpConfig instance) => <String, dynamic>{
  'command': instance.command,
  'system_prompt': instance.systemPrompt,
  'provider': instance.$type,
};

CodexConfig _$CodexConfigFromJson(Map<String, dynamic> json) => $checkedCreate(
  'CodexConfig',
  json,
  ($checkedConvert) {
    final val = CodexConfig(
      command: $checkedConvert(
        'command',
        (v) => v as String? ?? 'codex app-server',
      ),
      model: $checkedConvert('model', (v) => v as String? ?? ''),
      thinking: $checkedConvert('thinking', (v) => v as bool? ?? true),
      systemPrompt: $checkedConvert('system_prompt', (v) => v as String? ?? ''),
      $type: $checkedConvert('provider', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {'systemPrompt': 'system_prompt', r'$type': 'provider'},
);

Map<String, dynamic> _$CodexConfigToJson(CodexConfig instance) => <String, dynamic>{
  'command': instance.command,
  'model': instance.model,
  'thinking': instance.thinking,
  'system_prompt': instance.systemPrompt,
  'provider': instance.$type,
};
