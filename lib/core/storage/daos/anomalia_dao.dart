import 'package:drift/drift.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/tables/schema.dart';

part 'generated/anomalia_dao.g.dart';

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

  Future<void> deleteById(int id) async {
    await (delete(anomaliaTable)..where((t) => t.id.equals(id))).go();
  }

  Future<void> deleteByAtividadeId(String atividadeId) async {
    await (delete(anomaliaTable)
          ..where((t) => t.atividadeId.equals(atividadeId)))
        .go();
  }

  Future<List<TypedResult>> buscarComIncludesPorAtividade(String atividadeId) {
    final query = select(anomaliaTable).join([
      innerJoin(
        equipamentoTable,
        equipamentoTable.uuid.equalsExp(anomaliaTable.equipamentoId),
      ),
      innerJoin(
        defeitoTable,
        defeitoTable.uuid.equalsExp(anomaliaTable.defeitoId),
      ),
    ])
      ..where(anomaliaTable.atividadeId.equals(atividadeId));

    return query.get(); // retorna List<TypedResult>
  }

  /// 🗑️ Deleta uma lista de anomalias pelos seus UUIDs
  Future<void> deletarAnomalias(List<AnomaliaTableCompanion> anomalias) async {
    final uuids = anomalias.map((e) => e.id.value).toList();

    AppLogger.d(
        '[AnomaliaDao] 🗑️ Deletando ${uuids.length} anomalias pelos IDs: $uuids');

    await (delete(anomaliaTable)..where((tbl) => tbl.id.isIn(uuids))).go();

    AppLogger.d('[AnomaliaDao] 🗑️ Total de anomalias deletadas: $uuids');
  }
}
