import 'package:sympla_app/core/domain/repositories/mp_dj/prev_disj_form_repository.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/mp_dj/prev_disj_form_dao.dart';

class PrevDisjFormRepositoryImpl implements PrevDisjFormRepository {
  final PrevDisjFormDao dao;
  final AppDatabase db;

  PrevDisjFormRepositoryImpl({required this.db}) : dao = db.prevDisjFormDao;

  @override
  Future<List<PrevDisjFormData>> getAll() async {
    try {
      return await dao.getAll();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[PrevDisjFormRepositoryImpl - getAll] ${erro.mensagem}',
          tag: 'PrevDisjFormRepositoryImpl', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<PrevDisjFormData?> getByAtividadeId(int atividadeId) async {
    try {
      return await dao.getByAtividadeId(atividadeId);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[PrevDisjFormRepositoryImpl - getByAtividadeId] ${erro.mensagem}',
          tag: 'PrevDisjFormRepositoryImpl',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<int> insert(PrevDisjFormCompanion data) async {
    try {
      return await dao.insert(data);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[PrevDisjFormRepositoryImpl - insert] ${erro.mensagem}',
          tag: 'PrevDisjFormRepositoryImpl', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<void> insertAll(List<PrevDisjFormCompanion> data) async {
    try {
      await dao.insertAll(data);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[PrevDisjFormRepositoryImpl - insertAll] ${erro.mensagem}',
          tag: 'PrevDisjFormRepositoryImpl', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<void> update(PrevDisjFormData data) async {
    try {
      await dao.updateItem(data);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[PrevDisjFormRepositoryImpl - update] ${erro.mensagem}',
          tag: 'PrevDisjFormRepositoryImpl', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<void> deleteById(int id) async {
    try {
      await dao.deleteById(id);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[PrevDisjFormRepositoryImpl - deleteById] ${erro.mensagem}',
          tag: 'PrevDisjFormRepositoryImpl', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<void> deleteByAtividadeId(int atividadeId) async {
    try {
      await dao.deleteByAtividadeId(atividadeId);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[PrevDisjFormRepositoryImpl - deleteByAtividadeId] ${erro.mensagem}',
          tag: 'PrevDisjFormRepositoryImpl',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }
}
