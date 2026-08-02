import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:stream_channel/stream_channel.dart';

/// A running agent subprocess (an ACP agent, `codex app-server`, ...)
/// speaking newline-delimited JSON-RPC over stdio. Spawned at the
/// composition root, which also owns [kill]; the [channel] is what gets
/// injected into the stdio-based LLM clients.
final class StdioAgentProcess {
  StdioAgentProcess._(this._process, this.channel);

  /// Spawns the agent from [commandLine].
  ///
  /// Runs through the system shell so launcher scripts (npx's `.cmd` shim on
  /// Windows) resolve. The agent's stderr is forwarded to this process's
  /// stderr: these protocols reserve stderr for logging, and on startup
  /// failures (missing command, agent crash) it carries the actual cause.
  static Future<StdioAgentProcess> start(String commandLine) async {
    final words = splitCommandLine(commandLine);
    final process = await Process.start(
      words.first,
      words.skip(1).toList(),
      runInShell: true,
    );
    process.stderr.listen(stderr.add);
    // Writes racing the process teardown (e.g. a cancellation sent while
    // the composition root disposes) surface on stdin.done; nothing can
    // recover a dead agent, so keep them from becoming unhandled errors.
    unawaited(process.stdin.done.catchError((_) {}));
    final channel = StreamChannel(
      utf8.decoder.bind(process.stdout).transform(const LineSplitter()),
      StreamSinkTransformer<String, List<int>>.fromHandlers(
        handleData: (message, sink) => sink.add(utf8.encode('$message\n')),
      ).bind(process.stdin),
    );
    return StdioAgentProcess._(process, channel);
  }

  final Process _process;

  /// One JSON-RPC message per string event.
  final StreamChannel<String> channel;

  void kill() => _process.kill();
}

/// Splits a command line into words: whitespace separates, single or double
/// quotes group. Deliberately not POSIX rules — backslashes stay literal so
/// Windows paths survive unquoted.
List<String> splitCommandLine(String commandLine) {
  final words = <String>[];
  final current = StringBuffer();
  String? quote;
  for (var i = 0; i < commandLine.length; i++) {
    final char = commandLine[i];
    if (quote != null) {
      if (char == quote) {
        quote = null;
      } else {
        current.write(char);
      }
    } else if (char == '"' || char == "'") {
      quote = char;
    } else if (char == ' ' || char == '\t') {
      if (current.isNotEmpty) {
        words.add(current.toString());
        current.clear();
      }
    } else {
      current.write(char);
    }
  }
  if (current.isNotEmpty) {
    words.add(current.toString());
  }
  return words;
}
