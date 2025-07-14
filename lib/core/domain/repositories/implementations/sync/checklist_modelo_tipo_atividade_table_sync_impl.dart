import 'package:sympla_app/core/constants/api_constants.dart';
import 'package:sympla_app/core/domain/dto/checklist/checklist_modelo_tipo_atividade_table_dto.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/syncable_repository.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/checklist_dao.dart';

class ChecklistModeloTipoAtividadeTableSyncImpl
    implements SyncableRepository<ChecklistModeloTipoAtividadeTableDto> {
  final AppDatabase db;
  final DioClient dio;
  final ChecklistDao checklistDao;

  ChecklistModeloTipoAtividadeTableSyncImpl(this.db, this.dio)
      : checklistDao = db.checklistDao;

  @override
  Future<List<ChecklistModeloTipoAtividadeTableDto>> buscarDaApi() async {
    try {
      final response = await dio.get(ApiConstants.checklistTipoAtividade);
      return (response.data as List)
          .map((e) => ChecklistModeloTipoAtividadeTableDto.fromJson(e))
          .toList();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[checklist_modelo_tipo_atividade_table_sync_impl - buscarDaApi] ${erro.mensagem}',
          tag: 'ChecklistModeloTipoAtividadeTableSyncImpl',
          error: e,
          stackTrace: s);
      return [];
    }
  }

  @override
  Future<bool> estaVazio(String entidade) async {
    try {
      return await checklistDao.estaVazioChecklistTipoAtividade();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[checklist_modelo_tipo_atividade_table_sync_impl - estaVazio] ${erro.mensagem}',
          tag: 'ChecklistModeloTipoAtividadeTableSyncImpl',
          error: e,
          stackTrace: s);
      return true;
    }
  }

  @override
  String get nomeEntidade => 'checklist_modelo_tipo_atividade';

  @override
  Future<void> sincronizarComBanco(
      List<ChecklistModeloTipoAtividadeTableDto> itens) async {
    try {
      final data = await buscarDaApi();
      final itens = data.map((e) => e.toCompanion()).toList();
      await checklistDao.sincronizarChecklistTipoAtividade(itens);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[checklist_modelo_tipo_atividade_table_sync_impl - sincronizarComBanco] ${erro.mensagem}',
          tag: 'ChecklistModeloTipoAtividadeTableSyncImpl',
          error: e,
          stackTrace: s);
    }
  }
}
