import 'package:sympla_app/core/domain/dto/checklist/checklist_table_dto.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/syncable_repository.dart';

class ChecklistTableSyncImpl implements SyncableRepository<ChecklistTableDto> {
  @override
  Future<List<ChecklistTableDto>> buscarDaApi() {
    // TODO: implement buscarDaApi
    throw UnimplementedError();
  }

  @override
  Future<bool> estaVazio(String entidade) {
    // TODO: implement estaVazio
    throw UnimplementedError();
  }

  @override
  Future<void> sincronizarComBanco(List<ChecklistTableDto> itens) {
    // TODO: implement sincronizarComBanco
    throw UnimplementedError();
  }
}
