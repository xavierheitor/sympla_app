import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/tables/equipamento/grupo_defeito_equipamento.dart';

part 'grupo_defeito_equipamento_dao.g.dart';

@DriftAccessor(tables: [GrupoDefeitoEquipamentoTable])
class GrupoDefeitoEquipamentoDao extends DatabaseAccessor<AppDatabase>
    with _$GrupoDefeitoEquipamentoDaoMixin {
  GrupoDefeitoEquipamentoDao(super.db);

  // --- Métodos padrão de CRUD ---

  Future<List<GrupoDefeitoEquipamentoTableData>> getAll() =>
      select(grupoDefeitoEquipamentoTable).get();

  Future<int> insert(GrupoDefeitoEquipamentoTableCompanion data) =>
      into(grupoDefeitoEquipamentoTable).insert(data);

  Future<bool> updateItem(GrupoDefeitoEquipamentoTableData data) =>
      update(grupoDefeitoEquipamentoTable).replace(data);

  Future<int> deleteById(int id) =>
      (delete(grupoDefeitoEquipamentoTable)..where((tbl) => tbl.id.equals(id)))
          .go();

  Future<void> clearAndInsertAll(
      List<GrupoDefeitoEquipamentoTableCompanion> items) async {
    await transaction(() async {
      await delete(grupoDefeitoEquipamentoTable).go();
      for (final item in items) {
        await into(grupoDefeitoEquipamentoTable).insert(item);
      }
    });
  } // --- Método de sincronização com a API ---

  Future<void> sincronizarComApi(
      List<GrupoDefeitoEquipamentoTableCompanion> items) async {
    await transaction(() async {
      await delete(grupoDefeitoEquipamentoTable).go();

      await batch((b) {
        for (final item in items) {
          b.insert(grupoDefeitoEquipamentoTable, item);
        }
      });
    });
  }
}
