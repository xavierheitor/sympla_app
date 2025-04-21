import 'package:dio/dio.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/session/session_manager.dart';

class DioClient {
  final Dio _dio;
  final SessionManager sessionManager;

  DioClient(this.sessionManager)
      : _dio = Dio(BaseOptions(
          baseUrl: 'http://10.0.2.2:3001/api', // baseUrl embutido
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 15),
          headers: {
            'Content-Type': 'application/json',
          },
        )) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await sessionManager.token;
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          AppLogger.v('➡️ REQUEST: [${options.method}] ${options.uri}',
              tag: 'API');
          AppLogger.v('🔍 Headers: ${options.headers}', tag: 'API');
          if (options.data != null) {
            AppLogger.v('🔍 Body: ${options.data}', tag: 'API');
          }

          handler.next(options);
        },
        onError: (error, handler) {
          AppLogger.e(
              '❌ ERROR: [${error.response?.statusCode}] ${error.requestOptions.path}',
              tag: 'API',
              error: error,
              stackTrace: error.stackTrace);
          AppLogger.v('🔍 Error Response Body: ${error.response?.data}',
              tag: 'API');
          handler.next(error);
        },
        onResponse: (response, handler) {
          AppLogger.v(
              '✅ RESPONSE: [${response.statusCode}] ${response.requestOptions.uri}',
              tag: 'API');
          AppLogger.v('🔍 Response Data: ${response.data}', tag: 'API');
          handler.next(response);
        },
      ),
    );
  }

  String get baseUrl => _dio.options.baseUrl;

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    return await _dio.get(
      path,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
  }

  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? headers,
  }) async {
    return await _dio.post(
      path,
      data: data,
      options: Options(headers: headers),
    );
  }
}
