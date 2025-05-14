import 'package:sympla_app/core/domain/dto/grupo_defeito_equipamento/grupo_defeito_equipamento_table_dto.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/syncable_repository.dart';

class GrupoDefeitoEquipamentoTableSyncImpl
    implements SyncableRepository<GrupoDefeitoEquipamentoTableDto> {
  @override
  Future<List<GrupoDefeitoEquipamentoTableDto>> buscarDaApi() {
    // TODO: implement buscarDaApi
    throw UnimplementedError();
  }

  @override
  Future<bool> estaVazio(String entidade) {
    // TODO: implement estaVazio
    throw UnimplementedError();
  }

  @override
  Future<void> sincronizarComBanco(
      List<GrupoDefeitoEquipamentoTableDto> itens) {
    // TODO: implement sincronizarComBanco
    throw UnimplementedError();
  }
}
