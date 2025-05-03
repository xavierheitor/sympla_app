import 'package:sympla_app/core/storage/app_database.dart';

abstract class MedicaoTempoOperacaoRepository {
  Future<List<MedicaoTempoOperacaoTableData>> getByFormularioId(
      int formularioId);
  Future<int> insert(MedicaoTempoOperacaoTableCompanion data);
  Future<void> insertAll(List<MedicaoTempoOperacaoTableCompanion> data);
  Future<void> deleteByFormularioId(int formularioId);
}
