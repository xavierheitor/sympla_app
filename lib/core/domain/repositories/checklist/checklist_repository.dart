// ======== Abstract: ChecklistRepository ========

import 'package:sympla_app/core/storage/app_database.dart';

abstract class ChecklistRepository {
  Future<List<ChecklistTableData>> buscarTodos();
  Future<List<ChecklistTableCompanion>> buscarDaApi();
  Future<void> salvarNoBanco(List<ChecklistTableCompanion> dados);
  Future<ChecklistTableData?> buscarPorTipoAtividade(int tipoAtividadeId);
}
