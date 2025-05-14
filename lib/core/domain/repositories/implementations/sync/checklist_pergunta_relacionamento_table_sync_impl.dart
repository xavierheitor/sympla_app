import 'package:sympla_app/core/domain/dto/checklist/checklist_pergunta_relacionamento_table_dto.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/syncable_repository.dart';

class ChecklistPerguntaRelacionamentoTableSyncImpl
    implements SyncableRepository<ChecklistPerguntaRelacionamentoTableDto> {
  @override
  Future<List<ChecklistPerguntaRelacionamentoTableDto>> buscarDaApi() {
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
      List<ChecklistPerguntaRelacionamentoTableDto> itens) {
    // TODO: implement sincronizarComBanco
    throw UnimplementedError();
  }
}
