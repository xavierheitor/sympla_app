import 'package:sympla_app/core/storage/app_database.dart';

abstract class AnomaliaRepository {
  Future<List<AnomaliaTableData>> getAll();
  Future<List<AnomaliaTableData>> getByAtividadeId(int atividadeId);
  Future<void> insert(AnomaliaTableCompanion data);
  Future<void> update(AnomaliaTableData data);
  Future<void> deleteById(int id);
  Future<void> deleteByAtividadeId(int atividadeId);
}
