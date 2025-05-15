import 'package:sympla_app/core/constants/api_constants.dart';
import 'package:sympla_app/core/domain/dto/atividade/tipo_atividade_table_dto.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/syncable_repository.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/atividade_dao.dart';

class TipoAtividadeTableSyncImpl
    implements SyncableRepository<TipoAtividadeTableDto> {
  final AppDatabase db;
  final DioClient dio;
  final AtividadeDao atividadeDao;

  TipoAtividadeTableSyncImpl(
    this.db,
    this.dio,
  ) : atividadeDao = db.atividadeDao;

  @override
  Future<List<TipoAtividadeTableDto>> buscarDaApi() async {
    try {
      final response = await dio.get(ApiConstants.tipoAtividade);
      return response.data
          .map((e) => TipoAtividadeTableDto.fromJson(e))
          .toList();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
        '[tipo_atividade_table_sync_impl - buscarDaApi] ${erro.mensagem}',
        tag: 'TipoAtividadeTableSyncImpl',
        error: e,
        stackTrace: s,
      );
      return [];
    }
  }

  @override
  Future<bool> estaVazio(String entidade) async {
    try {
      return await atividadeDao.estaVazioTipoAtividade();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
        '[tipo_atividade_table_sync_impl - estaVazio] ${erro.mensagem}',
      );
      return true;
    }
  }

  @override
  Future<void> sincronizarComBanco(List<TipoAtividadeTableDto> itens) async {
    try {
      final data = await buscarDaApi();
      final itens = data.map((e) => e.toCompanion()).toList();
      await atividadeDao.sincronizarTiposAtividadeComApi(itens);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
        '[tipo_atividade_table_sync_impl - sincronizarComBanco] ${erro.mensagem}',
        tag: 'TipoAtividadeTableSyncImpl',
        error: e,
        stackTrace: s,
      );
    }
  }

  @override
  String get nomeEntidade => 'tipo_atividade';
}
