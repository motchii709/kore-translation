import 'package:kore_client/kore_client.dart';
import 'package:kore_client/src/translation/translation_response_parser.dart';
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
}
