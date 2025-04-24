sealed class AppException implements Exception {
  final String mensagem;
  final StackTrace? stack;

  AppException(this.mensagem, [this.stack]);
}

class ApiException extends AppException {
  final int? statusCode;
  ApiException(String mensagem, {this.statusCode, StackTrace? stack})
      : super(mensagem, stack);
}

class NetworkException extends AppException {
  NetworkException(super.mensagem, [super.stack]);
}

class AuthException extends AppException {
  AuthException(super.mensagem, [super.stack]);
}

class LocalException extends AppException {
  LocalException(super.mensagem, [super.stack]);
}
