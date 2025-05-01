import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/tables/equipamento/subgrupo_defeito_equipamento.dart';

part 'subgrupo_defeito_equipamento_dao.g.dart';

@DriftAccessor(tables: [SubgrupoDefeitoEquipamentoTable])
class SubgrupoDefeitoEquipamentoDao extends DatabaseAccessor<AppDatabase>
    with _$SubgrupoDefeitoEquipamentoDaoMixin {
  SubgrupoDefeitoEquipamentoDao(super.db);

  // --- Métodos padrão de CRUD ---

  Future<List<SubgrupoDefeitoEquipamentoTableData>> getAll() =>
      select(subgrupoDefeitoEquipamentoTable).get();

  Future<List<SubgrupoDefeitoEquipamentoTableData>> getByGrupoId(int grupoId) =>
      (select(subgrupoDefeitoEquipamentoTable)
            ..where((tbl) => tbl.grupoDefeitoId.equals(grupoId)))
          .get();

  Future<int> insert(SubgrupoDefeitoEquipamentoTableCompanion data) =>
      into(subgrupoDefeitoEquipamentoTable).insert(data);

  Future<bool> updateItem(SubgrupoDefeitoEquipamentoTableData data) =>
      update(subgrupoDefeitoEquipamentoTable).replace(data);

  Future<int> deleteById(int id) => (delete(subgrupoDefeitoEquipamentoTable)
        ..where((tbl) => tbl.id.equals(id)))
      .go();

  Future<void> clearAndInsertAll(
      List<SubgrupoDefeitoEquipamentoTableCompanion> items) async {
    await transaction(() async {
      await delete(subgrupoDefeitoEquipamentoTable).go();
      for (final item in items) {
        await into(subgrupoDefeitoEquipamentoTable).insert(item);
      }
    });
  }

  // --- Método de sincronização com a API ---

  Future<void> sincronizarComApi(
      List<SubgrupoDefeitoEquipamentoTableCompanion> items) async {
    await transaction(() async {
      await delete(subgrupoDefeitoEquipamentoTable).go();
      await batch((b) {
        for (final item in items) {
          b.insert(subgrupoDefeitoEquipamentoTable, item);
        }
      });
    });
  }
}
