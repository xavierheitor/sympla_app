import 'package:sympla_app/core/domain/repositories/mp_dj/medicao_pressao_sf6_repository.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/mp_dj/medicao_pressao_sf6_dao.dart';

class MedicaoPressaoSf6RepositoryImpl implements MedicaoPressaoSf6Repository {
  final MedicaoPressaoSf6Dao dao;
  final AppDatabase db;

  MedicaoPressaoSf6RepositoryImpl({required this.db})
      : dao = db.medicaoPressaoSf6Dao;

  @override
  Future<List<MedicaoPressaoSf6TableData>> getByFormularioId(
      int formularioId) async {
    try {
      return await dao.getByFormularioId(formularioId);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[MedicaoPressaoSf6RepositoryImpl - getByFormularioId] ${erro.mensagem}',
          tag: 'MedicaoPressaoSf6RepositoryImpl',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<int> insert(MedicaoPressaoSf6TableCompanion data) async {
    try {
      return await db.into(db.medicaoPressaoSf6Table).insert(data);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[MedicaoPressaoSf6RepositoryImpl - insert] ${erro.mensagem}',
          tag: 'MedicaoPressaoSf6RepositoryImpl', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<void> insertAll(List<MedicaoPressaoSf6TableCompanion> data) async {
    try {
      await dao.insertAll(data);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[MedicaoPressaoSf6RepositoryImpl - insertAll] ${erro.mensagem}',
          tag: 'MedicaoPressaoSf6RepositoryImpl',
          error: e,
          stackTrace: s);
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
          '[MedicaoPressaoSf6RepositoryImpl - deleteByFormularioId] ${erro.mensagem}',
          tag: 'MedicaoPressaoSf6RepositoryImpl',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }
}
