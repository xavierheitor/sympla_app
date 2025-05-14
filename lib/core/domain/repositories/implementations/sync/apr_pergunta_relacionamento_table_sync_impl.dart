import 'package:sympla_app/core/domain/dto/apr/apr_pergunta_relacionamento_table_dto.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/syncable_repository.dart';

class AprPerguntaRelacionamentoTableSyncImpl
    implements SyncableRepository<AprPerguntaRelacionamentoTableDto> {
  @override
  Future<List<AprPerguntaRelacionamentoTableDto>> buscarDaApi() {
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
      List<AprPerguntaRelacionamentoTableDto> itens) {
    // TODO: implement sincronizarComBanco
    throw UnimplementedError();
  }
}
