// ======== Implementação: ChecklistPerguntaRelacionamentoRepositoryImpl ========

import 'package:drift/drift.dart';
import 'package:sympla_app/core/constants/api_constants.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/checklist/checklist_pergunta_relacionamento_dao.dart';
import 'package:sympla_app/core/domain/repositories/checklist/checklist_pergunta_relacionamento_repository.dart';

class ChecklistPerguntaRelacionamentoRepositoryImpl
    implements ChecklistPerguntaRelacionamentoRepository {
  final ChecklistPerguntaRelacionamentoDao dao;
  final DioClient dio;
  final AppDatabase db;

  ChecklistPerguntaRelacionamentoRepositoryImpl(
      {required this.dio, required this.db})
      : dao = db.checklistPerguntaRelacionamentoDao;

  @override
  Future<List<ChecklistPerguntaRelacionamentoTableData>> buscarTodos() async {
    try {
      return await dao.getAll();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[ChecklistPerguntaRelacionamentoRepositoryImpl - buscarTodos] ${erro.mensagem}',
          tag: 'ChecklistPerguntaRelacionamentoRepositoryImpl',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<List<ChecklistPerguntaRelacionamentoTableCompanion>>
      buscarDaApi() async {
    try {
      final response =
          await dio.get(ApiConstants.checklistPerguntasRelacionamentos);
      final dados = response.data as List;

      return dados.map((json) {
        return ChecklistPerguntaRelacionamentoTableCompanion.insert(
          id: Value(json['id'] as int),
          uuid: json['uuid'] as String,
          checklistId: json['checklist_id'] as int,
          grupoId: json['grupo_id'] as int,
          subgrupoId: json['subgrupo_id'] as int,
          perguntaId: json['pergunta_id'] as int,
          createdAt: DateTime.parse(json['created_at']),
          updatedAt: DateTime.parse(json['updated_at']),
          sincronizado: const Value(true),
        );
      }).toList();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[ChecklistPerguntaRelacionamentoRepositoryImpl - buscarDaApi] ${erro.mensagem}',
          tag: 'ChecklistPerguntaRelacionamentoRepositoryImpl',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<void> salvarNoBanco(
      List<ChecklistPerguntaRelacionamentoTableCompanion> dados) async {
    try {
      await dao.sincronizarComApi(dados);
      AppLogger.d(
          '💾 ChecklistPerguntaRelacionamento sincronizado com sucesso');
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[ChecklistPerguntaRelacionamentoRepositoryImpl - salvarNoBanco] ${erro.mensagem}',
          tag: 'ChecklistPerguntaRelacionamentoRepositoryImpl',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<List<ChecklistPerguntaRelacionamentoTableData>> buscarPorChecklistId(
      int checklistId) async {
    try {
      return await dao.getByChecklistId(checklistId);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[ChecklistPerguntaRelacionamentoRepositoryImpl - buscarPorChecklistId] ${erro.mensagem}',
          tag: 'ChecklistPerguntaRelacionamentoRepositoryImpl',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }
}
