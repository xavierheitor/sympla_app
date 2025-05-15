import 'package:sympla_app/core/domain/dto/grupo_defeito_equipamento/equipamento_table_dto.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/syncable_repository.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/equipamento_dao.dart';

class EquipamentoTableSyncImpl
    implements SyncableRepository<EquipamentoTableDto> {
  final AppDatabase db;
  final DioClient dio;
  final EquipamentoDao equipamentoDao;

  EquipamentoTableSyncImpl(
    this.db,
    this.dio,
  ) : equipamentoDao = db.equipamentoDao;

  @override
  Future<List<EquipamentoTableDto>> buscarDaApi() {
    // TODO: implement buscarDaApi
    throw UnimplementedError();
  }

  @override
  Future<bool> estaVazio(String entidade) {
    // TODO: implement estaVazio
    throw UnimplementedError();
  }

  @override
  Future<void> sincronizarComBanco(List<EquipamentoTableDto> itens) {
    // TODO: implement sincronizarComBanco
    throw UnimplementedError();
  }

  @override
  String get nomeEntidade => 'equipamento';
}
