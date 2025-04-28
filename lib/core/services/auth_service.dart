import 'package:drift/drift.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/domain/repositories/auth_repository.dart';
import 'package:sympla_app/core/domain/repositories/usuario_repository.dart';

class AuthService {
  final AuthRepository authRepository;
  final UsuarioRepository usuarioRepository;

  AuthService(this.authRepository, this.usuarioRepository);

  // Login
  Future<void> login(String matricula, String senha) async {
    try {
      final response = await authRepository.login(matricula, senha);

      final usuario = UsuarioTableCompanion(
        id: Value(response.id),
        nome: Value(response.nome),
        matricula: Value(response.matricula),
        token: Value(response.token),
        refreshToken: Value(response.refreshToken),
        ultimoLogin: Value(DateTime.now()),
      );

      await usuarioRepository.salvarUsuario(usuario);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[auth_service - login] ${erro.mensagem}',
          tag: 'AuthService', error: e, stackTrace: s);
      rethrow;
    }
  }

  // Refresh
  Future<void> refresh(String token) async {
    try {
      final response = await authRepository.refreshToken(token);

      final usuario = UsuarioTableCompanion(
        id: Value(response.id),
        nome: Value(response.nome),
        matricula: Value(response.matricula),
        token: Value(response.token),
        refreshToken: Value(response.refreshToken),
        ultimoLogin: Value(DateTime.now()),
      );

      await usuarioRepository.salvarUsuario(usuario);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[auth_service - refresh] ${erro.mensagem}',
          tag: 'AuthService', error: e, stackTrace: s);
      rethrow;
    }
  }
}
