import 'package:sympla_app/core/core_app/services/auth_service.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';

class LoginService {
  final AuthService authService;

  LoginService(this.authService);

  // Login
  Future<void> login(String matricula, String senha) async {
    try {
      await authService.login(matricula, senha);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[auth_service - login] ${erro.mensagem}',
          tag: 'AuthService', error: e, stackTrace: s);
      rethrow;
    }
  }

}
