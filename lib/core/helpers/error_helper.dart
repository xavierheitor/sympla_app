import 'package:dio/dio.dart';

class ErrorHelper {
  static String getUserMessage(dynamic error) {
    if (error is DioException) {
      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.receiveTimeout ||
          error.type == DioExceptionType.sendTimeout) {
        return 'Tempo de conexão excedido. Verifique sua internet.';
      }

      if (error.response != null) {
        final status = error.response?.statusCode ?? 0;

        if (status == 401 || status == 403) {
          return 'Matrícula ou senha inválidos.';
        }

        if (status >= 500) {
          return 'Erro no servidor. Tente novamente mais tarde.';
        }

        return 'Erro ao processar a requisição.';
      }

      return 'Erro de conexão. Verifique sua internet.';
    }

    // Outros erros locais
    return 'Ocorreu um erro inesperado.';
  }
}
