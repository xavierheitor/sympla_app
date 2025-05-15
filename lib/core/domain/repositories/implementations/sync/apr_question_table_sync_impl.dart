import 'package:sympla_app/core/data/models/new/apr_question_table_dto.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/syncable_repository.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/apr_dao.dart';

class AprQuestionTableSyncImpl
    implements SyncableRepository<AprQuestionTableDto> {
  final AppDatabase db;
  final DioClient dio;
  final AprDao aprDao;

  AprQuestionTableSyncImpl(
    this.db,
    this.dio,
  ) : aprDao = db.aprDao;

  @override
  Future<List<AprQuestionTableDto>> buscarDaApi() {
    // TODO: implement buscarDaApi
    throw UnimplementedError();
  }

  @override
  Future<bool> estaVazio(String entidade) {
    // TODO: implement estaVazio
    throw UnimplementedError();
  }

  @override
  Future<void> sincronizarComBanco(List<AprQuestionTableDto> itens) {
    // TODO: implement sincronizarComBanco
    throw UnimplementedError();
  }

  @override
  String get nomeEntidade => 'apr_question';
}
