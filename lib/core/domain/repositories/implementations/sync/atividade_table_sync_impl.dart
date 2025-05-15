import 'package:sympla_app/core/domain/dto/atividade/atividade_table_dto.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/syncable_repository.dart';
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
  Future<List<AtividadeTableDto>> buscarDaApi() {
    // TODO: implement buscarDaApi
    throw UnimplementedError();
  }

  @override
  Future<bool> estaVazio(String entidade) {
    // TODO: implement estaVazio
    throw UnimplementedError();
  }

  @override
  Future<void> sincronizarComBanco(List<AtividadeTableDto> itens) {
    // TODO: implement sincronizarComBanco
    throw UnimplementedError();
  }

  @override
  String get nomeEntidade => 'atividade';
}
