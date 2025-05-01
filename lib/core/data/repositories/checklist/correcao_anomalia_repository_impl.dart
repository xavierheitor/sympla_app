import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/checklist/correcao_anomalia_dao.dart';
import 'package:sympla_app/core/domain/repositories/checklist/correcao_anomalia_repository.dart';

class CorrecaoAnomaliaRepositoryImpl implements CorrecaoAnomaliaRepository {
  final CorrecaoAnomaliaDao dao;
  final AppDatabase db;

  CorrecaoAnomaliaRepositoryImpl({required this.db})
      : dao = db.correcaoAnomaliaDao;

  @override
  Future<List<CorrecaoAnomaliaTableData>> getAll() async {
    try {
      return await dao.getAll();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[CorrecaoAnomaliaRepo - getAll] ${erro.mensagem}',
          tag: 'CorrecaoAnomaliaRepo', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<List<CorrecaoAnomaliaTableData>> getByAtividadeId(
      int atividadeId) async {
    try {
      return await dao.getByAtividadeId(atividadeId);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[CorrecaoAnomaliaRepo - getByAtividadeId] ${erro.mensagem}',
          tag: 'CorrecaoAnomaliaRepo', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<List<CorrecaoAnomaliaTableData>> getByAnomaliaId(
      int anomaliaId) async {
    try {
      return await dao.getByAnomaliaId(anomaliaId);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[CorrecaoAnomaliaRepo - getByAnomaliaId] ${erro.mensagem}',
          tag: 'CorrecaoAnomaliaRepo', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<void> insert(CorrecaoAnomaliaTableCompanion data) async {
    try {
      await dao.insert(data);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[CorrecaoAnomaliaRepo - insert] ${erro.mensagem}',
          tag: 'CorrecaoAnomaliaRepo', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<void> update(CorrecaoAnomaliaTableData data) async {
    try {
      await dao.updateItem(data);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[CorrecaoAnomaliaRepo - update] ${erro.mensagem}',
          tag: 'CorrecaoAnomaliaRepo', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<void> deleteById(int id) async {
    try {
      await dao.deleteById(id);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[CorrecaoAnomaliaRepo - deleteById] ${erro.mensagem}',
          tag: 'CorrecaoAnomaliaRepo', error: e, stackTrace: s);
      rethrow;
    }
  }
}
