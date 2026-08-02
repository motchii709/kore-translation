import 'dart:convert';

import 'package:partial_json/partial_json.dart';
import 'package:test/test.dart';

String complete(String text) => (PartialJsonDecoder()..add(text)).completedText;

void main() {
  group('PartialJsonDecoder', () {
    test('closes an unterminated string', () {
      expect(complete('{"a": "hel'), '{"a": "hel"}');
    });

    test('closes nested objects and arrays', () {
      expect(complete('{"a": [{"b": [1, 2'), '{"a": [{"b": [1, 2]}]}');
    });

    test('completes a root array', () {
      expect(complete('[1, {"a": "b'), '[1, {"a": "b"}]');
    });

    test('drops a trailing comma', () {
      expect(complete('{"a": 1, '), '{"a": 1}');
    });

    test('drops a cut escape sequence', () {
      expect(complete(r'{"a": "x\'), '{"a": "x"}');
    });

    test('keeps a complete escape sequence', () {
      expect(complete(r'{"a": "x\n'), r'{"a": "x\n"}');
    });

    test('ignores brackets inside strings', () {
      expect(complete('{"a": "{[.'), '{"a": "{[."}');
    });

    test('skips a leading code fence', () {
      expect(complete('```json\n{"a": 1'), '{"a": 1}');
    });

    test('skips leading prose', () {
      expect(complete('Sure! Here it is:\n{"a": 1}'), '{"a": 1}');
    });

    test('ignores everything after the root value closes', () {
      final decoder = PartialJsonDecoder()..add('{"a": 1}\n```\ntrailing yap');
      expect(decoder.completedText, '{"a": 1}');
      decoder.add('{"more": "yap"}');
      expect(decoder.completedText, '{"a": 1}');
    });

    test('decodes to null before any document arrives', () {
      expect(PartialJsonDecoder().decode(), isNull);
      expect((PartialJsonDecoder()..add('```json\n')).decode(), isNull);
    });

    test('decodes to null on a dangling key', () {
      expect((PartialJsonDecoder()..add('{"a": 1, "b":')).decode(), isNull);
    });

    test('decodes or skips every cut point, incrementally', () {
      const doc =
          r'{"s": "a\"b\\c\n", "n": -12.5e3, "t": true, "f": false, '
          '"z": null, "arr": [1, {"k": "v"}, [2]], "o": {"nested": "x"}}';
      final decoder = PartialJsonDecoder();
      Object? lastDecoded;
      for (var cut = 0; cut < doc.length; cut++) {
        decoder.add(doc[cut]);
        // Feeding character by character leaves the same state as one shot.
        expect(
          decoder.completedText,
          complete(doc.substring(0, cut + 1)),
          reason: 'cut after $cut',
        );
        final decoded = decoder.decode();
        if (decoded != null) {
          expect(decoded, isA<Map<String, dynamic>>(), reason: 'cut after $cut');
          lastDecoded = decoded;
        }
      }
      expect(lastDecoded, jsonDecode(doc));
    });
  });
}
