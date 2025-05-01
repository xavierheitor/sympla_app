import 'package:sympla_app/core/storage/app_database.dart';

abstract class DefeitoRepository {
  Future<List<DefeitoTableData>> buscarTodos();
  Future<List<DefeitoTableData>> getByGrupoId(int grupoId);
  Future<List<DefeitoTableData>> getBySubgrupoId(int subgrupoId);
  Future<List<DefeitoTableCompanion>> buscarDaApi();
  Future<void> salvarNoBanco(List<DefeitoTableCompanion> dados);
}
