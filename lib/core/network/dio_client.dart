import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart' as g;
import 'package:sympla_app/core/constants/api_constants.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/session/session_manager.dart';

class DioClient {
  final dio.Dio _dio;

  DioClient(String? Function() tokenProvider)
      : _dio = dio.Dio(dio.BaseOptions(baseUrl: ApiConstants.baseUrl)) {
    _dio.interceptors.add(
      dio.InterceptorsWrapper(
        onRequest: (options, handler) {
          // // Só adiciona token se não for login ou refresh
          // final isAuthRoute = options.path.contains('/auth/login') ||
          //     options.path.contains('/auth/refresh');

          // if (!isAuthRoute) {
          //   final sessionManager = g.Get.find<SessionManager>();
          //   final token = sessionManager.tokenSync;

          //   AppLogger.d('🔐 Token: $token');

          //   if (token != null && token.isNotEmpty) {
          //     options.headers['Authorization'] = 'Bearer $token';
          //   }
          // }
          final sessionManager = g.Get.find<SessionManager>();
          final token = sessionManager.tokenSync;

          AppLogger.d('🔐 Token: $token');

          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
            options.headers['Content-Type'] = 'application/json';
            AppLogger.d('🔐 Token adicionado ao header: $token');
          } else {
            AppLogger.d('🔐 Token não adicionado ao header: $token');
          }

          handler.next(options);
        },
      ),
    );
  }

  // Métodos simplificados
  Future<dio.Response> get(String path,
      {Map<String, dynamic>? queryParameters}) {
    return _dio.get(path, queryParameters: queryParameters);
  }

  Future<dio.Response> post(String path, {dynamic data}) {
    return _dio.post(path, data: data);
  }

  Future<dio.Response> put(String path, {dynamic data}) {
    return _dio.put(path, data: data);
  }

  Future<dio.Response> delete(String path) {
    return _dio.delete(path);
  }

  // Expor Dio completo apenas se necessário
  dio.Dio get client => _dio;
}
