import 'dart:async';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart' as g;
import 'package:sympla_app/core/constants/api_constants.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/session/session_manager.dart';

class DioClient {
  final dio.Dio _dio;
  bool _isRefreshing = false;
  Completer<void>? _refreshCompleter;

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
          }

          options.headers['Content-Type'] = 'application/json';

          AppLogger.v('➡️ [API REQUEST]');
          AppLogger.v('🔹 Method: ${options.method}');
          AppLogger.v('🔹 URL: ${options.uri}');
          AppLogger.v('🔹 Headers: ${options.headers}');
          AppLogger.v('🔹 Body: ${options.data}');

          handler.next(options);
        },
        onResponse: (response, handler) {
          AppLogger.i('✅ [API RESPONSE]');
          AppLogger.v('🔸 Status: ${response.statusCode}');
          AppLogger.v('🔸 URL: ${response.requestOptions.uri}');
          AppLogger.v('🔸 Data: ${response.data}');
          handler.next(response);
        },
        onError: (error, handler) async {
          final status = error.response?.statusCode ?? 0;
          final uri = error.requestOptions.uri;

          if (status != 401) {
            final tratado = ErrorHandler.tratar(error, error.stackTrace);
            AppLogger.e('❌ [API ERROR]');
            AppLogger.e('🔻 Status: $status');
            AppLogger.e('🔻 URL: $uri');
            AppLogger.e('🔻 Mensagem tratada: ${tratado.mensagem}');
            if (error.response != null) {
              AppLogger.v('🔻 Body: ${error.response?.data}');
            }
            return handler.next(error);
          }

          // 401 - tentativa de renovar token
          final session = g.Get.find<SessionManager>();

          if (_isRefreshing) {
            AppLogger.d('🔄 Renovação de token já em andamento');
            try {
              await _refreshCompleter?.future
                  .timeout(const Duration(seconds: 5));
              final newToken = session.tokenSync;
              if (newToken != null && newToken.isNotEmpty) {
                error.requestOptions.headers['Authorization'] =
                    'Bearer $newToken';
                final retryResponse = await _dio.fetch(error.requestOptions);
                return handler.resolve(retryResponse);
              }
            } catch (_) {
              return handler.next(error);
            }
          }

          AppLogger.w('🔁 Tentando renovar token...');
          _isRefreshing = true;
          _refreshCompleter = Completer();

          try {
            final refreshToken = session.usuario?.refreshToken;
            if (refreshToken == null || refreshToken.isEmpty) {
              throw Exception('Refresh token ausente');
            }

            await session.authService
                .refresh(refreshToken)
                .timeout(const Duration(seconds: 5));

            _refreshCompleter?.complete();
            _isRefreshing = false;

            final newToken = session.tokenSync;
            if (newToken != null && newToken.isNotEmpty) {
              error.requestOptions.headers['Authorization'] =
                  'Bearer $newToken';
              final retryResponse = await _dio.fetch(error.requestOptions);
              return handler.resolve(retryResponse);
            }
          } catch (e, s) {
            _refreshCompleter?.completeError(e, s);
            _isRefreshing = false;

            AppLogger.e('🚫 Falha ao renovar token. Forçando logout.',
                error: e, stackTrace: s);

            await session.logout();
            g.Get.offAllNamed('/login');
          }

          return handler.next(error);
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
