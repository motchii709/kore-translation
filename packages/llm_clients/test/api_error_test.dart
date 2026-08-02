import 'package:llm_clients/llm_clients.dart';
import 'package:llm_clients/src/http/api_error.dart';
import 'package:test/test.dart';

void main() {
  group('throwIfApiError', () {
    test('throws with the API message on an error payload', () {
      expect(
        () => throwIfApiError({
          'error': {'message': 'Overloaded'},
        }),
        throwsA(
          isA<LlmApiException>().having((e) => e.message, 'message', 'Overloaded'),
        ),
      );
    });

    test('ignores payloads without an error message', () {
      expect(() => throwIfApiError({'choices': <Object>[]}), returnsNormally);
      expect(() => throwIfApiError({'error': <String, Object>{}}), returnsNormally);
    });
  });
}
