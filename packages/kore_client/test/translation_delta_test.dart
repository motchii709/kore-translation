import 'package:kore_client/kore_client.dart';
import 'package:kore_client/src/translation/translation_delta.dart';
import 'package:test/test.dart';

void main() {
  group('assembleTranslationEvents', () {
    test('accumulates thinking and emits progressively richer results', () async {
      final deltas = Stream.fromIterable(const [
        TranslationThinkingDelta('挨拶の翻訳を'),
        TranslationThinkingDelta('考える'),
        TranslationTextDelta('{"translation": "He'),
        TranslationTextDelta('llo", "explanation": "挨拶です。"}'),
      ]);
      final events = await assembleTranslationEvents(deltas).toList();

      expect(events.first.thinking, '挨拶の翻訳を');
      expect(events.first.result, isNull);
      expect(events.map((e) => e.thinking), contains('挨拶の翻訳を考える'));
      expect(events.map((e) => e.result?.translation), contains('He'));
      final last = events.last;
      expect(last.thinking, '挨拶の翻訳を考える');
      expect(last.result?.translation, 'Hello');
      expect(last.result?.explanation, '挨拶です。');
    });

    test('handles a fenced reply', () async {
      final deltas = Stream.fromIterable(const [
        TranslationTextDelta('```json\n{"translation": "Hel'),
        TranslationTextDelta('lo"}\n```'),
      ]);
      final events = await assembleTranslationEvents(deltas).toList();
      expect(events.map((e) => e.result?.translation), contains('Hel'));
      expect(events.last.result?.translation, 'Hello');
    });

    test('forwards errors from the delta stream without hanging', () {
      final deltas = Stream<TranslationDelta>.error(
        const KoreClientException('boom'),
      );
      expect(
        assembleTranslationEvents(deltas).toList(),
        throwsA(isA<KoreClientException>()),
      );
    });

    test('throws when the reply contains no text at all', () {
      expect(
        assembleTranslationEvents(const Stream.empty()).toList(),
        throwsA(isA<KoreClientException>()),
      );
    });

    test('throws when the completed reply does not match the schema', () {
      final deltas = Stream.fromIterable(const [
        TranslationTextDelta('{"detected_language": "日本語"}'),
      ]);
      expect(
        assembleTranslationEvents(deltas).toList(),
        throwsA(isA<KoreClientException>()),
      );
    });
  });
}
