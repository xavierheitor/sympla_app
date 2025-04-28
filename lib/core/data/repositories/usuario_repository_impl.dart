import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/usuario_dao.dart';
import 'package:sympla_app/core/domain/repositories/usuario_repository.dart';

class UsuarioRepositoryImpl implements UsuarioRepository {
  final UsuarioDao dao;
  final AppDatabase db;

  UsuarioRepositoryImpl(this.db) : dao = db.usuarioDao;

  @override
  Future<UsuarioTableData?> buscarPorMatricula(String matricula) async {
    try {
      return dao.buscarPorMatricula(matricula);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[buscarPorMatricula] ${erro.mensagem}',
          tag: 'UsuarioRepositoryImpl', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<int> salvarUsuario(UsuarioTableCompanion usuario) async {
    try {
      return dao.salvarUsuario(usuario);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[salvarUsuario] ${erro.mensagem}',
          tag: 'UsuarioRepositoryImpl', error: e, stackTrace: s);
      rethrow;
    }
  }
}
