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

          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
            AppLogger.d('🔐 Token adicionado ao header');
          } else {
            AppLogger.d('🔐 Token ausente');
          }

          AppLogger.v('➡️ [API REQUEST]');
          AppLogger.v('🔹 Method: ${options.method}');
          AppLogger.v('🔹 URL: ${options.baseUrl}${options.path}');
          AppLogger.v('🔹 Headers: ${options.headers}');
          AppLogger.v('🔹 Body: ${options.data}');

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
          AppLogger.i('✅ [API RESPONSE]');
          AppLogger.v('🔸 Status: ${response.statusCode}');
          AppLogger.v('🔸 URL: ${response.requestOptions.uri}');
          AppLogger.v('🔸 Data: ${response.data}');
          handler.next(response);
        },
        onError: (error, handler) {
          final status = error.response?.statusCode;
          final uri = error.requestOptions.uri;

          final tratado = ErrorHandler.tratar(error, error.stackTrace);

          AppLogger.e('❌ [API ERROR]');
          AppLogger.e('🔻 Status: $status');
          AppLogger.e('🔻 URL: $uri');
          AppLogger.e('🔻 StatusCode: ${error.response?.statusCode}');
          AppLogger.e('🔻 Mensagem tratada: ${tratado.mensagem}',
              error: error, stackTrace: error.stackTrace);

          if (error.response != null) {
            AppLogger.v('🔻 Body: ${error.response?.data}');
          }

          handler.next(error);
        },
      ),
    );
  }

  // Métodos HTTP com tratamento de erro
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
      AppLogger.d('➡️ [API CALL] POST: $path');
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
