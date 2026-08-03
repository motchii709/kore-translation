import 'package:llm_sdk_core/llm_sdk_core.dart';
import 'package:stdio_agent/stdio_agent.dart';
import 'package:test/test.dart';

void main() {
  test(
    'start delivers only JSON lines and accepts an env-var prefix',
    () async {
      // Prints noise before the JSON like a login-shell rc file would, and
      // carries a variable assignment like `RUST_LOG=debug codex` would.
      final agent = await StdioAgentProcess.start(
        'KORE_TEST=1 sh -c \'echo not json; echo "{\\"v\\": \$KORE_TEST}"; read _\'',
      );
      addTearDown(agent.kill);

      expect(await agent.channel.stream.first, '{"v": 1}');
    },
    testOn: '!windows',
  );

  test(
    'an agent dying without kill errors the channel with its stderr trail',
    () async {
      final agent = await StdioAgentProcess.start('sh -c "echo the actual cause >&2; exit 3"');
      addTearDown(agent.kill);

      await expectLater(
        agent.channel.stream.drain<void>(),
        throwsA(
          isA<LlmApiException>().having(
            (e) => e.message,
            'message',
            allOf(contains('exit code 3'), contains('the actual cause')),
          ),
        ),
      );
    },
    testOn: '!windows',
  );

  test(
    'kill closes the channel without an error',
    () async {
      final agent = await StdioAgentProcess.start('sh -c "read _"');
      agent.kill();

      await expectLater(agent.channel.stream.drain<void>(), completes);
    },
    testOn: '!windows',
  );

  group('splitCommandLine', () {
    test('splits on whitespace runs', () {
      expect(
        splitCommandLine('npx  -y\t@agentclientprotocol/claude-agent-acp '),
        ['npx', '-y', '@agentclientprotocol/claude-agent-acp'],
      );
    });

    test('quotes group words and backslashes stay literal', () {
      expect(
        splitCommandLine(r'"C:\Program Files\Agent\agent.exe" --acp'),
        [r'C:\Program Files\Agent\agent.exe', '--acp'],
      );
      expect(splitCommandLine("sh -c 'echo hi'"), ['sh', '-c', 'echo hi']);
      expect(splitCommandLine('a"b c"d'), ['ab cd']);
    });
  });
}
