// checklist_pergunta_dao.dart

import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/tables/checklist/checklist_schema.dart';

part 'checklist_pergunta_dao.g.dart';

@DriftAccessor(
    tables: [ChecklistPerguntaTable, ChecklistPerguntaRelacionamentoTable])
class ChecklistPerguntaDao extends DatabaseAccessor<AppDatabase>
    with _$ChecklistPerguntaDaoMixin {
  ChecklistPerguntaDao(super.db);

  // --- CRUD básico ---

  Future<List<ChecklistPerguntaTableData>> getAll() =>
      select(checklistPerguntaTable).get();

  Future<List<ChecklistPerguntaTableData>> getByChecklistId(
      int checklistId) async {
    final relacionamentos = await (select(checklistPerguntaRelacionamentoTable)
          ..where((tbl) => tbl.checklistId.equals(checklistId)))
        .get();

    final perguntaIds = relacionamentos.map((r) => r.perguntaId).toSet();
    return (select(checklistPerguntaTable)
          ..where((tbl) => tbl.id.isIn(perguntaIds.toList())))
        .get();
  }

  Future<int> insert(ChecklistPerguntaTableCompanion data) =>
      into(checklistPerguntaTable).insert(data);

  Future<bool> updateItem(ChecklistPerguntaTableData data) =>
      update(checklistPerguntaTable).replace(data);

  Future<int> deleteById(int id) =>
      (delete(checklistPerguntaTable)..where((tbl) => tbl.id.equals(id))).go();

  Future<void> clearAndInsertAll(
      List<ChecklistPerguntaTableCompanion> items) async {
    await transaction(() async {
      await delete(checklistPerguntaTable).go();
      for (final item in items) {
        await into(checklistPerguntaTable).insert(item);
      }
    });
  }

  // --- Sincronização ---

  Future<void> sincronizarComApi(
      List<ChecklistPerguntaTableCompanion> items) async {
    await transaction(() async {
      await delete(checklistPerguntaTable).go();
      final op = batch((b) {
        for (final item in items) {
          b.insert(checklistPerguntaTable, item);
        }
      });
      await op;
    });
  }
}
