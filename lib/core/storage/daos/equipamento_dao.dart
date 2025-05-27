import 'package:drift/drift.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/tables/schema.dart';
part 'equipamento_dao.g.dart';
@DriftAccessor(tables: [EquipamentoTable])
class EquipamentoDao extends DatabaseAccessor<AppDatabase>
    with _$EquipamentoDaoMixin {
  EquipamentoDao(super.db);

  Future<void> inserirOuAtualizar(EquipamentoTableCompanion data) async {
    AppLogger.d('🔄 Inserindo/Atualizando Equipamento: $data');
    await into(equipamentoTable).insertOnConflictUpdate(data);
  }

  Future<List<EquipamentoTableData>> buscarTodos() async {
    final result = await select(equipamentoTable).get();
    AppLogger.d('📄 Listou ${result.length} equipamentos');
    return result;
  }

  Future<List<EquipamentoTableData>> buscarPorSubestacao(
      String subestacao) async {
    return (select(equipamentoTable)
          ..where((tbl) => tbl.subestacao.equals(subestacao)))
        .get();
  }

  Future<bool> estaVazioEquipamento() async {
    final result = await select(equipamentoTable).get();
    return result.isEmpty;
  }

  Future<void> deletarTudo() async {
    AppLogger.w('🗑️ Apagando todos os equipamentos do banco');
    await delete(equipamentoTable).go();
  }

  Future<void> sincronizarComApi(
      List<EquipamentoTableCompanion> equipamentosApi) async {
    AppLogger.d(
        '🔄 Iniciando sincronização de ${equipamentosApi.length} equipamentos');

    await batch((batch) {
      batch.update(
        equipamentoTable,
        const EquipamentoTableCompanion(sincronizado: Value(false)),
      );

      batch.insertAllOnConflictUpdate(
        equipamentoTable,
        equipamentosApi
            .map((e) => e.copyWith(sincronizado: const Value(true)))
            .toList(),
      );
    });

    final apagados = await (delete(equipamentoTable)
          ..where((tbl) => tbl.sincronizado.equals(false)))
        .go();

    AppLogger.d('🧹 Removidos $apagados equipamentos obsoletos');
  }

  Future<EquipamentoTableData?> buscarPorUuid(String uuid) async {
    return (select(equipamentoTable)
          ..where((tbl) => tbl.uuid.equals(uuid)))
        .getSingleOrNull();
  }

  Future<void> deletarPorUuid(String uuid) async {
    AppLogger.d('[EquipamentoDao] 🗑️ Deletando equipamento UUID: $uuid');

    final apagados = await (delete(equipamentoTable)
          ..where((tbl) => tbl.uuid.equals(uuid)))
        .go();

    AppLogger.d(
        '[EquipamentoDao] 🗑️ Total de registros deletados: $apagados (UUID: $uuid)');
  }
}
