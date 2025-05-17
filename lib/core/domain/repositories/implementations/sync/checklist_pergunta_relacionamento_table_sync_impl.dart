import 'package:sympla_app/core/constants/api_constants.dart';
import 'package:sympla_app/core/domain/dto/checklist/checklist_pergunta_relacionamento_table_dto.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/syncable_repository.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/checklist_dao.dart';

class ChecklistPerguntaRelacionamentoTableSyncImpl
    implements SyncableRepository<ChecklistPerguntaRelacionamentoTableDto> {
  final AppDatabase db;
  final DioClient dio;
  final ChecklistDao checklistDao;

  ChecklistPerguntaRelacionamentoTableSyncImpl(
    this.db,
    this.dio,
  ) : checklistDao = db.checklistDao;
  @override
  Future<List<ChecklistPerguntaRelacionamentoTableDto>> buscarDaApi() async {
    try {
      final response =
          await dio.get(ApiConstants.checklistPerguntasRelacionamentos);
      return (response.data as List)
          .map((e) => ChecklistPerguntaRelacionamentoTableDto.fromJson(e))
          .toList();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
        '[checklist_pergunta_relacionamento_table_sync_impl - buscarDaApi] ${erro.mensagem}',
        tag: 'ChecklistPerguntaRelacionamentoTableSyncImpl',
        error: e,
        stackTrace: s,
      );
      return [];
    }
  }

  @override
  Future<bool> estaVazio(String entidade) async {
    try {
      return await checklistDao.estaVazioChecklistPerguntaRelacionamento();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
        '[checklist_pergunta_relacionamento_table_sync_impl - estaVazio] ${erro.mensagem}',
      );
      return true;
    }
  }
  @override
  Future<void> sincronizarComBanco(
      List<ChecklistPerguntaRelacionamentoTableDto> itens) async {
    try {
      final data = await buscarDaApi();
      final itens = data.map((e) => e.toCompanion()).toList();
      await checklistDao.sincronizarRelacionamentos(itens);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
        '[checklist_pergunta_relacionamento_table_sync_impl - sincronizarComBanco] ${erro.mensagem}',
      );
    }
  }
  @override
  String get nomeEntidade => 'checklist_pergunta_relacionamento';
}
