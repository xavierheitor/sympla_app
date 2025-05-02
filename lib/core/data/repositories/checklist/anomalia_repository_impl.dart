import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/checklist/anomalia_dao.dart';
import 'package:sympla_app/core/domain/repositories/checklist/anomalia_repository.dart';

class AnomaliaRepositoryImpl implements AnomaliaRepository {
  final AnomaliaDao dao;
  final AppDatabase db;

  AnomaliaRepositoryImpl({required this.db}) : dao = db.anomaliaDao;

  @override
  Future<List<AnomaliaTableData>> getAll() async {
    try {
      return await dao.getAll();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AnomaliaRepositoryImpl - getAll] ${erro.mensagem}',
          tag: 'AnomaliaRepositoryImpl', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<List<AnomaliaTableData>> getByAtividadeId(int atividadeId) async {
    try {
      return await dao.getByAtividadeId(atividadeId);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[AnomaliaRepositoryImpl - getByAtividadeId] ${erro.mensagem}',
          tag: 'AnomaliaRepositoryImpl',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<void> insert(AnomaliaTableCompanion data) async {
    try {
      await dao.insert(data);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AnomaliaRepositoryImpl - insert] ${erro.mensagem}',
          tag: 'AnomaliaRepositoryImpl', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<void> update(AnomaliaTableData data) async {
    try {
      await dao.updateItem(data);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AnomaliaRepositoryImpl - update] ${erro.mensagem}',
          tag: 'AnomaliaRepositoryImpl', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<void> deleteById(int id) async {
    try {
      await dao.deleteById(id);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AnomaliaRepositoryImpl - deleteById] ${erro.mensagem}',
          tag: 'AnomaliaRepositoryImpl', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<void> deleteByAtividadeId(int atividadeId) async {
    try {
      await dao.deleteByAtividade(atividadeId);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[AnomaliaRepositoryImpl - deleteByAtividadeId] ${erro.mensagem}',
          tag: 'AnomaliaRepositoryImpl',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<void> insertAll(List<AnomaliaTableCompanion> data) async {
    try {
      await dao.insertAll(data);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AnomaliaRepositoryImpl - insertAll] ${erro.mensagem}',
          tag: 'AnomaliaRepositoryImpl', error: e, stackTrace: s);
      rethrow;
    }
  }
}
