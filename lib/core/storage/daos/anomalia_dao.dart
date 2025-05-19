import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/tables/schema.dart';

part 'anomalia_dao.g.dart';

@DriftAccessor(tables: [AnomaliaTable])
class AnomaliaDao extends DatabaseAccessor<AppDatabase>
    with _$AnomaliaDaoMixin {
  AnomaliaDao(super.db);

  Future<void> inserirOuAtualizar(AnomaliaTableCompanion data) async {
    await into(anomaliaTable).insertOnConflictUpdate(data);
  }

  Future<void> inserirAnomaliasEmLote(List<AnomaliaTableCompanion> data) async {
    await batch((b) {
      b.insertAll(anomaliaTable, data);
    });
  }

  Future<List<AnomaliaTableData>> buscarPorAtividade(String atividadeId) async {
    final query = select(anomaliaTable)
      ..where((t) => t.atividadeId.equals(atividadeId));
    return await query.get();
  }
}
