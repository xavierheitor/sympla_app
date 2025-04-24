import 'package:sympla_app/core/errors/tipo_erro.dart';

sealed class AppException implements Exception {
  final String mensagem;
  final TipoErro tipo;
  final StackTrace? stack;

  AppException(this.mensagem, {this.tipo = TipoErro.desconhecido, this.stack});
}

class ApiException extends AppException {
  final int? statusCode;
  ApiException(super.mensagem, {this.statusCode, super.stack})
      : super(tipo: TipoErro.api);
}

class NetworkException extends AppException {
  final Uri? uri;
  final int? statusCode;
  final dynamic response;

  NetworkException(
    super.mensagem, {
    this.uri,
    this.statusCode,
    this.response,
    super.stack,
  }) : super(tipo: TipoErro.api);

  @override
  String toString() {
    return 'NetworkException: $mensagem\n→ URL: $uri\n→ Status: $statusCode\n→ Response: $response';
  }
}

class AuthException extends AppException {
  AuthException(super.mensagem, {super.stack})
      : super(tipo: TipoErro.credenciais);
}

class LocalException extends AppException {
  LocalException(super.mensagem, {super.stack}) : super(tipo: TipoErro.banco);
}
