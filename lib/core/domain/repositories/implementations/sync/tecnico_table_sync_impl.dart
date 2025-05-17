import 'package:sympla_app/core/constants/api_constants.dart';
import 'package:sympla_app/core/domain/dto/tecnico_table_dto.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/syncable_repository.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/tecnico_dao.dart';

class TecnicoTableSyncImpl implements SyncableRepository<TecnicoTableDto> {
  final AppDatabase db;
  final DioClient dio;
  final TecnicoDao tecnicoDao;

  TecnicoTableSyncImpl(
    this.db,
    this.dio,
  ) : tecnicoDao = db.tecnicoDao;

  @override
  Future<List<TecnicoTableDto>> buscarDaApi() async {
    try {
      final response = await dio.get(ApiConstants.tecnicos);
      return (response.data as List)
          .map((e) => TecnicoTableDto.fromJson(e))
          .toList();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
        '[tecnico_table_sync_impl - buscarDaApi] ${erro.mensagem}',
        tag: 'TecnicoTableSyncImpl',
        error: e,
        stackTrace: s,
      );
      return [];
    }
  }

  @override
  Future<bool> estaVazio(String entidade) async {
    try {
      return await tecnicoDao.estaVazio();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
        '[tecnico_table_sync_impl - estaVazio] ${erro.mensagem}',
      );
      return true;
    }
  }

  @override
  Future<void> sincronizarComBanco(List<TecnicoTableDto> itens) async {
    try {
      final data = await buscarDaApi();
      final itens = data.map((e) => e.toCompanion()).toList();
      await tecnicoDao.sincronizarComApi(itens);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
        '[tecnico_table_sync_impl - sincronizarComBanco] ${erro.mensagem}',
        tag: 'TecnicoTableSyncImpl',
        error: e,
        stackTrace: s,
      );
    }
  }

  @override
  String get nomeEntidade => 'tecnico';
}
