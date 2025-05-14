import 'package:sympla_app/core/domain/dto/atividade/atividade_table_dto.dart';
import 'package:sympla_app/core/domain/dto/atividade/tipo_atividade_table_dto.dart';

abstract class AtividadeRepository {
  // --------------------- Atividade ---------------------
  Future<AtividadeTableDto> buscarAtividade(String atividadeId);
  Future<List<AtividadeTableDto>> buscarTodasAtividades();
  Future<AtividadeTableDto?> buscarAtividadeEmAndamento();

  Future<void> iniciarAtividade(AtividadeTableDto atividade);
  Future<void> finalizarAtividade(AtividadeTableDto atividade);

  Future<TipoAtividadeTableDto> buscarTipoAtividadePorAtividadeId(
      String atividadeId);

  // --------------------- Tipo Atividade ---------------------
  Future<List<TipoAtividadeTableDto>> buscarTodosTiposAtividade();

  buscarAtividadesComEquipamento() {}
}
