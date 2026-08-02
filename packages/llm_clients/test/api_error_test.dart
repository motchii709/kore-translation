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

    test('ignores payloads without an error', () {
      expect(() => throwIfApiError({'choices': <Object>[]}), returnsNormally);
      expect(() => throwIfApiError({'error': null}), returnsNormally);
    });

    test('carries a non-standard error payload raw', () {
      expect(
        () => throwIfApiError({
          'error': {'code': 429, 'type': 'rate_limit'},
        }),
        throwsA(isA<LlmApiException>().having((e) => e.message, 'message', contains('rate_limit'))),
      );
      expect(
        () => throwIfApiError({'error': 'boom'}),
        throwsA(isA<LlmApiException>().having((e) => e.message, 'message', contains('boom'))),
      );
    });
  });
}
