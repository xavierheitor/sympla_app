import 'package:sympla_app/core/domain/repositories/mp_bb/medicao_elemento_bateria_repository.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/mp_bb/medicao_elemento_bateria_dao.dart';

class MedicaoElementoBateriaRepositoryImpl
    implements MedicaoElementoBateriaRepository {
  final MedicaoElementoBateriaDao dao;
  final AppDatabase db;

  MedicaoElementoBateriaRepositoryImpl({required this.db})
      : dao = db.medicaoElementoBateriaDao;

  @override
  Future<List<MedicaoElementoBateriaTableData>> getAll() async {
    try {
      return await dao.getAll();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
        '[MedicaoElementoBateriaRepositoryImpl - getAll] ${erro.mensagem}',
        tag: 'MedicaoElementoBateriaRepositoryImpl',
        error: e,
        stackTrace: s,
      );
      rethrow;
    }
  }

  @override
  Future<List<MedicaoElementoBateriaTableData>> getByFormularioId(
      int formularioId) async {
    try {
      return await dao.getByFormularioId(formularioId);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
        '[MedicaoElementoBateriaRepositoryImpl - getByFormularioId] ${erro.mensagem}',
        tag: 'MedicaoElementoBateriaRepositoryImpl',
        error: e,
        stackTrace: s,
      );
      rethrow;
    }
  }

  @override
  Future<void> insert(MedicaoElementoBateriaTableCompanion data) async {
    try {
      await dao.insert(data);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
        '[MedicaoElementoBateriaRepositoryImpl - insert] ${erro.mensagem}',
        tag: 'MedicaoElementoBateriaRepositoryImpl',
        error: e,
        stackTrace: s,
      );
      rethrow;
    }
  }

  @override
  Future<void> insertAll(
      List<MedicaoElementoBateriaTableCompanion> data) async {
    try {
      await dao.insertAll(data);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
        '[MedicaoElementoBateriaRepositoryImpl - insertAll] ${erro.mensagem}',
        tag: 'MedicaoElementoBateriaRepositoryImpl',
        error: e,
        stackTrace: s,
      );
      rethrow;
    }
  }

  @override
  Future<void> deleteByFormularioId(int formularioId) async {
    try {
      await dao.deleteByFormularioId(formularioId);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
        '[MedicaoElementoBateriaRepositoryImpl - deleteByFormularioId] ${erro.mensagem}',
        tag: 'MedicaoElementoBateriaRepositoryImpl',
        error: e,
        stackTrace: s,
      );
      rethrow;
    }
  }
}
