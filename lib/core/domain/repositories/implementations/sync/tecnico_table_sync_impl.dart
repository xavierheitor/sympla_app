import 'package:sympla_app/core/domain/dto/tecnico_table_dto.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/syncable_repository.dart';
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
  Future<List<TecnicoTableDto>> buscarDaApi() {
    // TODO: implement buscarDaApi
    throw UnimplementedError();
  }

  @override
  Future<bool> estaVazio(String entidade) {
    // TODO: implement estaVazio
    throw UnimplementedError();
  }

  @override
  Future<void> sincronizarComBanco(List<TecnicoTableDto> itens) {
    // TODO: implement sincronizarComBanco
    throw UnimplementedError();
  }

  @override
  String get nomeEntidade => 'tecnico';
}
