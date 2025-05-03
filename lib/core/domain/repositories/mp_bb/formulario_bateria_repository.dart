import 'package:sympla_app/core/storage/app_database.dart';

abstract class FormularioBateriaRepository {
  Future<List<FormularioBateriaTableData>> getAll();
  Future<List<FormularioBateriaTableData>> getByAtividadeId(int atividadeId);
  Future<int> insert(FormularioBateriaTableCompanion data);
  Future<void> update(FormularioBateriaTableData data);
  Future<void> deleteById(int id);
  Future<void> deleteByAtividadeId(int atividadeId);
  Future<void> insertAll(List<FormularioBateriaTableCompanion> data);
}
