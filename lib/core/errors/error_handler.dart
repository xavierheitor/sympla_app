import 'package:dio/dio.dart';
import 'package:sympla_app/core/errors/app_exception.dart';

class ErrorHandler {
  static AppException tratar(dynamic error, [StackTrace? stack]) {
    if (error is AppException) return error;

    if (error is DioException) {
      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.unknown) {
        return NetworkException("Sem conexão com a internet", stack);
      }

      final statusCode = error.response?.statusCode;
      final message = error.response?.data?["message"] ?? "Erro desconhecido";

      return ApiException(message, statusCode: statusCode, stack: stack);
    }

    return LocalException("Erro inesperado", stack);
  }
}
