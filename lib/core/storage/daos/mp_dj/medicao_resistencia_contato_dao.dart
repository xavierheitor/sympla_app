import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/tables/prev_disj/prev_disj_schema.dart';

part 'medicao_resistencia_contato_dao.g.dart';

@DriftAccessor(tables: [MedicaoResistenciaContatoTable])
class MedicaoResistenciaContatoDao extends DatabaseAccessor<AppDatabase>
    with _$MedicaoResistenciaContatoDaoMixin {
  MedicaoResistenciaContatoDao(super.db);

  Future<List<MedicaoResistenciaContatoTableData>> getAll() =>
      select(medicaoResistenciaContatoTable).get();

  Future<List<MedicaoResistenciaContatoTableData>> getByFormularioId(
      int formularioId) {
    return (select(medicaoResistenciaContatoTable)
          ..where((t) => t.formularioDisjuntorId.equals(formularioId)))
        .get();
  }

  Future<void> insertAll(
      List<MedicaoResistenciaContatoTableCompanion> entradas) async {
    await batch((batch) {
      batch.insertAll(medicaoResistenciaContatoTable, entradas);
    });
  }

  Future<void> deleteByFormularioId(int formularioId) async {
    await (delete(medicaoResistenciaContatoTable)
          ..where((t) => t.formularioDisjuntorId.equals(formularioId)))
        .go();
  }

  Future<void> clearAll() => delete(medicaoResistenciaContatoTable).go();
}
