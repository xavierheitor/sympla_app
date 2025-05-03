import 'package:sympla_app/core/storage/app_database.dart';

abstract class MedicaoElementoBateriaRepository {
  Future<List<MedicaoElementoBateriaTableData>> getAll();
  Future<List<MedicaoElementoBateriaTableData>> getByFormularioId(
      int formularioId);
  Future<void> insert(MedicaoElementoBateriaTableCompanion data);
  Future<void> insertAll(List<MedicaoElementoBateriaTableCompanion> data);
  Future<void> deleteByFormularioId(int formularioId);
}
