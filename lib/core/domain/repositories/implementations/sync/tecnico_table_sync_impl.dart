import 'package:sympla_app/core/domain/dto/tecnico_table_dto.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/syncable_repository.dart';

class TecnicoTableSyncImpl implements SyncableRepository<TecnicoTableDto> {
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
}
