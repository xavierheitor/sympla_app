import 'package:sympla_app/core/storage/app_database.dart';

abstract class MedicaoResistenciaIsolamentoRepository {
  Future<List<MedicaoResistenciaIsolamentoTableData>> getByFormularioId(
      int formularioId);
  Future<int> insert(MedicaoResistenciaIsolamentoTableCompanion data);
  Future<void> insertAll(List<MedicaoResistenciaIsolamentoTableCompanion> data);
  Future<void> deleteByFormularioId(int formularioId);
}
