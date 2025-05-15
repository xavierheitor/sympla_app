import 'package:sympla_app/core/constants/api_constants.dart';
import 'package:sympla_app/core/domain/dto/grupo_defeito_equipamento/equipamento_table_dto.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/syncable_repository.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/equipamento_dao.dart';

class EquipamentoTableSyncImpl
    implements SyncableRepository<EquipamentoTableDto> {
  final AppDatabase db;
  final DioClient dio;
  final EquipamentoDao equipamentoDao;

  EquipamentoTableSyncImpl(
    this.db,
    this.dio,
  ) : equipamentoDao = db.equipamentoDao;

  @override
  Future<List<EquipamentoTableDto>> buscarDaApi() async {
    try {
      final response = await dio.get(ApiConstants.equipamentos);
      return response.data.map((e) => EquipamentoTableDto.fromJson(e)).toList();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
        '[equipamento_table_sync_impl - buscarDaApi] ${erro.mensagem}',
        tag: 'EquipamentoTableSyncImpl',
        error: e,
        stackTrace: s,
      );
      return [];
    }
  }

  @override
  Future<bool> estaVazio(String entidade) async {
    try {
      return await equipamentoDao.estaVazioEquipamento();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[equipamento_table_sync_impl - estaVazio] ${erro.mensagem}');
      return true;
    }
  }

  @override
  Future<void> sincronizarComBanco(List<EquipamentoTableDto> itens) async {
    try {
      final data = await buscarDaApi();
      final itens = data.map((e) => e.toCompanion()).toList();
      await equipamentoDao.sincronizarComApi(itens);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
        '[equipamento_table_sync_impl - sincronizarComBanco] ${erro.mensagem}',
        tag: 'EquipamentoTableSyncImpl',
        error: e,
        stackTrace: s,
      );
    }
  }

  @override
  String get nomeEntidade => 'equipamento';
}
