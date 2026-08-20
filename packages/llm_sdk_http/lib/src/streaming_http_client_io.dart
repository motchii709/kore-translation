import 'dart:convert';
import 'package:dio/dio.dart';
import 'streaming_http_client.dart';

/// Creates a native (IO) [StreamingHttpClient] backed by Dio.
StreamingHttpClient createStreamingHttpClient({Duration? connectTimeout, Duration? receiveTimeout}) {
  final dio = Dio(BaseOptions(
    connectTimeout: connectTimeout ?? const Duration(seconds: 10),
    receiveTimeout: receiveTimeout ?? const Duration(seconds: 120),
  ));
  return DioStreamingHttpClient(dio);
}

final class DioStreamingHttpClient implements StreamingHttpClient {
  DioStreamingHttpClient(this.dio);
  final Dio dio;

  @override
  Future<StreamingHttpResponse> post(String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    Object? body,
  }) async {
    try {
      final response = await dio.post<ResponseBody>(
        url,
        queryParameters: queryParameters,
        options: Options(
          responseType: ResponseType.stream,
          headers: headers,
        ),
        data: body,
      );
      final data = response.data;
      if (data == null) {
        throw const StreamingHttpException(0, 'Empty API response body');
      }
      return StreamingHttpResponse(
        statusCode: response.statusCode ?? 200,
        body: data.stream,
      );
    } on DioException catch (e) {
      String? errorBody;
      if (e.response?.data is ResponseBody) {
        final ResponseBody b = e.response!.data as ResponseBody;
        errorBody = await utf8.decodeStream(b.stream);
      }
      throw StreamingHttpException(
        e.response?.statusCode ?? 0,
        e.message ?? 'HTTP request failed',
        body: errorBody,
      );
    }
  }

  @override
  Future<void> close() async => dio.close();
}
