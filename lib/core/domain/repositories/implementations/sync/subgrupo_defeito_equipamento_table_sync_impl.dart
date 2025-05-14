import 'package:sympla_app/core/domain/dto/grupo_defeito_equipamento/subgrupo_defeito_equipamento_table_dto.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/syncable_repository.dart';

class SubgrupoDefeitoEquipamentoTableSyncImpl
    implements SyncableRepository<SubgrupoDefeitoEquipamentoTableDto> {
  @override
  Future<List<SubgrupoDefeitoEquipamentoTableDto>> buscarDaApi() {
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
      List<SubgrupoDefeitoEquipamentoTableDto> itens) {
    // TODO: implement sincronizarComBanco
    throw UnimplementedError();
  }
}
