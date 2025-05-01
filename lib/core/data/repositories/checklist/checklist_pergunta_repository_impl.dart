import 'package:drift/drift.dart';
import 'package:sympla_app/core/constants/api_constants.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/checklist/checklist_pergunta_dao.dart';
import 'package:sympla_app/core/domain/repositories/checklist/checklist_pergunta_repository.dart';

class ChecklistPerguntaRepositoryImpl implements ChecklistPerguntaRepository {
  final ChecklistPerguntaDao dao;
  final DioClient dio;
  final AppDatabase db;

  ChecklistPerguntaRepositoryImpl({required this.dio, required this.db})
      : dao = db.checklistPerguntaDao;

  @override
  Future<List<ChecklistPerguntaTableData>> getAll() async {
    try {
      return await dao.getAll();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[ChecklistPerguntaRepositoryImpl - getAll] ${erro.mensagem}',
          tag: 'ChecklistPerguntaRepositoryImpl', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<void> insert(ChecklistPerguntaTableCompanion data) async {
    try {
      await dao.insert(data);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[ChecklistPerguntaRepositoryImpl - insert] ${erro.mensagem}',
          tag: 'ChecklistPerguntaRepositoryImpl', error: e, stackTrace: s);
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
          '[ChecklistPerguntaRepositoryImpl - deleteById] ${erro.mensagem}',
          tag: 'ChecklistPerguntaRepositoryImpl',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<void> clearAll() async {
    try {
      // await dao.clearAll();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[ChecklistPerguntaRepositoryImpl - clearAll] ${erro.mensagem}',
          tag: 'ChecklistPerguntaRepositoryImpl',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<List<ChecklistPerguntaTableCompanion>> buscarDaApi() async {
    try {
      final response = await dio.get(ApiConstants.checklistPerguntas);
      final dados = response.data as List;

      return dados.map((json) {
        return ChecklistPerguntaTableCompanion.insert(
          id: Value(json['id'] as int),
          uuid: json['uuid'] as String,
          pergunta: json['pergunta'] as String,
          createdAt: DateTime.parse(json['created_at']),
          updatedAt: DateTime.parse(json['updated_at']),
          sincronizado: const Value(true),
        );
      }).toList();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[ChecklistPerguntaRepositoryImpl - buscarDaApi] ${erro.mensagem}',
          tag: 'ChecklistPerguntaRepositoryImpl',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<void> salvarNoBanco(
      List<ChecklistPerguntaTableCompanion> dados) async {
    try {
      await dao.sincronizarComApi(dados);
      AppLogger.d('💾 ChecklistPergunta sincronizado com sucesso');
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[ChecklistPerguntaRepositoryImpl - salvarNoBanco] ${erro.mensagem}',
          tag: 'ChecklistPerguntaRepositoryImpl',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }
}
