import 'package:dio/dio.dart';
import 'package:sympla_app/core/logger/app_logger.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  factory DioClient() => _instance;

  late final Dio dio;

  DioClient._internal() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://suaapi.com/api', // substitua pela real
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
      contentType: 'application/json',
    ));

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        AppLogger.d(
          '➡️ REQUEST: [${options.method}] ${options.uri}',
          tag: 'API',
        );
        AppLogger.v('Headers: ${options.headers}', tag: 'API');
        AppLogger.v('Body: ${options.data}', tag: 'API');
        handler.next(options);
      },
      onResponse: (response, handler) {
        AppLogger.d(
          '✅ RESPONSE: [${response.statusCode}] ${response.requestOptions.uri}',
          tag: 'API',
        );
        AppLogger.v('Response Data: ${response.data}', tag: 'API');
        handler.next(response);
      },
      onError: (DioException e, handler) {
        AppLogger.e(
          '❌ ERROR: [${e.response?.statusCode}] ${e.requestOptions.uri}',
          tag: 'API',
          error: e.message,
          stackTrace: e.stackTrace,
        );

        if (e.response?.data != null) {
          AppLogger.v('Error Response Body: ${e.response?.data}', tag: 'API');
        }

        handler.next(e);
      },
    ));
  }
}
