import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/tables/checklist/checklist_schema.dart';

part 'defeito_dao.g.dart';

@DriftAccessor(tables: [DefeitoTable])
class DefeitoDao extends DatabaseAccessor<AppDatabase> with _$DefeitoDaoMixin {
  DefeitoDao(super.db);

  // --- Métodos padrão de CRUD ---

  Future<List<DefeitoTableData>> getAll() => select(defeitoTable).get();

  Future<int> insert(DefeitoTableCompanion data) =>
      into(defeitoTable).insert(data);

  Future<bool> updateItem(DefeitoTableData data) =>
      update(defeitoTable).replace(data);

  Future<int> deleteById(int id) =>
      (delete(defeitoTable)..where((tbl) => tbl.id.equals(id))).go();

  Future<void> clearAndInsertAll(List<DefeitoTableCompanion> items) async {
    await transaction(() async {
      await delete(defeitoTable).go();
      for (final item in items) {
        await into(defeitoTable).insert(item);
      }
    });
  }

  // --- Método de sincronização com a API ---

  Future<void> sincronizarComApi(List<DefeitoTableCompanion> items) async {
    await transaction(() async {
      await delete(defeitoTable).go();

      final op = batch((b) {
        for (final item in items) {
          b.insert(defeitoTable, item);
        }
      });

      await op;
    });
  }
}
