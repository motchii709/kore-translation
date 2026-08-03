@Tags(['integration'])
library;

import 'dart:io';

import 'package:llm_clients/llm_clients.dart';
import 'package:test/test.dart';

/// End-to-end tests against a real `codex app-server` subprocess. They need
/// the Codex CLI on PATH and a logged-in `~/.codex` (codex login), so they
/// skip themselves when the CLI is unavailable instead of failing CI.
///
/// Run with: dart test -t integration
void main() {
  late bool codexAvailable;

  setUpAll(() async {
    try {
      // Resolve like StdioAgentProcess does: through the login shell on
      // macOS/Linux (version-manager PATHs), the system shell on Windows.
      final result = Platform.isWindows
          ? await Process.run('codex', ['--version'], runInShell: true)
          : await Process.run(Platform.environment['SHELL'] ?? '/bin/sh', ['-lc', 'codex --version']);
      codexAvailable = result.exitCode == 0;
    } on ProcessException {
      codexAvailable = false;
    }
  });

  test('handshake: initialize succeeds against the real server', () async {
    if (!codexAvailable) {
      markTestSkipped('codex CLI not available');
      return;
    }
    final agent = await StdioAgentProcess.start('codex app-server');
    addTearDown(agent.kill);
    final client = CodexLlmClient(config: const CodexConfig(), channel: agent.channel);

    // streamTurn awaits the initialize handshake before thread/start, so a
    // completed thread/start proves the handshake worked. Interrupt right
    // after the first event to keep the turn cheap.
    final events = client.streamTurn(
      systemPrompt: 'Reply with exactly: OK',
      userText: 'ping',
    );
    final first = await events.first.timeout(const Duration(minutes: 2));
    expect(first, isA<CodexTurnEvent>());
  }, timeout: const Timeout(Duration(minutes: 3)));

  test('full turn: streams deltas and completes', () async {
    if (!codexAvailable) {
      markTestSkipped('codex CLI not available');
      return;
    }
    final agent = await StdioAgentProcess.start('codex app-server');
    addTearDown(agent.kill);
    final client = CodexLlmClient(config: const CodexConfig(), channel: agent.channel);

    final events = await client
        .streamTurn(systemPrompt: 'Reply with exactly: OK', userText: 'ping')
        .toList()
        .timeout(const Duration(minutes: 3));

    final text = events
        .whereType<CodexAgentMessageDelta>()
        .map((e) => e.delta)
        .join();
    expect(text, isNotEmpty);
  }, timeout: const Timeout(Duration(minutes: 4)));
}
