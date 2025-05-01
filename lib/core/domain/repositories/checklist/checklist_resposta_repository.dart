import 'package:sympla_app/core/storage/app_database.dart';

abstract class ChecklistRespostaRepository {
  Future<List<ChecklistRespostaTableData>> getAll();
  Future<List<ChecklistRespostaTableData>> getByAtividadeId(int atividadeId);
  Future<void> insert(ChecklistRespostaTableCompanion data);
  Future<void> deleteByAtividadeId(int atividadeId);
  Future<void> deleteById(int id);
}
