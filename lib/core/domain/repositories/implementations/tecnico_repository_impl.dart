import 'package:sympla_app/core/domain/dto/tecnico_table_dto.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/tecnico_repository.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/tecnico_dao.dart';

class TecnicoRepositoryImpl implements TecnicoRepository {
  final AppDatabase db;
  final TecnicoDao tecnicoDao;
  final DioClient dio;

  TecnicoRepositoryImpl(this.db, this.dio) : tecnicoDao = db.tecnicoDao;

  @override
  Future<TecnicoTableDto?> buscarTecnico(String tecnicoId) async {
    try {
      final tecnico = await tecnicoDao.buscarPorId(tecnicoId);
      return tecnico != null ? TecnicoTableDto.fromData(tecnico) : null;
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
        '[tecnico_repository_impl - buscarTecnico] ${erro.mensagem}',
        tag: 'TecnicoRepositoryImpl',
        error: e,
        stackTrace: s,
      );
      return null;
    }
  }

  @override
  Future<List<TecnicoTableDto>> buscarTodosTecnicos() async {
    try {
      final tecnicos = await tecnicoDao.buscarTodos();
      return tecnicos.map(TecnicoTableDto.fromData).toList();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
        '[tecnico_repository_impl - buscarTodosTecnicos] ${erro.mensagem}',
        tag: 'TecnicoRepositoryImpl',
        error: e,
        stackTrace: s,
      );
      return [];
    }
  }

  @override
  Future<void> deletarTodosTecnicos() async {
    try {
      await tecnicoDao.deletarTodos();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
        '[tecnico_repository_impl - deletarTodosTecnicos] ${erro.mensagem}',
        tag: 'TecnicoRepositoryImpl',
        error: e,
        stackTrace: s,
      );
    }
  }
}
