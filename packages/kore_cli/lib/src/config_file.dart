import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:yaml/yaml.dart';

/// Keys accepted in the config file, named after their command line options.
const cliConfigKeys = {
  'provider',
  'api-key',
  'base-url',
  'model',
  'acp-command',
  'codex-command',
  'to',
  'tone',
  'thinking',
  'prompt',
};

/// The default config file location: `~/.kore/config.yaml`.
String defaultCliConfigPath([Map<String, String>? environment]) {
  final env = environment ?? Platform.environment;
  final home = env['USERPROFILE'] ?? env['HOME'] ?? '';
  return p.join(home, '.kore', 'config.yaml');
}

/// Loads the config file at [path] into option-name → string form (booleans
/// and numbers are stringified, matching how environment variables arrive).
///
/// A missing file is simply no configuration. Unknown keys and non-scalar
/// values are rejected so typos fail loudly instead of being ignored.
Map<String, String> loadCliConfigFile(String path) {
  final file = File(path);
  if (!file.existsSync()) {
    return const {};
  }
  final Object? document;
  try {
    document = loadYaml(file.readAsStringSync());
  } on YamlException catch (e) {
    throw FormatException('Invalid config file $path: ${e.message}');
  }
  if (document == null) {
    return const {}; // An empty file.
  }
  if (document is! Map) {
    throw FormatException('Config file $path must be a YAML map');
  }
  final config = <String, String>{};
  for (final MapEntry(:key, :value) in document.entries) {
    if (!cliConfigKeys.contains(key)) {
      throw FormatException(
        'Unknown key "$key" in $path (allowed: ${cliConfigKeys.join(' / ')})',
      );
    }
    if (value is! String && value is! bool && value is! num) {
      throw FormatException('Key "$key" in $path must be a scalar value');
    }
    config[key as String] = value.toString();
  }
  return config;
}
