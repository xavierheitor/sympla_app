import 'package:sympla_app/core/domain/repositories/mp_dj/medicao_resistencia_isolamento_repository.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/mp_dj/medicao_resistencia_isolamento_dao.dart';

class MedicaoResistenciaIsolamentoRepositoryImpl
    implements MedicaoResistenciaIsolamentoRepository {
  final MedicaoResistenciaIsolamentoDao dao;
  final AppDatabase db;

  MedicaoResistenciaIsolamentoRepositoryImpl({required this.db})
      : dao = db.medicaoResistenciaIsolamentoDao;

  @override
  Future<List<MedicaoResistenciaIsolamentoTableData>> getByFormularioId(
      int formularioId) async {
    try {
      return await dao.getByFormularioId(formularioId);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
        '[MedicaoResistenciaIsolamentoRepositoryImpl - getByFormularioId] ${erro.mensagem}',
        tag: 'MedicaoResistenciaIsolamentoRepositoryImpl',
        error: e,
        stackTrace: s,
      );
      rethrow;
    }
  }

  @override
  Future<int> insert(MedicaoResistenciaIsolamentoTableCompanion data) async {
    try {
      return await db.into(db.medicaoResistenciaIsolamentoTable).insert(data);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
        '[MedicaoResistenciaIsolamentoRepositoryImpl - insert] ${erro.mensagem}',
        tag: 'MedicaoResistenciaIsolamentoRepositoryImpl',
        error: e,
        stackTrace: s,
      );
      rethrow;
    }
  }

  @override
  Future<void> insertAll(
      List<MedicaoResistenciaIsolamentoTableCompanion> data) async {
    try {
      await dao.insertAll(data);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
        '[MedicaoResistenciaIsolamentoRepositoryImpl - insertAll] ${erro.mensagem}',
        tag: 'MedicaoResistenciaIsolamentoRepositoryImpl',
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
        '[MedicaoResistenciaIsolamentoRepositoryImpl - deleteByFormularioId] ${erro.mensagem}',
        tag: 'MedicaoResistenciaIsolamentoRepositoryImpl',
        error: e,
        stackTrace: s,
      );
      rethrow;
    }
  }
}
