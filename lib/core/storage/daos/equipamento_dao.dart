import 'package:drift/drift.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/tables/equipamento_table.dart';

part 'generated/equipamento_dao.g.dart';

@DriftAccessor(tables: [EquipamentoTable])
class EquipamentoDao extends DatabaseAccessor<AppDatabase>
    with _$EquipamentoDaoMixin {
  EquipamentoDao(super.db);

  Future<void> inserirOuAtualizar(EquipamentoTableCompanion data) async {
    AppLogger.d('🔄 Inserindo/Atualizando Equipamento: ${data.toString()}',
        tag: 'EquipamentoDAO');
    await into(equipamentoTable).insertOnConflictUpdate(data);
  }

  Future<List<EquipamentoTableData>> buscarTodos() async {
    final result = await select(equipamentoTable).get();
    AppLogger.d('📄 Listou ${result.length} equipamentos',
        tag: 'EquipamentoDAO');
    return result;
  }

  Future<void> sincronizarComApi(
      List<EquipamentoTableCompanion> equipamentosApi) async {
    AppLogger.d(
        '🔄 Iniciando sincronização de ${equipamentosApi.length} equipamentos',
        tag: 'EquipamentoDAO');

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

    AppLogger.d('🧹 Removidos $apagados equipamentos obsoletos',
        tag: 'EquipamentoDAO');
  }

  Future<void> deletarTudo() async {
    AppLogger.w('🗑️ Apagando todos os equipamentos do banco',
        tag: 'EquipamentoDAO');
    await delete(equipamentoTable).go();
  }

  Future<bool> estaVazio() async {
    final result = await select(equipamentoTable).get();
    return result.isEmpty;
  }
}
