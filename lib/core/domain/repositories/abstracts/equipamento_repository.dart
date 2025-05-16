import 'package:sympla_app/core/domain/dto/grupo_defeito_equipamento/equipamento_table_dto.dart';

abstract class EquipamentoRepository {
  Future<EquipamentoTableDto> buscarEquipamento(String equipamentoId);
  Future<EquipamentoTableDto> buscarEquipamentoPorSubestacao(String subestacao);
  Future<List<EquipamentoTableDto>> buscarEquipamentosPorSubestacao(
      String subestacao);
  Future<EquipamentoTableDto> buscarEquipamentoPorSubestacaoId(
      String subestacaoId);

  Future<List<EquipamentoTableDto>> buscarTodosEquipamentos();
  Future<void> deletarEquipamento(String equipamentoId);
}
