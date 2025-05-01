// checklist_subgrupo_dao.dart

import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/tables/checklist/checklist_schema.dart';

part 'checklist_subgrupo_dao.g.dart';

@DriftAccessor(tables: [ChecklistSubgrupoTable])
class ChecklistSubgrupoDao extends DatabaseAccessor<AppDatabase>
    with _$ChecklistSubgrupoDaoMixin {
  ChecklistSubgrupoDao(super.db);

  Future<List<ChecklistSubgrupoTableData>> getAll() =>
      select(checklistSubgrupoTable).get();

  Future<List<ChecklistSubgrupoTableData>> getByGrupoId(int grupoId) =>
      (select(checklistSubgrupoTable)
            ..where((tbl) => tbl.grupoId.equals(grupoId)))
          .get();

  Future<int> insert(ChecklistSubgrupoTableCompanion data) =>
      into(checklistSubgrupoTable).insert(data);

  Future<bool> updateItem(ChecklistSubgrupoTableData data) =>
      update(checklistSubgrupoTable).replace(data);

  Future<int> deleteById(int id) =>
      (delete(checklistSubgrupoTable)..where((tbl) => tbl.id.equals(id))).go();

  Future<void> clearAndInsertAll(
      List<ChecklistSubgrupoTableCompanion> items) async {
    await transaction(() async {
      await delete(checklistSubgrupoTable).go();
      for (final item in items) {
        await into(checklistSubgrupoTable).insert(item);
      }
    });
  }

  Future<void> sincronizarComApi(
      List<ChecklistSubgrupoTableCompanion> items) async {
    await transaction(() async {
      await delete(checklistSubgrupoTable).go();
      final op = batch((b) {
        for (final item in items) {
          b.insert(checklistSubgrupoTable, item);
        }
      });
      await op;
    });
  }
}
