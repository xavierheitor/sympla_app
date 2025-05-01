import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/tables/checklist/checklist_schema.dart';

part 'checklist_resposta_dao.g.dart';

@DriftAccessor(tables: [ChecklistRespostaTable])
class ChecklistRespostaDao extends DatabaseAccessor<AppDatabase>
    with _$ChecklistRespostaDaoMixin {
  ChecklistRespostaDao(super.db);

  // --- Métodos padrão de CRUD ---

  Future<List<ChecklistRespostaTableData>> getAll() =>
      select(checklistRespostaTable).get();

  Future<List<ChecklistRespostaTableData>> getByAtividadeId(int atividadeId) =>
      (select(checklistRespostaTable)
            ..where((tbl) => tbl.atividadeId.equals(atividadeId)))
          .get();

  Future<int> insert(ChecklistRespostaTableCompanion data) =>
      into(checklistRespostaTable).insert(data);

  Future<bool> updateItem(ChecklistRespostaTableData data) =>
      update(checklistRespostaTable).replace(data);

  Future<int> deleteById(int id) =>
      (delete(checklistRespostaTable)..where((tbl) => tbl.id.equals(id))).go();

  Future<void> deleteByAtividadeId(int atividadeId) async {
    await (delete(checklistRespostaTable)
          ..where((tbl) => tbl.atividadeId.equals(atividadeId)))
        .go();
  }

  // --- Método de sincronização com a API ---

  Future<void> sincronizarComApi(
      List<ChecklistRespostaTableCompanion> dadosCompanion) async {
    await transaction(() async {
      await delete(checklistRespostaTable).go();
      final op = batch((b) {
        for (final item in dadosCompanion) {
          b.insert(checklistRespostaTable, item);
        }
      });
      await op;
    });
  }
}
