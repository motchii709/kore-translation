import 'dart:convert';
import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:llm_clients/llm_clients.dart';
import 'package:path/path.dart' as p;
import 'package:yaml/yaml.dart';

/// The CLI configuration: the LLM backend as the [LlmClientConfig] union
/// under `llm`, plus per-user defaults for the translation options.
final class CliConfig {
  const CliConfig({this.llm, this.to, this.tone, this.thinking, this.prompt});

  final LlmClientConfig? llm;
  final String? to;
  final String? tone;
  final bool? thinking;
  final String? prompt;
}

/// The default config file location: `~/.kore/config.yaml`.
String defaultCliConfigPath([Map<String, String>? environment]) {
  final env = environment ?? Platform.environment;
  final home = env['USERPROFILE'] ?? env['HOME'] ?? '';
  return p.join(home, '.kore', 'config.yaml');
}

/// Loads the config file at [path].
///
/// A missing file is an empty configuration. Unknown top-level keys and
/// wrongly typed values are rejected so typos fail loudly. The `llm` map is
/// validated by [LlmClientConfig.fromJson] — the union definition is the
/// schema.
CliConfig loadCliConfig(String path) {
  final file = File(path);
  if (!file.existsSync()) {
    return const CliConfig();
  }
  final Object? document;
  try {
    document = loadYaml(file.readAsStringSync());
  } on YamlException catch (e) {
    throw FormatException('Invalid config file $path: ${e.message}');
  }
  if (document == null) {
    return const CliConfig(); // An empty file.
  }
  if (document is! Map) {
    throw FormatException('Config file $path must be a YAML map');
  }
  // Yaml nodes are json-encodable, so a JSON round-trip converts the nested
  // YamlMap/YamlList structure into plain maps and lists.
  final map = jsonDecode(jsonEncode(document)) as Map<String, dynamic>;
  const allowedKeys = {'llm', 'to', 'tone', 'thinking', 'prompt'};
  for (final key in map.keys) {
    if (!allowedKeys.contains(key)) {
      throw FormatException('Unknown key "$key" in $path (allowed: ${allowedKeys.join(' / ')})');
    }
  }
  return CliConfig(
    llm: switch (map['llm']) {
      null => null,
      final Map<String, dynamic> llm => _parseLlm(llm, path),
      _ => throw FormatException('"llm" in $path must be a map'),
    },
    to: _stringOf(map, 'to', path),
    tone: _stringOf(map, 'tone', path),
    thinking: switch (map['thinking']) {
      null => null,
      final bool value => value,
      _ => throw FormatException('"thinking" in $path must be a boolean'),
    },
    prompt: _stringOf(map, 'prompt', path),
  );
}

LlmClientConfig _parseLlm(Map<String, dynamic> json, String path) {
  try {
    return LlmClientConfig.fromJson(json);
  } on CheckedFromJsonException catch (e) {
    throw FormatException('Invalid "llm" config in $path: $e');
  }
}

String? _stringOf(Map<String, dynamic> map, String key, String path) => switch (map[key]) {
  null => null,
  final String value => value,
  _ => throw FormatException('"$key" in $path must be a string'),
};
