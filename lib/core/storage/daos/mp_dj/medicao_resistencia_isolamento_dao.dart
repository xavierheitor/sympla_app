import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/tables/prev_disj/prev_disj_schema.dart';

part 'medicao_resistencia_isolamento_dao.g.dart';

@DriftAccessor(tables: [MedicaoResistenciaIsolamentoTable])
class MedicaoResistenciaIsolamentoDao extends DatabaseAccessor<AppDatabase>
    with _$MedicaoResistenciaIsolamentoDaoMixin {
  MedicaoResistenciaIsolamentoDao(super.db);

  Future<List<MedicaoResistenciaIsolamentoTableData>> getAll() =>
      select(medicaoResistenciaIsolamentoTable).get();

  Future<List<MedicaoResistenciaIsolamentoTableData>> getByFormularioId(
      int formularioId) {
    return (select(medicaoResistenciaIsolamentoTable)
          ..where((t) => t.formularioDisjuntorId.equals(formularioId)))
        .get();
  }

  Future<void> insertAll(
      List<MedicaoResistenciaIsolamentoTableCompanion> entradas) async {
    await batch((batch) {
      batch.insertAll(medicaoResistenciaIsolamentoTable, entradas);
    });
  }

  Future<void> deleteByFormularioId(int formularioId) async {
    await (delete(medicaoResistenciaIsolamentoTable)
          ..where((t) => t.formularioDisjuntorId.equals(formularioId)))
        .go();
  }

  Future<void> clearAll() => delete(medicaoResistenciaIsolamentoTable).go();
}
