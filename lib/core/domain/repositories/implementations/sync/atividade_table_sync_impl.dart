import 'package:sympla_app/core/constants/api_constants.dart';
import 'package:sympla_app/core/domain/dto/atividade/atividade_table_dto.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/syncable_repository.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/atividade_dao.dart';

class AtividadeTableSyncImpl implements SyncableRepository<AtividadeTableDto> {
  final AppDatabase db;
  final DioClient dio;
  final AtividadeDao atividadeDao;

  AtividadeTableSyncImpl(
    this.db,
    this.dio,
  ) : atividadeDao = db.atividadeDao;

  @override
  Future<List<AtividadeTableDto>> buscarDaApi() async {
    try {
      final response = await dio.get(ApiConstants.atividades);
      return response.data.map((e) => AtividadeTableDto.fromJson(e)).toList();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
        '[atividade_table_sync_impl - buscarDaApi] ${erro.mensagem}',
        tag: 'AtividadeTableSyncImpl',
        error: e,
        stackTrace: s,
      );
      return [];
    }
  }

  @override
  Future<bool> estaVazio(String entidade) async {
    try {
      return await atividadeDao.estaVazioAtividade();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
        '[atividade_table_sync_impl - estaVazio] ${erro.mensagem}',
        tag: 'AtividadeTableSyncImpl',
        error: e,
        stackTrace: s,
      );
      return true;
    }
  }
  @override
  Future<void> sincronizarComBanco(List<AtividadeTableDto> itens) async {
    try {
      final data = await buscarDaApi();
      final itens = data.map((e) => e.toCompanion()).toList();
      await atividadeDao.sincronizarAtividadesComApi(itens);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
        '[atividade_table_sync_impl - sincronizarComBanco] ${erro.mensagem}',
      );
    }
  }
  @override
  String get nomeEntidade => 'atividade';
}
