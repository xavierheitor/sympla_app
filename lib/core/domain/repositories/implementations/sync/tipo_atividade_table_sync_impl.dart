import 'package:sympla_app/core/domain/dto/atividade/tipo_atividade_table_dto.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/syncable_repository.dart';
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
  Future<List<TipoAtividadeTableDto>> buscarDaApi() {
    // TODO: implement buscarDaApi
    throw UnimplementedError();
  }

  @override
  Future<bool> estaVazio(String entidade) {
    // TODO: implement estaVazio
    throw UnimplementedError();
  }

  @override
  Future<void> sincronizarComBanco(List<TipoAtividadeTableDto> itens) {
    // TODO: implement sincronizarComBanco
    throw UnimplementedError();
  }

  @override
  String get nomeEntidade => 'tipo_atividade';
}
