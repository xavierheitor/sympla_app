import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/tables/checklist/checklist_schema.dart';

part 'correcao_anomalia_dao.g.dart';

@DriftAccessor(tables: [CorrecaoAnomaliaTable])
class CorrecaoAnomaliaDao extends DatabaseAccessor<AppDatabase>
    with _$CorrecaoAnomaliaDaoMixin {
  CorrecaoAnomaliaDao(super.db);

  // --- CRUD básico ---

  Future<List<CorrecaoAnomaliaTableData>> getAll() =>
      select(correcaoAnomaliaTable).get();

  Future<List<CorrecaoAnomaliaTableData>> getByAtividadeId(int atividadeId) =>
      (select(correcaoAnomaliaTable)
            ..where((tbl) => tbl.atividadeId.equals(atividadeId)))
          .get();

  Future<List<CorrecaoAnomaliaTableData>> getByAnomaliaId(int anomaliaId) =>
      (select(correcaoAnomaliaTable)
            ..where((tbl) => tbl.anomaliaId.equals(anomaliaId)))
          .get();

  Future<int> insert(CorrecaoAnomaliaTableCompanion data) =>
      into(correcaoAnomaliaTable).insert(data);

  Future<bool> updateItem(CorrecaoAnomaliaTableData data) =>
      update(correcaoAnomaliaTable).replace(data);

  Future<int> deleteById(int id) =>
      (delete(correcaoAnomaliaTable)..where((tbl) => tbl.id.equals(id))).go();

  // --- Sincronização com API ---

  Future<void> sincronizarComApi(
      List<CorrecaoAnomaliaTableCompanion> itens) async {
    await transaction(() async {
      await delete(correcaoAnomaliaTable).go();
      for (final item in itens) {
        await into(correcaoAnomaliaTable).insert(item);
      }
    });
  }
}
