import 'package:kore_client/kore_client.dart';
import 'package:partial_json/partial_json.dart';
import 'package:test/test.dart';

void main() {
  test('fromJson tolerates an empty reply object', () {
    final result = TranslationResult.fromJson(const {});
    expect(result.translation, isNull);
    expect(result.detectedLanguage, isNull);
    expect(result.alternatives, isNull);
    expect(result.explanation, isNull);
  });

  test('fromJson decodes a complete reply object', () {
    final result = TranslationResult.fromJson(const {
      'detected_language': '日本語',
      'translation': 'Hello',
      'alternatives': [
        {'text': 'Hi', 'nuance': 'カジュアル'},
      ],
      'explanation': '挨拶の定番表現です。',
    });
    expect(result.detectedLanguage, '日本語');
    expect(result.translation, 'Hello');
    expect(result.alternatives?.first.text, 'Hi');
    expect(result.explanation, '挨拶の定番表現です。');
  });

  test('decodes every cut point of a fenced reply, monotonically', () {
    const reply =
        '```json\n'
        r'{"detected_language": "日本語", "translation": "Say \"hi\"!\n", '
        '"alternatives": [{"text": "Hi", "nuance": "カジュアル"}, {"text": "Hey"}], '
        '"explanation": "挨拶です。"}\n```';
    final decoder = PartialJsonDecoder();
    var previous = '';
    for (var cut = 0; cut < reply.length; cut++) {
      decoder.add(reply[cut]);
      final json = decoder.decode();
      if (json is! Map<String, dynamic>) {
        continue; // Not decodable at this cut point; the next chunk heals it.
      }
      final translation = TranslationResult.fromJson(json).translation ?? '';
      expect(translation, startsWith(previous), reason: 'cut after $cut');
      previous = translation;
    }
    expect(previous, 'Say "hi"!\n');
  });
}
