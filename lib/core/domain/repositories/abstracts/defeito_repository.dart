import 'package:sympla_app/core/domain/dto/grupo_defeito_equipamento/defeito_table_dto.dart';

abstract class DefeitoRepository {
  Future<List<DefeitoTableDto>> buscarTodosDefeitos();
  Future<DefeitoTableDto> buscarDefeito(String defeitoId);

  // --------------------- Defeitos por Equipamento ---------------------
  Future<List<DefeitoTableDto>> buscarDefeitosPorEquipamentoCodigo(
      String equipamentoCodigo);

  // --------------------- Defeitos por Grupo de Defeito ---------------------
  Future<List<DefeitoTableDto>> buscarDefeitosPorGrupoDefeitoId(
      String grupoDefeitoId);
  Future<List<DefeitoTableDto>> buscarDefeitosPorGrupoDefeitoCodigo(
      String grupoDefeitoCodigo);
  Future<List<DefeitoTableDto>> buscarDefeitosPorSubgrupoDefeitoId(
      String subGrupoDefeitoId);
}
