// checklist_grupo_dao.dart

import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/tables/checklist/checklist_schema.dart';

part 'checklist_grupo_dao.g.dart';

@DriftAccessor(tables: [ChecklistGrupoTable])
class ChecklistGrupoDao extends DatabaseAccessor<AppDatabase>
    with _$ChecklistGrupoDaoMixin {
  ChecklistGrupoDao(super.db);

  Future<List<ChecklistGrupoTableData>> getAll() =>
      select(checklistGrupoTable).get();

  Future<int> insert(ChecklistGrupoTableCompanion data) =>
      into(checklistGrupoTable).insert(data);

  Future<bool> updateItem(ChecklistGrupoTableData data) =>
      update(checklistGrupoTable).replace(data);

  Future<int> deleteById(int id) =>
      (delete(checklistGrupoTable)..where((tbl) => tbl.id.equals(id))).go();

  Future<void> clearAndInsertAll(
      List<ChecklistGrupoTableCompanion> items) async {
    await transaction(() async {
      await delete(checklistGrupoTable).go();
      for (final item in items) {
        await into(checklistGrupoTable).insert(item);
      }
    });
  }

  Future<void> sincronizarComApi(
      List<ChecklistGrupoTableCompanion> items) async {
    await transaction(() async {
      await delete(checklistGrupoTable).go();
      final op = batch((b) {
        for (final item in items) {
          b.insert(checklistGrupoTable, item);
        }
      });
      await op;
    });
  }
}
