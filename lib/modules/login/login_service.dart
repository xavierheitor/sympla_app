import 'package:sympla_app/core/core_app/services/auth_service.dart';
import 'package:sympla_app/core/domain/dto/usuario_table_dto.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/usuario_repository.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';

class LoginService {
  final UsuarioRepository usuarioRepository;
  final AuthService authService;

  LoginService(this.authService, this.usuarioRepository);

  // Login
  Future<void> login(String matricula, String senha) async {
    try {
      final response = await authService.login(matricula, senha);

      final usuario = UsuarioTableDto(
        uuid: response.id,
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

  // Refresh
  Future<void> refresh(String token) async {
    try {
      final response = await authService.refresh(token);

      final usuario = UsuarioTableDto(
        uuid: response.id,
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

  Future<UsuarioTableDto?> buscarUsuarioPorMatricula(String matricula) async {
    try {
      final usuario =
          await usuarioRepository.buscarUsuarioPorMatricula(matricula);
      if (usuario == null) {
        throw Exception("Usuário não encontrado");
      }
      return usuario;
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[Buscar por matrícula] ${erro.mensagem}',
          tag: 'UsuarioService', error: e, stackTrace: s);
      rethrow;
    }
  }
}
