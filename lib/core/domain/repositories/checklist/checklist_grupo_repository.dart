import 'package:sympla_app/core/storage/app_database.dart';

abstract class ChecklistGrupoRepository {
  Future<List<ChecklistGrupoTableData>> buscarTodos();
  Future<List<ChecklistGrupoTableCompanion>> buscarDaApi();
  Future<void> salvarNoBanco(List<ChecklistGrupoTableCompanion> dados);
}
