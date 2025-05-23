// ========================
// auth_service.dart
// ========================
import 'package:sympla_app/core/domain/repositories/abstracts/usuario_repository.dart';
import 'package:sympla_app/core/domain/dto/usuario_table_dto.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';

class AuthService {
  final UsuarioRepository usuarioRepository;

  AuthService(this.usuarioRepository);

  Future<void> login(String matricula, String senha) async {
    try {
      final response = await usuarioRepository.login(matricula, senha);

      final usuario = UsuarioTableDto(
        uuid: response.uuid,
        nome: response.nome,
        matricula: response.matricula,
        token: response.token,
        refreshToken: response.refreshToken,
        ultimoLogin: DateTime.now(),
      );

      await usuarioRepository.salvarUsuario(usuario);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[auth_service - login] ${erro.mensagem}',
          tag: 'AuthService', error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<void> refreshToken(String refreshToken) async {
    try {
      final response = await usuarioRepository.refreshToken(refreshToken);

      final usuario = UsuarioTableDto(
        uuid: response.uuid,
        nome: response.nome,
        matricula: response.matricula,
        token: response.token,
        refreshToken: response.refreshToken,
        ultimoLogin: DateTime.now(),
      );

      await usuarioRepository.salvarUsuario(usuario);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[auth_service - refresh] ${erro.mensagem}',
          tag: 'AuthService', error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<List<UsuarioTableDto>> getUsuarios() async {
    return await usuarioRepository.buscarTodosUsuarios();
  }

  Future<bool> logout() async {
    try {
      await usuarioRepository.deletarTodosUsuarios();
      return true;
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[auth_service - logout] ${erro.mensagem}',
          tag: 'AuthService', error: e, stackTrace: s);
      return false;
    }
  }
}
