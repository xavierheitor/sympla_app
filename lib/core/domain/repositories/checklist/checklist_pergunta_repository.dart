// checklist_pergunta_repository.dart
import 'package:sympla_app/core/storage/app_database.dart';

abstract class ChecklistPerguntaRepository {
  Future<List<ChecklistPerguntaTableData>> getAll();
  Future<List<ChecklistPerguntaTableCompanion>> buscarDaApi();
  Future<void> salvarNoBanco(List<ChecklistPerguntaTableCompanion> dados);
  Future<void> clearAll();
  Future<void> insert(ChecklistPerguntaTableCompanion data);
  Future<void> deleteById(int id);
}
