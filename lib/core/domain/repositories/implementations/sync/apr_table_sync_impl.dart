import 'package:sympla_app/core/constants/api_constants.dart';
import 'package:sympla_app/core/domain/dto/apr/apr_table_dto.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/syncable_repository.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/apr_dao.dart';

class AprTableSyncImpl implements SyncableRepository<AprTableDto> {
  final AppDatabase db;
  final DioClient dio;
  final AprDao aprDao;

  AprTableSyncImpl(
    this.db,
    this.dio,
  ) : aprDao = db.aprDao;

  @override
  Future<List<AprTableDto>> buscarDaApi() async {
    try {
      final response = await dio.get(ApiConstants.aprs);
      return (response.data as List)
          .map((e) => AprTableDto.fromJson(e))
          .toList();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
        '[apr_table_sync_impl - buscarDaApi] ${erro.mensagem}',
        tag: 'AprTableSyncImpl',
        error: e,
        stackTrace: s,
      );
      return [];
    }
  }

  @override
  Future<bool> estaVazio(String entidade) async {
    try {
      return await aprDao.countAprs() == 0;
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
        '[apr_table_sync_impl - estaVazio] ${erro.mensagem}',
        tag: 'AprTableSyncImpl',
        error: e,
        stackTrace: s,
      );
      return true;
    }
  }

  @override
  Future<void> sincronizarComBanco(List<AprTableDto> itens) async {
    try {
      final data = await buscarDaApi();
      final itens = data.map((e) => e.toCompanion()).toList();
      await aprDao.sincronizarAprs(itens);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
        '[apr_table_sync_impl - sincronizarComBanco] ${erro.mensagem}',
        tag: 'AprTableSyncImpl',
        error: e,
        stackTrace: s,
      );
    }
  }

  @override
  String get nomeEntidade => 'apr';
}
