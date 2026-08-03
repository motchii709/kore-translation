import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:llm_sdk_core/llm_sdk_core.dart';
import 'package:stream_channel/stream_channel.dart';

/// A running agent subprocess (an ACP agent, `codex app-server`, ...)
/// speaking newline-delimited JSON-RPC over stdio. Whoever spawns it owns
/// its end of life ([shutdown], or [kill] for an immediate stop); the
/// [channel] is what gets injected into the stdio-based LLM clients.
final class StdioAgentProcess {
  StdioAgentProcess._(this._process) {
    unawaited(_process.exitCode.then((_) => _hasExited = true));
    // These protocols reserve stderr for logging, and when the agent dies
    // its last lines carry the actual cause (missing command, crash
    // output), so a bounded tail is kept for the error [channel] throws.
    // Draining starts here, not on first listen, so a chatty agent cannot
    // fill the stderr pipe and stall before anyone connects.
    const tailLines = 20;
    _stderrDone = const Utf8Decoder(allowMalformed: true).bind(_process.stderr).transform(const LineSplitter()).forEach(
      (line) {
        if (_stderrTail.length == tailLines) {
          _stderrTail.removeAt(0);
        }
        _stderrTail.add(line);
      },
    );
    // Writes racing the process teardown (e.g. a cancellation sent while
    // the composition root disposes) surface on stdin.done; nothing can
    // recover a dead agent, so keep them from becoming unhandled errors.
    unawaited(_process.stdin.done.catchError((_) {}));
  }

  /// Spawns the agent from [commandLine].
  ///
  /// Runs through a shell so launcher scripts (npx's `.cmd` shim on Windows)
  /// resolve. On macOS and Linux that shell is the user's login shell: GUI
  /// launches (Finder, Dock) inherit a minimal PATH without the user's
  /// version managers (mise, homebrew, nvm, ...), so a bare `codex` would
  /// not resolve otherwise.
  static Future<StdioAgentProcess> start(String commandLine) async {
    final Process process;
    if (Platform.isWindows) {
      final words = splitCommandLine(commandLine);
      process = await Process.start(
        words.first,
        words.skip(1).toList(),
        runInShell: true,
      );
    } else {
      final shell = Platform.environment['SHELL'] ?? '/bin/sh';
      // `exec` replaces the shell with the agent so [kill] reaches the
      // agent itself, not a wrapper shell. `env` is in between because
      // `exec` rejects variable-assignment prefixes ("exec: FOO=1: not
      // found") that a command line like `RUST_LOG=debug codex` needs.
      process = await Process.start(shell, ['-lc', 'exec env $commandLine']);
    }
    return StdioAgentProcess._(process);
  }

  final Process _process;
  final _stderrTail = <String>[];
  late final Future<void> _stderrDone;
  var _expectedExit = false;
  var _hasExited = false;

  /// Whether the agent process has exited — however it died. Owners use
  /// this to notice a dead backend and start a fresh one.
  bool get hasExited => _hasExited;

  /// One JSON-RPC message per string event. Startup noise the login shell
  /// prints to stdout is filtered out, and the stream throws when the agent
  /// dies without [shutdown] or [kill], so consumers may treat every event
  /// as a protocol message and an event-free death as an error, not a quiet
  /// close.
  late final StreamChannel<String> channel = StreamChannel(
    _messages(),
    StreamSinkTransformer<String, List<int>>.fromHandlers(
      handleData: (message, sink) => sink.add(utf8.encode('$message\n')),
    ).bind(_process.stdin),
  );

  Stream<String> _messages() async* {
    var agentSpoke = false;
    yield* utf8.decoder.bind(_process.stdout).transform(const LineSplitter()).where((line) {
      if (agentSpoke) {
        return true;
      }
      try {
        jsonDecode(line);
      } on FormatException {
        // The login shell's rc files may print to stdout before `exec`
        // replaces the shell with the agent; the agent itself speaks pure
        // JSON-RPC, so non-JSON before its first message is that startup
        // noise, not protocol.
        return false;
      }
      agentSpoke = true;
      return true;
    });

    // stdout closing means the agent is gone. [shutdown] and [kill] are the
    // expected ways; any other death failed the connection, and the exit
    // code plus the stderr tail is everything known about why. The exit
    // code can arrive before the stderr pipe is fully read, hence the
    // extra wait.
    final exitCode = await _process.exitCode;
    if (!_expectedExit) {
      await _stderrDone;
      final trail = _stderrTail.isEmpty ? '' : ':\n${_stderrTail.join('\n')}';
      throw LlmApiException('The agent process exited (exit code $exitCode)$trail');
    }
  }

  /// Ends the agent politely: closing stdin signals EOF, on which a
  /// well-behaved agent exits by itself. Unlike [kill] — which on Windows
  /// (`runInShell`) may only hit the launcher shell and orphan the actual
  /// agent — EOF travels through launcher shims to the real process. An
  /// agent still alive after [grace] is killed.
  Future<void> shutdown({Duration grace = const Duration(seconds: 2)}) async {
    _expectedExit = true;
    try {
      await _process.stdin.close();
    } on Exception {
      // A dead process may have torn the pipe down already; the exit below
      // is the only thing that matters.
    }
    try {
      await _process.exitCode.timeout(grace);
    } on TimeoutException {
      _process.kill();
    }
  }

  void kill() {
    _expectedExit = true;
    _process.kill();
  }
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
