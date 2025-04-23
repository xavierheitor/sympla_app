import 'package:dio/dio.dart';
import 'package:sympla_app/core/constants/api_constants.dart';
import 'package:sympla_app/core/logger/app_logger.dart';

class DioClient {
  final Dio _dio;

  DioClient(String? Function() tokenProvider)
      : _dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl)) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = tokenProvider();
          AppLogger.i('🔐 Token: $token');
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
            AppLogger.i('🔐 Token adicionado ao header: $token');
          }
          handler.next(options);
        },
      ),
    );
  }

  // Métodos simplificados
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) {
    return _dio.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(String path, {dynamic data}) {
    return _dio.post(path, data: data);
  }

  Future<Response> put(String path, {dynamic data}) {
    return _dio.put(path, data: data);
  }

  Future<Response> delete(String path) {
    return _dio.delete(path);
  }

  // Expor Dio completo apenas se necessário
  Dio get client => _dio;
}
