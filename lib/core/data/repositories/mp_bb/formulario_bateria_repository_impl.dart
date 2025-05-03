import 'package:sympla_app/core/domain/repositories/mp_bb/formulario_bateria_repository.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/mp_bb/formulario_bateria_dao.dart';

class FormularioBateriaRepositoryImpl implements FormularioBateriaRepository {
  final FormularioBateriaDao dao;
  final AppDatabase db;

  FormularioBateriaRepositoryImpl({required this.db})
      : dao = db.formularioBateriaDao;

  @override
  Future<List<FormularioBateriaTableData>> getAll() async {
    try {
      return await dao.getAll();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[FormularioBateriaRepositoryImpl - getAll] ${erro.mensagem}',
          tag: 'FormularioBateriaRepositoryImpl', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<List<FormularioBateriaTableData>> getByAtividadeId(
      int atividadeId) async {
    try {
      return await dao.getByAtividadeId(atividadeId);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[FormularioBateriaRepositoryImpl - getByAtividadeId] ${erro.mensagem}',
          tag: 'FormularioBateriaRepositoryImpl',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<int> insert(FormularioBateriaTableCompanion data) async {
    try {
      return await dao.insert(data);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[FormularioBateriaRepositoryImpl - insert] ${erro.mensagem}',
          tag: 'FormularioBateriaRepositoryImpl', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<void> update(FormularioBateriaTableData data) async {
    try {
      await dao.updateItem(data);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[FormularioBateriaRepositoryImpl - update] ${erro.mensagem}',
          tag: 'FormularioBateriaRepositoryImpl', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<void> deleteById(int id) async {
    try {
      await dao.deleteById(id);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[FormularioBateriaRepositoryImpl - deleteById] ${erro.mensagem}',
          tag: 'FormularioBateriaRepositoryImpl',
          error: e,
          stackTrace: s);
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
          '[FormularioBateriaRepositoryImpl - deleteByAtividadeId] ${erro.mensagem}',
          tag: 'FormularioBateriaRepositoryImpl',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<void> insertAll(List<FormularioBateriaTableCompanion> data) async {
    try {
      await dao.insertAll(data);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[FormularioBateriaRepositoryImpl - insertAll] ${erro.mensagem}',
          tag: 'FormularioBateriaRepositoryImpl',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }
}
