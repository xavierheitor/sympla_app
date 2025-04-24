import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart' as g;
import 'package:sympla_app/core/constants/api_constants.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/session/session_manager.dart';
import 'package:sympla_app/core/errors/error_handler.dart';

class DioClient {
  final dio.Dio _dio;

  DioClient()
      : _dio = dio.Dio(
          dio.BaseOptions(
            baseUrl: ApiConstants.baseUrl,
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
          ),
        ) {
    _dio.interceptors.add(
      dio.InterceptorsWrapper(
        onRequest: (options, handler) {
          final sessionManager = g.Get.find<SessionManager>();
          final token = sessionManager.tokenSync;

          AppLogger.v(
              '➡️ [API] REQUEST: [${options.method}] ${options.baseUrl}${options.path}');
          AppLogger.v('🔍 [API] Headers: ${options.headers}');
          AppLogger.v('🔍 [API] Body: ${options.data}');

          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
            AppLogger.d('🔐 Token adicionado ao header');
          } else {
            AppLogger.d('🔐 Token ausente');
          }

          options.headers['Content-Type'] = 'application/json';
          handler.next(options);
        },
        onResponse: (response, handler) {
          AppLogger.i(
              '✅ [API] RESPONSE: [${response.statusCode}] ${response.requestOptions.uri}');
          AppLogger.v('🔍 [API] Response Data: ${response.data}');
          handler.next(response);
        },
        onError: (error, handler) {
          final status = error.response?.statusCode;
          final uri = error.requestOptions.uri;

          AppLogger.e('❌ [API] ❌ ERROR: [$status] $uri',
              error: error, stackTrace: error.stackTrace);
          if (error.response != null) {
            AppLogger.v(
                '🔍 [API] Error Response Body: ${error.response?.data}');
          }

          handler.next(error);
        },
      ),
    );
  }

  // Métodos padronizados com try/catch
  Future<dio.Response> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      return await _dio.get(path, queryParameters: queryParameters);
    } catch (e, s) {
      throw ErrorHandler.tratar(e, s);
    }
  }

  Future<dio.Response> post(String path, {dynamic data}) async {
    try {
      AppLogger.d('➡️ [API] POST: $path');
      return await _dio.post(path, data: data);
    } catch (e, s) {
      throw ErrorHandler.tratar(e, s);
    }
  }

  Future<dio.Response> put(String path, {dynamic data}) async {
    try {
      return await _dio.put(path, data: data);
    } catch (e, s) {
      throw ErrorHandler.tratar(e, s);
    }
  }

  Future<dio.Response> delete(String path) async {
    try {
      return await _dio.delete(path);
    } catch (e, s) {
      throw ErrorHandler.tratar(e, s);
    }
  }

  dio.Dio get client => _dio;
}
