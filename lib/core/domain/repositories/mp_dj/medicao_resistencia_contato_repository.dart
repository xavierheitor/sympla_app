import 'package:sympla_app/core/storage/app_database.dart';

abstract class MedicaoResistenciaContatoRepository {
  Future<List<MedicaoResistenciaContatoTableData>> getByFormularioId(
      int formularioId);
  Future<int> insert(MedicaoResistenciaContatoTableCompanion data);
  Future<void> insertAll(List<MedicaoResistenciaContatoTableCompanion> data);
  Future<void> deleteByFormularioId(int formularioId);
}
