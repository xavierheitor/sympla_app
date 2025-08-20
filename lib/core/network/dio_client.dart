import 'dart:async';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart' as g;
import 'package:sympla_app/core/constants/api_constants.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/core_app/session/session_manager.dart';

/// Cliente HTTP central com `Dio`, incluindo:
///
/// - Base URL e timeouts padrão (ver `ApiConstants`)
/// - Interceptor para anexar Bearer Token da sessão
/// - Logging de request/response via `AppLogger`
/// - Tratamento de erro padronizado e tentativa de refresh de token (401)
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
          // Evita logar tokens em claro
          final headersSafe = Map.of(options.headers);
          if (headersSafe.containsKey('Authorization')) {
            headersSafe['Authorization'] = 'Bearer ***';
          }
          AppLogger.v('🔹 Headers: $headersSafe');
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
          final tipo = error.type;
          final options = error.requestOptions;
          final session = g.Get.find<SessionManager>();

          // número de tentativas de refresh para esta request
          int retryCount = (options.extra['refreshAttempts'] ?? 0) as int;

          // Autenticação expirada/negada → tenta fluxo de refresh controlado
          if (status == 401) {
            if (retryCount >= ApiConstants.maxRefreshAttempts) {
              AppLogger.e(
                  '❌ Máximo de tentativas de refresh atingido para $uri');
              await session.logout();
              g.Get.offAllNamed('/login');
              return handler.next(error);
            }

            if (_isRefreshing) {
              AppLogger.d('🔄 Aguardando outra renovação de token');
              try {
                await _refreshCompleter?.future
                    .timeout(const Duration(seconds: 5));
                final newToken = session.tokenSync;
                if (newToken != null && newToken.isNotEmpty) {
                  options.headers['Authorization'] = 'Bearer $newToken';
                  options.extra['refreshAttempts'] = retryCount + 1;
                  final retryResponse = await _dio.fetch(options);
                  return handler.resolve(retryResponse);
                }
              } catch (_) {
                return handler.next(error);
              }
            }

            AppLogger.w(
                '🔁 Tentando renovar token... (tentativa ${retryCount + 1})');
            _isRefreshing = true;
            _refreshCompleter = Completer();

            try {
              final refreshToken = session.usuario?.refreshToken;
              if (refreshToken == null || refreshToken.isEmpty) {
                throw Exception('Refresh token ausente');
              }

              await session.authService
                  .refreshToken(refreshToken)
                  .timeout(const Duration(seconds: 5));

              _refreshCompleter?.complete();
              _isRefreshing = false;

              final newToken = session.tokenSync;
              if (newToken != null && newToken.isNotEmpty) {
                options.headers['Authorization'] = 'Bearer $newToken';
                options.extra['refreshAttempts'] = retryCount + 1;
                AppLogger.d('🔁 Retentando requisição após refresh');
                final retryResponse = await _dio.fetch(options);
                return handler.resolve(retryResponse);
              }
            } catch (e, s) {
              if (!(_refreshCompleter?.isCompleted ?? true)) {
                _refreshCompleter?.completeError(e, s);
              }
              _isRefreshing = false;

              AppLogger.e('🚫 Falha ao renovar token. Forçando logout.',
                  error: e, stackTrace: s);
              await session.logout();
              g.Get.offAllNamed('/login');
            }

            return handler.next(error);
          }

          // Tratamento genérico de erros de rede
          String mensagem;
          switch (tipo) {
            case dio.DioExceptionType.connectionTimeout:
            case dio.DioExceptionType.sendTimeout:
            case dio.DioExceptionType.receiveTimeout:
              mensagem = 'Tempo de conexão esgotado';
              break;
            case dio.DioExceptionType.connectionError:
              mensagem = 'Falha de conexão: verifique sua internet';
              break;
            case dio.DioExceptionType.badResponse:
              mensagem = status == 500
                  ? 'Erro interno no servidor (500)'
                  : 'Erro do servidor: status $status';
              break;
            case dio.DioExceptionType.cancel:
              mensagem = 'Requisição cancelada';
              break;
            case dio.DioExceptionType.unknown:
              mensagem = 'Erro desconhecido de rede';
              break;
            case dio.DioExceptionType.badCertificate:
              mensagem = 'Certificado SSL inválido';
              break;
          }

          AppLogger.e('❌ [API ERROR]');
          AppLogger.e('🔻 Status: $status');
          AppLogger.e('🔻 URL: $uri');
          AppLogger.e('🔻 Tipo: $tipo');
          AppLogger.e('🔻 Mensagem tratada: $mensagem');
          AppLogger.v('🔻 Body: ${error.response?.data}');

          return handler.reject(
            dio.DioException(
              requestOptions: options,
              error: mensagem,
              type: tipo,
              response: error.response,
            ),
          );
        },
      ),
    );
  }

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

  dio.Dio get client => _dio;
}
