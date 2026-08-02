import 'package:dio/dio.dart';
import 'package:kore_client/src/http/api_error_mapper.dart';
import 'package:test/test.dart';

DioException _httpError(Object? data, {int statusCode = 401}) {
  final requestOptions = RequestOptions(path: '/chat/completions');
  return DioException.badResponse(
    statusCode: statusCode,
    requestOptions: requestOptions,
    response: Response(
      requestOptions: requestOptions,
      statusCode: statusCode,
      data: data,
    ),
  );
}

void main() {
  group('mapDioException', () {
    test('extracts the message from a decoded error body', () {
      final exception = mapDioException(
        _httpError({
          'error': {'message': 'Incorrect API key provided'},
        }),
      );
      expect(exception.message, 'Incorrect API key provided');
      expect(exception.statusCode, 401);
    });

    test('extracts the message from a text/plain (string) error body', () {
      final exception = mapDioException(
        _httpError('{"error": {"message": "Incorrect API key provided"}}'),
      );
      expect(exception.message, 'Incorrect API key provided');
    });

    test('falls back to a generic message for unknown bodies', () {
      final exception = mapDioException(_httpError('<html>bad</html>'));
      expect(exception.message, 'APIリクエストが失敗しました (HTTP 401)');
      expect(exception.statusCode, 401);
    });

    test('maps timeouts to a dedicated message', () {
      final exception = mapDioException(
        DioException.connectionTimeout(
          requestOptions: RequestOptions(path: '/chat/completions'),
          timeout: const Duration(seconds: 10),
        ),
      );
      expect(exception.message, 'APIリクエストがタイムアウトしました');
      expect(exception.statusCode, isNull);
    });
  });
}
