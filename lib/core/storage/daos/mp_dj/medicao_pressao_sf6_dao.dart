import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/tables/prev_disj/prev_disj_schema.dart';

part 'medicao_pressao_sf6_dao.g.dart';

@DriftAccessor(tables: [MedicaoPressaoSf6Table])
class MedicaoPressaoSf6Dao extends DatabaseAccessor<AppDatabase>
    with _$MedicaoPressaoSf6DaoMixin {
  MedicaoPressaoSf6Dao(super.db);

  Future<List<MedicaoPressaoSf6TableData>> getAll() =>
      select(medicaoPressaoSf6Table).get();

  Future<List<MedicaoPressaoSf6TableData>> getByFormularioId(int formularioId) {
    return (select(medicaoPressaoSf6Table)
          ..where((t) => t.formularioDisjuntorId.equals(formularioId)))
        .get();
  }

  Future<void> insertAll(List<MedicaoPressaoSf6TableCompanion> entradas) async {
    await batch((batch) {
      batch.insertAll(medicaoPressaoSf6Table, entradas);
    });
  }

  Future<void> deleteByFormularioId(int formularioId) async {
    await (delete(medicaoPressaoSf6Table)
          ..where((t) => t.formularioDisjuntorId.equals(formularioId)))
        .go();
  }

  Future<void> clearAll() => delete(medicaoPressaoSf6Table).go();
}
