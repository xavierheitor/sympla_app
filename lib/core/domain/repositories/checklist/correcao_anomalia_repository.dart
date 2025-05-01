import 'package:sympla_app/core/storage/app_database.dart';

abstract class CorrecaoAnomaliaRepository {
  Future<List<CorrecaoAnomaliaTableData>> getAll();
  Future<List<CorrecaoAnomaliaTableData>> getByAtividadeId(int atividadeId);
  Future<List<CorrecaoAnomaliaTableData>> getByAnomaliaId(int anomaliaId);
  Future<void> insert(CorrecaoAnomaliaTableCompanion data);
  Future<void> update(CorrecaoAnomaliaTableData data);
  Future<void> deleteById(int id);
}
