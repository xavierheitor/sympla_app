import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/domain/repositories/usuario_repository.dart';

class UsuarioService {
  final UsuarioRepository repository;

  UsuarioService(this.repository);

  // Buscar por matrícula
  Future<UsuarioTableData?> buscarPorMatricula(String matricula) async {
    try {
      final usuario = await repository.buscarPorMatricula(matricula);
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
