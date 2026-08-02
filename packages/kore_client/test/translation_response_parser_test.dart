import 'package:kore_client/kore_client.dart';
import 'package:kore_client/src/translation/translation_response_parser.dart';
import 'package:partial_json/partial_json.dart';
import 'package:test/test.dart';

void main() {
  group('parseTranslationResponse', () {
    const validJson = '''
{
  "detected_language": "日本語",
  "translation": "Hello",
  "alternatives": [
    {"text": "Hi", "nuance": "カジュアル"}
  ],
  "explanation": "挨拶の定番表現です。"
}
''';

    test('parses a plain JSON object', () {
      final result = parseTranslationResponse(validJson);
      expect(result.detectedLanguage, '日本語');
      expect(result.translation, 'Hello');
      expect(result.alternatives, hasLength(1));
      expect(result.alternatives.first.text, 'Hi');
      expect(result.explanation, isNotEmpty);
    });

    test('parses JSON wrapped in a Markdown code fence', () {
      final result = parseTranslationResponse('```json\n$validJson\n```');
      expect(result.translation, 'Hello');
    });

    test('applies defaults for optional fields', () {
      final result = parseTranslationResponse('{"translation": "Hi"}');
      expect(result.translation, 'Hi');
      expect(result.detectedLanguage, isEmpty);
      expect(result.alternatives, isEmpty);
      expect(result.explanation, isEmpty);
    });

    test('throws KoreClientException on invalid JSON', () {
      expect(
        () => parseTranslationResponse('not json'),
        throwsA(isA<KoreClientException>()),
      );
    });

    test('throws KoreClientException on a JSON array', () {
      expect(
        () => parseTranslationResponse('[1, 2, 3]'),
        throwsA(isA<KoreClientException>()),
      );
    });

    test('throws KoreClientException on a schema mismatch', () {
      expect(
        () => parseTranslationResponse('{"translation": 123}'),
        throwsA(isA<KoreClientException>()),
      );
    });
  });

  group('tryPartialTranslationResult', () {
    test('returns null for a non-object snapshot', () {
      expect(tryPartialTranslationResult(null), isNull);
      expect(tryPartialTranslationResult([1, 2]), isNull);
    });

    test('returns null before the translation has text', () {
      expect(tryPartialTranslationResult({'detected_language': '日本語'}), isNull);
      expect(tryPartialTranslationResult({'translation': ''}), isNull);
    });

    test('returns null on a schema mismatch at the current cut point', () {
      expect(
        tryPartialTranslationResult({
          'translation': 'Hi',
          'alternatives': [<String, Object?>{}],
        }),
        isNull,
      );
    });

    test('builds a result from a partial object', () {
      final result = tryPartialTranslationResult({'translation': 'Hi'});
      expect(result?.translation, 'Hi');
      expect(result?.alternatives, isEmpty);
    });

    test('renders or skips every cut point of a fenced reply, monotonically', () {
      const reply =
          '```json\n'
          r'{"detected_language": "日本語", "translation": "Say \"hi\"!\n", '
          '"alternatives": [{"text": "Hi", "nuance": "カジュアル"}, {"text": "Hey"}], '
          '"explanation": "挨拶です。"}\n```';
      final decoder = PartialJsonDecoder();
      var previousTranslation = '';
      for (var cut = 0; cut < reply.length; cut++) {
        decoder.add(reply[cut]);
        final result = tryPartialTranslationResult(decoder.decode());
        if (result == null) {
          continue; // Not renderable at this cut point; the next delta heals it.
        }
        expect(
          result.translation,
          startsWith(previousTranslation),
          reason: 'cut after $cut',
        );
        previousTranslation = result.translation;
      }
      expect(previousTranslation, 'Say "hi"!\n');
    });
  });
}
