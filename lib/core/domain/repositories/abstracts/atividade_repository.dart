import 'package:sympla_app/core/domain/dto/atividade/atividade_table_dto.dart';
import 'package:sympla_app/core/domain/dto/atividade/tipo_atividade_table_dto.dart';

/// 🔗 Interface (abstract) para operações de banco/local relacionadas a Atividades.
abstract class AtividadeRepository {
  // --------------------------------------------------------------------------
  // 🚩 Atividades
  // --------------------------------------------------------------------------

  /// 🔍 Busca uma atividade específica pelo ID.
  Future<AtividadeTableDto?> buscarAtividade(String atividadeId);

  /// 🔍 Busca todas as atividades (sem join).
  Future<List<AtividadeTableDto>> buscarTodasAtividades();

  /// 🔍 Busca a atividade que está em andamento (se houver).
  Future<AtividadeTableDto?> buscarAtividadeEmAndamento();

  /// 🔥 Marca a atividade como "em andamento" no banco.
  Future<void> iniciarAtividade(AtividadeTableDto atividade);

  /// 🔥 Finaliza a atividade no banco (muda status e data).
  Future<void> finalizarAtividade(AtividadeTableDto atividade);

  // --------------------------------------------------------------------------
  // 🏷️ Tipo de Atividade
  // --------------------------------------------------------------------------

  /// 🔍 Busca o TipoAtividade associado a uma atividade específica.
  Future<TipoAtividadeTableDto?> buscarTipoAtividadePorAtividadeId(
      String atividadeId);

  /// 🔍 Busca todos os tipos de atividades disponíveis no banco.
  Future<List<TipoAtividadeTableDto>> buscarTodosTiposAtividade();

  // --------------------------------------------------------------------------
  // 🔗 Atividades com JOIN (atividade + equipamento + tipoAtividade)
  // --------------------------------------------------------------------------

  /// 🔍 Busca atividades com dados de equipamento e tipo (join no banco).
  Future<List<AtividadeTableDto>> buscarAtividadesComEquipamento();
}
