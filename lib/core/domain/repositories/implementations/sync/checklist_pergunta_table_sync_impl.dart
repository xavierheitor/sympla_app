import 'package:sympla_app/core/domain/dto/checklist/checklist_pergunta_table_dto.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/syncable_repository.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/checklist_dao.dart';

class ChecklistPerguntaTableSyncImpl
    implements SyncableRepository<ChecklistPerguntaTableDto> {
  final AppDatabase db;
  final DioClient dio;
  final ChecklistDao checklistDao;

  ChecklistPerguntaTableSyncImpl(
    this.db,
    this.dio,
  ) : checklistDao = db.checklistDao;

  @override
  Future<List<ChecklistPerguntaTableDto>> buscarDaApi() {
    // TODO: implement buscarDaApi
    throw UnimplementedError();
  }

  @override
  Future<bool> estaVazio(String entidade) {
    // TODO: implement estaVazio
    throw UnimplementedError();
  }

  @override
  Future<void> sincronizarComBanco(List<ChecklistPerguntaTableDto> itens) {
    // TODO: implement sincronizarComBanco
    throw UnimplementedError();
  }

  @override
  String get nomeEntidade => 'checklist_pergunta';
}
