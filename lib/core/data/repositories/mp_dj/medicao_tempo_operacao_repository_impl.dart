import 'package:sympla_app/core/domain/repositories/mp_dj/medicao_tempo_operacao_repository.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/mp_dj/medicao_tempo_operacao_dao.dart';

class MedicaoTempoOperacaoRepositoryImpl
    implements MedicaoTempoOperacaoRepository {
  final MedicaoTempoOperacaoDao dao;
  final AppDatabase db;

  MedicaoTempoOperacaoRepositoryImpl({required this.db})
      : dao = db.medicaoTempoOperacaoDao;

  @override
  Future<List<MedicaoTempoOperacaoTableData>> getByFormularioId(
      int formularioId) async {
    try {
      return await dao.getByFormularioId(formularioId);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
        '[MedicaoTempoOperacaoRepositoryImpl - getByFormularioId] ${erro.mensagem}',
        tag: 'MedicaoTempoOperacaoRepositoryImpl',
        error: e,
        stackTrace: s,
      );
      rethrow;
    }
  }

  @override
  Future<int> insert(MedicaoTempoOperacaoTableCompanion data) async {
    try {
      return await db.into(db.medicaoTempoOperacaoTable).insert(data);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
        '[MedicaoTempoOperacaoRepositoryImpl - insert] ${erro.mensagem}',
        tag: 'MedicaoTempoOperacaoRepositoryImpl',
        error: e,
        stackTrace: s,
      );
      rethrow;
    }
  }

  @override
  Future<void> insertAll(List<MedicaoTempoOperacaoTableCompanion> data) async {
    try {
      await dao.insertAll(data);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
        '[MedicaoTempoOperacaoRepositoryImpl - insertAll] ${erro.mensagem}',
        tag: 'MedicaoTempoOperacaoRepositoryImpl',
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
        '[MedicaoTempoOperacaoRepositoryImpl - deleteByFormularioId] ${erro.mensagem}',
        tag: 'MedicaoTempoOperacaoRepositoryImpl',
        error: e,
        stackTrace: s,
      );
      rethrow;
    }
  }
}
