import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/tables/prev_bc_bat/prev_bc_bat_schema.dart';

part 'medicao_elemento_bateria_dao.g.dart';

@DriftAccessor(tables: [MedicaoElementoBateriaTable])
class MedicaoElementoBateriaDao extends DatabaseAccessor<AppDatabase>
    with _$MedicaoElementoBateriaDaoMixin {
  MedicaoElementoBateriaDao(super.db);

  Future<List<MedicaoElementoBateriaTableData>> getAll() =>
      select(medicaoElementoBateriaTable).get();

  Future<List<MedicaoElementoBateriaTableData>> getByFormularioId(
          int formularioId) =>
      (select(medicaoElementoBateriaTable)
            ..where((t) => t.formularioBateriaId.equals(formularioId)))
          .get();

  Future<int> insert(MedicaoElementoBateriaTableCompanion data) =>
      into(medicaoElementoBateriaTable).insert(data);

  Future<void> insertAll(
      List<MedicaoElementoBateriaTableCompanion> lista) async {
    await batch((b) {
      for (final item in lista) {
        b.insert(medicaoElementoBateriaTable, item);
      }
    });
  }

  Future<int> deleteByFormularioId(int formularioId) =>
      (delete(medicaoElementoBateriaTable)
            ..where((t) => t.formularioBateriaId.equals(formularioId)))
          .go();

  // Future<void> sincronizarComApi(
  //     List<MedicaoElementoBateriaTableCompanion> lista) async {
  //   await transaction(() async {
  //     await delete(medicaoElementoBateriaTable).go();
  //     await insertAll(lista);
  //   });
  // }
}
