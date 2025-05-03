import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/tables/prev_bc_bat/prev_bc_bat_schema.dart';

part 'formulario_bateria_dao.g.dart';

@DriftAccessor(tables: [FormularioBateriaTable])
class FormularioBateriaDao extends DatabaseAccessor<AppDatabase>
    with _$FormularioBateriaDaoMixin {
  FormularioBateriaDao(super.db);

  Future<List<FormularioBateriaTableData>> getAll() =>
      select(formularioBateriaTable).get();

  Future<FormularioBateriaTableData?> getById(int id) =>
      (select(formularioBateriaTable)..where((t) => t.id.equals(id)))
          .getSingleOrNull();

  Future<List<FormularioBateriaTableData>> getByAtividadeId(int atividadeId) =>
      (select(formularioBateriaTable)
            ..where((t) => t.atividadeId.equals(atividadeId)))
          .get();

  Future<int> insert(FormularioBateriaTableCompanion data) =>
      into(formularioBateriaTable).insert(data);

  Future<bool> updateItem(FormularioBateriaTableData data) =>
      update(formularioBateriaTable).replace(data);

  Future<int> deleteById(int id) =>
      (delete(formularioBateriaTable)..where((t) => t.id.equals(id))).go();

  Future<void> deleteByAtividade(int atividadeId) async {
    await (delete(formularioBateriaTable)
          ..where((t) => t.atividadeId.equals(atividadeId)))
        .go();
  }

  Future<void> insertAll(List<FormularioBateriaTableCompanion> lista) async {
    await batch((b) {
      for (final item in lista) {
        b.insert(formularioBateriaTable, item);
      }
    });
  }

  // Future<void> sincronizarComApi(
  //     List<FormularioBateriaTableCompanion> lista) async {
  //   await transaction(() async {
  //     await delete(formularioBateriaTable).go();
  //     await insertAll(lista);
  //   });
  // }
}
