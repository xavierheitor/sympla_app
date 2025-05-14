import 'package:sympla_app/core/domain/dto/grupo_defeito_equipamento/grupo_defeito_codigo_table_dto.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/syncable_repository.dart';

class GrupoDefeitoCodigoTableSyncImpl
    implements SyncableRepository<GrupoDefeitoCodigoTableDto> {
  @override
  Future<List<GrupoDefeitoCodigoTableDto>> buscarDaApi() {
    // TODO: implement buscarDaApi
    throw UnimplementedError();
  }

  @override
  Future<bool> estaVazio(String entidade) {
    // TODO: implement estaVazio
    throw UnimplementedError();
  }

  @override
  Future<void> sincronizarComBanco(List<GrupoDefeitoCodigoTableDto> itens) {
    // TODO: implement sincronizarComBanco
    throw UnimplementedError();
  }
}
