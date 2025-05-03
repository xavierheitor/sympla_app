import 'package:sympla_app/core/storage/app_database.dart';

abstract class PrevDisjFormRepository {
  Future<List<PrevDisjFormData>> getAll();
  Future<PrevDisjFormData?> getByAtividadeId(int atividadeId);
  Future<int> insert(PrevDisjFormCompanion data);
  Future<void> insertAll(List<PrevDisjFormCompanion> data);
  Future<void> update(PrevDisjFormData data);
  Future<void> deleteById(int id);
  Future<void> deleteByAtividadeId(int atividadeId);
}
