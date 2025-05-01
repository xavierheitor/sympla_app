import 'package:sympla_app/core/storage/app_database.dart';

abstract class ChecklistSubgrupoRepository {
  Future<List<ChecklistSubgrupoTableData>> getAll();
  Future<List<ChecklistSubgrupoTableData>> getByGrupoId(int grupoId);
  Future<List<ChecklistSubgrupoTableCompanion>> buscarDaApi();
  Future<void> salvarNoBanco(List<ChecklistSubgrupoTableCompanion> dados);
}
