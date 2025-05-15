import 'package:sympla_app/core/domain/dto/apr/apr_pergunta_relacionamento_table_dto.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/syncable_repository.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/apr_dao.dart';

class AprPerguntaRelacionamentoTableSyncImpl
    implements SyncableRepository<AprPerguntaRelacionamentoTableDto> {
  final AppDatabase db;
  final DioClient dio;
  final AprDao aprDao;

  AprPerguntaRelacionamentoTableSyncImpl(
    this.db,
    this.dio,
  ) : aprDao = db.aprDao;

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

  @override
  String get nomeEntidade => 'apr_pergunta_relacionamento';
}
