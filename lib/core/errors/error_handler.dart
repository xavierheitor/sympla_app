import 'package:dio/dio.dart';
import 'package:sympla_app/core/errors/app_exception.dart';
import 'package:sympla_app/core/errors/mensagem_erro.dart';
import 'package:sympla_app/core/errors/tipo_erro.dart';

class ErrorHandler {
  static AppException tratar(dynamic error, [StackTrace? stack]) {
    if (error is AppException) return error;

    if (error is DioException) {
      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.unknown) {
        return NetworkException(
          _mensagemParaCodigo(error.response?.statusCode),
          uri: error.requestOptions.uri,
          statusCode: error.response?.statusCode,
          response: error.response?.data,
          stack: stack,
        );
      }

      final statusCode = error.response?.statusCode;
      final message = error.response?.data?['message'] ?? 'Erro desconhecido';

      return ApiException(message, statusCode: statusCode, stack: stack);
    }

    return LocalException('Erro inesperado', stack: stack);
  }

  static MensagemErro mensagemUsuario(Object error) {
    if (error is AppException) {
      switch (error.tipo) {
        case TipoErro.api:
          return MensagemErro(
            titulo: 'Erro de conexão',
            descricao:
                'Não foi possível acessar os servidores. Tente novamente mais tarde.',
          );
        case TipoErro.dados:
          return MensagemErro(
            titulo: 'Erro nos dados',
            descricao: 'Ocorreu um problema ao processar as informações.',
          );
        case TipoErro.credenciais:
          return MensagemErro(
            titulo: 'Credenciais inválidas',
            descricao: 'Matricula ou senha incorretos.',
          );
        default:
          return MensagemErro(
            titulo: 'Erro inesperado',
            descricao: 'Algo deu errado. Tente novamente.',
          );
      }
    }

    return MensagemErro(
      titulo: 'Erro desconhecido',
      descricao: 'Ocorreu um erro inesperado.',
    );
  }

  static String _mensagemParaCodigo(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Requisição inválida';
      case 401:
        return 'Não autorizado';
      case 404:
        return 'Recurso não encontrado';
      case 500:
        return 'Erro interno no servidor';
      default:
        return 'Erro de conexão';
    }
  }
}
