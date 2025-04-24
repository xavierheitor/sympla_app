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
  NetworkException(super.mensagem, {super.stack}) : super(tipo: TipoErro.api);
}

class AuthException extends AppException {
  AuthException(super.mensagem, {super.stack})
      : super(tipo: TipoErro.credenciais);
}

class LocalException extends AppException {
  LocalException(super.mensagem, {super.stack}) : super(tipo: TipoErro.banco);
}
