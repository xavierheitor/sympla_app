import 'package:sympla_app/core/storage/app_database.dart';

abstract class MedicaoPressaoSf6Repository {
  Future<List<MedicaoPressaoSf6TableData>> getByFormularioId(int formularioId);
  Future<int> insert(MedicaoPressaoSf6TableCompanion data);
  Future<void> insertAll(List<MedicaoPressaoSf6TableCompanion> data);
  Future<void> deleteByFormularioId(int formularioId);
}
