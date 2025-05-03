import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/tables/prev_disj/prev_disj_schema.dart';

part 'prev_disj_form_dao.g.dart';

@DriftAccessor(tables: [PrevDisjForm])
class PrevDisjFormDao extends DatabaseAccessor<AppDatabase>
    with _$PrevDisjFormDaoMixin {
  PrevDisjFormDao(super.db);

  Future<List<PrevDisjFormData>> getAll() => select(prevDisjForm).get();

  Future<PrevDisjFormData?> getByAtividadeId(int atividadeId) {
    return (select(prevDisjForm)
          ..where((t) => t.atividadeId.equals(atividadeId)))
        .getSingleOrNull();
  }

  Future<int> insert(PrevDisjFormCompanion entry) =>
      into(prevDisjForm).insert(entry);

  Future<void> insertAll(List<PrevDisjFormCompanion> entries) async {
    await batch((batch) {
      batch.insertAll(prevDisjForm, entries);
    });
  }

  Future<void> updateItem(PrevDisjFormData data) async {
    await update(prevDisjForm).replace(data);
  }

  Future<void> deleteById(int id) async {
    await (delete(prevDisjForm)..where((t) => t.id.equals(id))).go();
  }

  Future<void> deleteByAtividadeId(int atividadeId) async {
    await (delete(prevDisjForm)
          ..where((t) => t.atividadeId.equals(atividadeId)))
        .go();
  }

  Future<void> clearAll() => delete(prevDisjForm).go();
}
