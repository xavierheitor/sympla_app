import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/tables/prev_disj/prev_disj_schema.dart';

part 'medicao_tempo_operacao_dao.g.dart';

@DriftAccessor(tables: [MedicaoTempoOperacaoTable])
class MedicaoTempoOperacaoDao extends DatabaseAccessor<AppDatabase>
    with _$MedicaoTempoOperacaoDaoMixin {
  MedicaoTempoOperacaoDao(super.db);

  Future<List<MedicaoTempoOperacaoTableData>> getAll() =>
      select(medicaoTempoOperacaoTable).get();

  Future<List<MedicaoTempoOperacaoTableData>> getByFormularioId(
      int formularioId) {
    return (select(medicaoTempoOperacaoTable)
          ..where((t) => t.formularioDisjuntorId.equals(formularioId)))
        .get();
  }

  Future<void> insertAll(
      List<MedicaoTempoOperacaoTableCompanion> entradas) async {
    await batch((batch) {
      batch.insertAll(medicaoTempoOperacaoTable, entradas);
    });
  }

  Future<void> deleteByFormularioId(int formularioId) async {
    await (delete(medicaoTempoOperacaoTable)
          ..where((t) => t.formularioDisjuntorId.equals(formularioId)))
        .go();
  }

  Future<void> clearAll() => delete(medicaoTempoOperacaoTable).go();
}
