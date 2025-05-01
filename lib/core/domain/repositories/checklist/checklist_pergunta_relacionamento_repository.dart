// ======== Abstract: ChecklistPerguntaRelacionamentoRepository ========

import 'package:sympla_app/core/storage/app_database.dart';

abstract class ChecklistPerguntaRelacionamentoRepository {
  Future<List<ChecklistPerguntaRelacionamentoTableData>> buscarTodos();
  Future<List<ChecklistPerguntaRelacionamentoTableCompanion>> buscarDaApi();
  Future<void> salvarNoBanco(
      List<ChecklistPerguntaRelacionamentoTableCompanion> dados);

  Future<List<ChecklistPerguntaRelacionamentoTableData>> buscarPorChecklistId(
      int checklistId);
}
