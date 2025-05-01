// Abstract
import 'package:sympla_app/core/storage/app_database.dart';

abstract class ChecklistPerguntaRepository {
  Future<List<ChecklistPerguntaTableData>> buscarTodos();
  Future<List<ChecklistPerguntaTableData>> buscarPorSubgrupoId(int subgrupoId);
  Future<List<ChecklistPerguntaTableCompanion>> buscarDaApi();
  Future<void> salvarNoBanco(List<ChecklistPerguntaTableCompanion> dados);
}
