// checklist_dao.dart
import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/tables/atividade/tipo_atividade_table.dart';
import 'package:sympla_app/core/storage/tables/checklist/checklist_schema.dart';

part 'checklist_dao.g.dart';

@DriftAccessor(tables: [ChecklistTable, TipoAtividadeTable])
class ChecklistDao extends DatabaseAccessor<AppDatabase>
    with _$ChecklistDaoMixin {
  ChecklistDao(super.db);

  Future<List<ChecklistTableData>> getAll() => select(checklistTable).get();

  Future<ChecklistTableData?> getById(int id) =>
      (select(checklistTable)..where((tbl) => tbl.id.equals(id)))
          .getSingleOrNull();

  Future<int> insert(ChecklistTableCompanion data) =>
      into(checklistTable).insert(data);

  Future<bool> updateItem(ChecklistTableData data) =>
      update(checklistTable).replace(data);

  Future<int> deleteById(int id) =>
      (delete(checklistTable)..where((tbl) => tbl.id.equals(id))).go();

  Future<void> clearAndInsertAll(List<ChecklistTableCompanion> items) async {
    await transaction(() async {
      await delete(checklistTable).go();
      for (final item in items) {
        await into(checklistTable).insert(item);
      }
    });
  }

  Future<void> sincronizarComApi(List<ChecklistTableCompanion> items) async {
    await transaction(() async {
      await delete(checklistTable).go();
      await batch((b) {
        for (final item in items) {
          b.insert(checklistTable, item);
        }
      });
    });
  }

  Future<ChecklistTableData?> getByTipoAtividade(int tipoAtividadeId) async {
    final query = select(checklistTable).join([
      innerJoin(
        tipoAtividadeTable,
        tipoAtividadeTable.checklistId.equalsExp(checklistTable.id),
      )
    ])
      ..where(tipoAtividadeTable.id.equals(tipoAtividadeId));

    final result = await query.getSingleOrNull();
    return result?.readTable(checklistTable);
  }
}
