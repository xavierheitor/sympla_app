import 'package:sympla_app/core/domain/repositories/mp_dj/medicao_resistencia_contato_repository.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/mp_dj/medicao_resistencia_contato_dao.dart';

class MedicaoResistenciaContatoRepositoryImpl
    implements MedicaoResistenciaContatoRepository {
  final MedicaoResistenciaContatoDao dao;
  final AppDatabase db;

  MedicaoResistenciaContatoRepositoryImpl({required this.db})
      : dao = db.medicaoResistenciaContatoDao;

  @override
  Future<List<MedicaoResistenciaContatoTableData>> getByFormularioId(
      int formularioId) async {
    try {
      return await dao.getByFormularioId(formularioId);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
        '[MedicaoResistenciaContatoRepositoryImpl - getByFormularioId] ${erro.mensagem}',
        tag: 'MedicaoResistenciaContatoRepositoryImpl',
        error: e,
        stackTrace: s,
      );
      rethrow;
    }
  }

  @override
  Future<int> insert(MedicaoResistenciaContatoTableCompanion data) async {
    try {
      return await db.into(db.medicaoResistenciaContatoTable).insert(data);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
        '[MedicaoResistenciaContatoRepositoryImpl - insert] ${erro.mensagem}',
        tag: 'MedicaoResistenciaContatoRepositoryImpl',
        error: e,
        stackTrace: s,
      );
      rethrow;
    }
  }

  @override
  Future<void> insertAll(
      List<MedicaoResistenciaContatoTableCompanion> data) async {
    try {
      await dao.insertAll(data);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
        '[MedicaoResistenciaContatoRepositoryImpl - insertAll] ${erro.mensagem}',
        tag: 'MedicaoResistenciaContatoRepositoryImpl',
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
        '[MedicaoResistenciaContatoRepositoryImpl - deleteByFormularioId] ${erro.mensagem}',
        tag: 'MedicaoResistenciaContatoRepositoryImpl',
        error: e,
        stackTrace: s,
      );
      rethrow;
    }
  }
}
