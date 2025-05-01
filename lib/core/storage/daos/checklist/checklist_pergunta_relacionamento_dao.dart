// checklist_pergunta_relacionamento_dao.dart
import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/tables/checklist/checklist_schema.dart';

part 'checklist_pergunta_relacionamento_dao.g.dart';

@DriftAccessor(tables: [ChecklistPerguntaRelacionamentoTable])
class ChecklistPerguntaRelacionamentoDao extends DatabaseAccessor<AppDatabase>
    with _$ChecklistPerguntaRelacionamentoDaoMixin {
  ChecklistPerguntaRelacionamentoDao(super.db);

  Future<List<ChecklistPerguntaRelacionamentoTableData>> getAll() =>
      select(checklistPerguntaRelacionamentoTable).get();

  Future<List<ChecklistPerguntaRelacionamentoTableData>> getByChecklistId(
          int checklistId) =>
      (select(checklistPerguntaRelacionamentoTable)
            ..where((tbl) => tbl.checklistId.equals(checklistId)))
          .get();

  Future<int> insert(ChecklistPerguntaRelacionamentoTableCompanion data) =>
      into(checklistPerguntaRelacionamentoTable).insert(data);

  Future<int> deleteById(int id) =>
      (delete(checklistPerguntaRelacionamentoTable)
            ..where((tbl) => tbl.id.equals(id)))
          .go();

  Future<void> deleteByChecklistId(int checklistId) async {
    await (delete(checklistPerguntaRelacionamentoTable)
          ..where((tbl) => tbl.checklistId.equals(checklistId)))
        .go();
  }

  Future<void> clearAndInsertAll(
      List<ChecklistPerguntaRelacionamentoTableCompanion> items) async {
    await transaction(() async {
      await delete(checklistPerguntaRelacionamentoTable).go();
      for (final item in items) {
        await into(checklistPerguntaRelacionamentoTable).insert(item);
      }
    });
  }

  Future<void> sincronizarComApi(
      List<ChecklistPerguntaRelacionamentoTableCompanion> items) async {
    await transaction(() async {
      await delete(checklistPerguntaRelacionamentoTable).go();
      await batch((b) {
        for (final item in items) {
          b.insert(checklistPerguntaRelacionamentoTable, item);
        }
      });
    });
  }
}
