import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/checklist/checklist_resposta_dao.dart';
import 'package:sympla_app/core/domain/repositories/checklist/checklist_resposta_repository.dart';

class ChecklistRespostaRepositoryImpl implements ChecklistRespostaRepository {
  final ChecklistRespostaDao dao;

  ChecklistRespostaRepositoryImpl({required AppDatabase db})
      : dao = db.checklistRespostaDao;

  @override
  Future<List<ChecklistRespostaTableData>> getAll() async {
    try {
      return await dao.getAll();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[ChecklistRespostaRepositoryImpl - getAll] ${erro.mensagem}',
          tag: 'ChecklistRespostaRepositoryImpl', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<List<ChecklistRespostaTableData>> getByAtividadeId(
      int atividadeId) async {
    try {
      return await dao.getByAtividadeId(atividadeId);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[ChecklistRespostaRepositoryImpl - getByAtividadeId] ${erro.mensagem}',
          tag: 'ChecklistRespostaRepositoryImpl',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<void> insert(ChecklistRespostaTableCompanion data) async {
    try {
      await dao.insert(data);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[ChecklistRespostaRepositoryImpl - insert] ${erro.mensagem}',
          tag: 'ChecklistRespostaRepositoryImpl', error: e, stackTrace: s);
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
          '[ChecklistRespostaRepositoryImpl - deleteByAtividadeId] ${erro.mensagem}',
          tag: 'ChecklistRespostaRepositoryImpl',
          error: e,
          stackTrace: s);
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
          '[ChecklistRespostaRepositoryImpl - deleteById] ${erro.mensagem}',
          tag: 'ChecklistRespostaRepositoryImpl',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }
}
