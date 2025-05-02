import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/tables/checklist/checklist_schema.dart';

part 'anomalia_dao.g.dart';

@DriftAccessor(tables: [AnomaliaTable])
class AnomaliaDao extends DatabaseAccessor<AppDatabase>
    with _$AnomaliaDaoMixin {
  AnomaliaDao(super.db);

  // --- Métodos padrão de CRUD ---

  Future<List<AnomaliaTableData>> getAll() => select(anomaliaTable).get();

  Future<List<AnomaliaTableData>> getByAtividadeId(int atividadeId) =>
      (select(anomaliaTable)..where((t) => t.atividadeId.equals(atividadeId)))
          .get();

  Future<int> insert(AnomaliaTableCompanion data) =>
      into(anomaliaTable).insert(data);

  Future<bool> updateItem(AnomaliaTableData data) =>
      update(anomaliaTable).replace(data);

  Future<int> deleteById(int id) =>
      (delete(anomaliaTable)..where((tbl) => tbl.id.equals(id))).go();

  Future<void> deleteByAtividade(int atividadeId) async {
    await (delete(anomaliaTable)
          ..where((tbl) => tbl.atividadeId.equals(atividadeId)))
        .go();
  }

  // --- Método de sincronização com a API ---

  Future<void> sincronizarComApi(List<AnomaliaTableCompanion> lista) async {
    await transaction(() async {
      await delete(anomaliaTable).go();
      final op = batch((b) {
        for (final item in lista) {
          b.insert(anomaliaTable, item);
        }
      });
      await op;
    });
  }

  Future<void> insertAll(List<AnomaliaTableCompanion> data) async {
    await batch((b) {
      for (final item in data) {
        b.insert(anomaliaTable, item);
      }
    });
  }
}
