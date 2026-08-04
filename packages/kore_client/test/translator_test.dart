import 'package:kore_client/kore_client.dart';
import 'package:llm_sdk_core/llm_sdk_core.dart';
import 'package:test/test.dart';

/// Replays a canned fragment stream and records the request.
final class _FakeSession implements LlmSession {
  _FakeSession(this.events);

  final Stream<LlmStreamEvent> events;
  String? system;
  String? user;
  bool? thinking;

  @override
  bool get isAlive => true;

  @override
  Future<void> close() async {}

  @override
  Stream<T> streamObject<T>({
    required String system,
    required String user,
    required bool thinking,
    required T Function(String? thinking, Map<String, dynamic>? reply) decoder,
  }) {
    this.system = system;
    this.user = user;
    this.thinking = thinking;
    return events.decodeSnapshots(decoder);
  }
}

Stream<TranslationEvent> _translate(_FakeSession session) =>
    streamTranslation(session, systemPrompt: 'Translate.', text: 'こんにちは', thinking: true);

void main() {
  test('accumulates thinking and emits progressively richer results, strictly parsed at the end', () async {
    final session = _FakeSession(
      Stream.fromIterable(const [
        LlmThinkingDelta('挨拶の翻訳を'),
        LlmThinkingDelta('考える'),
        LlmTextDelta('{"translation": "He'),
        LlmTextDelta('llo", "explanation": "挨拶です。"}'),
      ]),
    );
    final events = await _translate(session).toList();

    expect(session.system, 'Translate.');
    expect(session.user, 'こんにちは');
    expect(session.thinking, isTrue);
    expect(events.first.thinking, '挨拶の翻訳を');
    expect(events.first.result?.translation, isNull);
    expect(events.map((e) => e.thinking), contains('挨拶の翻訳を考える'));
    expect(events.map((e) => e.result?.translation), contains('He'));
    final last = events.last;
    expect(last.thinking, '挨拶の翻訳を考える');
    expect(last.result?.translation, 'Hello');
    expect(last.result?.explanation, '挨拶です。');
  });

  test('handles a fenced reply', () async {
    final session = _FakeSession(
      Stream.fromIterable(const [
        LlmTextDelta('```json\n{"translation": "Hel'),
        LlmTextDelta('lo"}\n```'),
      ]),
    );
    final events = await _translate(session).toList();
    expect(events.map((e) => e.result?.translation), contains('Hel'));
    expect(events.last.result?.translation, 'Hello');
  });

  test('forwards errors from the event stream without hanging', () {
    final session = _FakeSession(Stream.error(const KoreClientException('boom')));
    expect(_translate(session).toList(), throwsA(isA<KoreClientException>()));
  });

  test('a reply with no fragments completes without events', () async {
    final session = _FakeSession(const Stream.empty());
    expect(await _translate(session).toList(), isEmpty);
  });

  test('a reply without a translation leaves the field null for the caller to judge', () async {
    final session = _FakeSession(
      Stream.fromIterable(const [LlmTextDelta('{"detected_language": "日本語"}')]),
    );
    final events = await _translate(session).toList();
    expect(events.last.result?.detectedLanguage, '日本語');
    expect(events.last.result?.translation, isNull);
  });
}
