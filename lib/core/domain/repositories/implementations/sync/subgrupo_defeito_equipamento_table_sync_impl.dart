import 'package:sympla_app/core/domain/dto/grupo_defeito_equipamento/subgrupo_defeito_equipamento_table_dto.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/syncable_repository.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/defeito_dao.dart';

class SubgrupoDefeitoEquipamentoTableSyncImpl
    implements SyncableRepository<SubgrupoDefeitoEquipamentoTableDto> {
  final AppDatabase db;
  final DioClient dio;
  final DefeitoDao defeitoDao;

  SubgrupoDefeitoEquipamentoTableSyncImpl(
    this.db,
    this.dio,
  ) : defeitoDao = db.defeitoDao;

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

  @override
  String get nomeEntidade => 'subgrupo_defeito_equipamento';
}
