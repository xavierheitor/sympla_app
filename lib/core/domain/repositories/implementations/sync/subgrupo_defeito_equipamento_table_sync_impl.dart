import 'package:sympla_app/core/constants/api_constants.dart';
import 'package:sympla_app/core/domain/dto/grupo_defeito_equipamento/subgrupo_defeito_equipamento_table_dto.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/syncable_repository.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/defeito_dao.dart';

class SubgrupoDefeitoEquipamentoTableSyncImpl
    implements SyncableRepository<SubgrupoDefeitoEquipamentoTableDto> {
  final AppDatabase db;
  final DioClient dio;
  final DefeitoDao defeitoDao;

  SubgrupoDefeitoEquipamentoTableSyncImpl(
    this.db,
    this.dio,
  ) : defeitoDao = db.defeitoDao;

  @override
  Future<List<SubgrupoDefeitoEquipamentoTableDto>> buscarDaApi() async {
    try {
      final response = await dio.get(ApiConstants.subgruposDefeito);
      return (response.data as List)
          .map((e) => SubgrupoDefeitoEquipamentoTableDto.fromJson(e))
          .toList();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
        '[subgrupo_defeito_equipamento_table_sync_impl - buscarDaApi] ${erro.mensagem}',
        tag: 'SubgrupoDefeitoEquipamentoTableSyncImpl',
        error: e,
        stackTrace: s,
      );
      return [];
    }
  }

  @override
  Future<bool> estaVazio(String entidade) async {
    try {
      return await defeitoDao.estaVazioSubgrupoDefeitoEquipamento();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
        '[subgrupo_defeito_equipamento_table_sync_impl - estaVazio] ${erro.mensagem}',
      );
      return true;
    }
  }

  @override
  Future<void> sincronizarComBanco(
      List<SubgrupoDefeitoEquipamentoTableDto> itens) async {
    try {
      final data = await buscarDaApi();
      final itens = data.map((e) => e.toCompanion()).toList();
      await defeitoDao.sincronizarSubgruposDefeitoEquipamentoComApi(itens);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
        '[subgrupo_defeito_equipamento_table_sync_impl - sincronizarComBanco] ${erro.mensagem}',
        tag: 'SubgrupoDefeitoEquipamentoTableSyncImpl',
        error: e,
        stackTrace: s,
      );
    }
  }

  @override
  String get nomeEntidade => 'subgrupo_defeito_equipamento';
}
