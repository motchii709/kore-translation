import 'package:kore_client/kore_client.dart';
import 'package:kore_client/src/translation/translation_snapshot_stream.dart';
import 'package:test/test.dart';

void main() {
  group('partialTranslationSnapshots', () {
    test('emits progressively richer snapshots', () async {
      final deltas = Stream.fromIterable([
        '{"detected_language": "日本語", ',
        '"translation": "He',
        'llo", "alternatives": [{"text": "Hi", "nuance": "カジュアル"}], ',
        '"explanation": "挨拶です。"}',
      ]);
      final snapshots = await partialTranslationSnapshots(deltas).toList();

      expect(snapshots, isNotEmpty);
      expect(snapshots.map((s) => s.translation), contains('He'));
      final last = snapshots.last;
      expect(last.translation, 'Hello');
      expect(last.detectedLanguage, '日本語');
      expect(last.alternatives, hasLength(1));
      expect(last.alternatives.single.text, 'Hi');
      expect(last.alternatives.single.nuance, 'カジュアル');
      expect(last.explanation, '挨拶です。');
    });

    test('stays silent until the main translation appears', () async {
      final deltas = Stream.fromIterable(['{"detected_language": "日本語"']);
      final snapshots = await partialTranslationSnapshots(deltas).toList();
      expect(snapshots, isEmpty);
    });

    test('ignores a leading code fence', () async {
      final deltas = Stream.fromIterable([
        '```json\n',
        '{"translation": "Hello"}',
      ]);
      final snapshots = await partialTranslationSnapshots(deltas).toList();
      expect(snapshots.last.translation, 'Hello');
    });

    test('forwards errors from the source stream', () {
      final deltas = Stream<String>.error(const KoreClientException('boom'));
      expect(
        partialTranslationSnapshots(deltas).toList(),
        throwsA(isA<KoreClientException>()),
      );
    });
  });

  group('translationResultStream', () {
    test('ends with the strictly parsed final result', () async {
      final deltas = Stream.fromIterable([
        '{"translation": "He',
        'llo"}',
      ]);
      final results = await translationResultStream(deltas).toList();
      expect(results.map((r) => r.translation), contains('He'));
      expect(results.last.translation, 'Hello');
    });

    test('throws when the reply contains no text at all', () {
      expect(
        translationResultStream(const Stream.empty()).toList(),
        throwsA(isA<KoreClientException>()),
      );
    });
  });
}
