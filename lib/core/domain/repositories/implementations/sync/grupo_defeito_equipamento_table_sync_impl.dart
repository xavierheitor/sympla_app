import 'package:sympla_app/core/constants/api_constants.dart';
import 'package:sympla_app/core/domain/dto/grupo_defeito_equipamento/grupo_defeito_equipamento_table_dto.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/syncable_repository.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/defeito_dao.dart';

class GrupoDefeitoEquipamentoTableSyncImpl
    implements SyncableRepository<GrupoDefeitoEquipamentoTableDto> {
  final AppDatabase db;
  final DioClient dio;
  final DefeitoDao defeitoDao;

  GrupoDefeitoEquipamentoTableSyncImpl(
    this.db,
    this.dio,
  ) : defeitoDao = db.defeitoDao;

  @override
  Future<List<GrupoDefeitoEquipamentoTableDto>> buscarDaApi() async {
    try {
      final response = await dio.get(ApiConstants.gruposDefeito);
      return (response.data as List)
          .map((e) => GrupoDefeitoEquipamentoTableDto.fromJson(e))
          .toList();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
        '[grupo_defeito_equipamento_table_sync_impl - buscarDaApi] ${erro.mensagem}',
        tag: 'GrupoDefeitoEquipamentoTableSyncImpl',
        error: e,
        stackTrace: s,
      );
      return [];
    }
  }
  @override
  Future<bool> estaVazio(String entidade) async {
    try {
      return await defeitoDao.estaVazioGrupoDefeitoEquipamento();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
        '[grupo_defeito_equipamento_table_sync_impl - estaVazio] ${erro.mensagem}',
      );
      return true;
    }
  }

  @override
  Future<void> sincronizarComBanco(
      List<GrupoDefeitoEquipamentoTableDto> itens) async {
    try {
      final data = await buscarDaApi();
      final itens = data.map((e) => e.toCompanion()).toList();
      await defeitoDao.sincronizaGruposDefeitoEquipamentoComApi(itens);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
        '[grupo_defeito_equipamento_table_sync_impl - sincronizarComBanco] ${erro.mensagem}',
        tag: 'GrupoDefeitoEquipamentoTableSyncImpl',
        error: e,
        stackTrace: s,
      );
    }
  }

  @override
  String get nomeEntidade => 'grupo_defeito_equipamento';
}
