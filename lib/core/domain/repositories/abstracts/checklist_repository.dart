import 'package:sympla_app/core/domain/dto/checklist/checklist_pergunta_table_dto.dart';
import 'package:sympla_app/core/domain/dto/checklist/checklist_preenchido_table_dto.dart';
import 'package:sympla_app/core/domain/dto/checklist/checklist_resposta_table_dto.dart';
import 'package:sympla_app/core/domain/dto/checklist/checklist_table_dto.dart';

/// 🔗 Contrato do repositório de Checklist
abstract class ChecklistRepository {
  // --------------------- Modelo ---------------------

  /// 🔍 Busca o modelo de checklist associado a um tipo de atividade
  Future<ChecklistTableDto?> buscarModeloPorTipoAtividade(
      String idTipoAtividade);

  /// 🔍 Verifica se não há checklist cadastrado (útil para primeira sincronização)
  Future<bool> checklistEstaVazio();

  // --------------------- Perguntas ---------------------

  /// 🔍 Busca as perguntas relacionadas ao checklist
  Future<List<ChecklistPerguntaTableDto>> buscarPerguntasRelacionadas(
      String checklistId);

  // --------------------- Checklist Preenchido ---------------------

  /// 🔥 Cria um novo checklist preenchido
  Future<int> criarChecklistPreenchido(ChecklistPreenchidoTableDto checklist);

  /// 🔄 Atualiza a data de preenchimento
  Future<void> atualizarDataPreenchimento(
      int checklistPreenchidoId, DateTime data);

  /// ❌ Deleta o checklist preenchido
  Future<void> deletarChecklistPreenchido(int checklistPreenchidoId);

  /// 🔍 Verifica se já existe checklist preenchido para essa atividade
  Future<bool> existeChecklistPreenchido(String atividadeId);

  /// 🔍 Busca o checklist preenchido associado a uma atividade
  Future<ChecklistPreenchidoTableDto?> buscarChecklistPreenchido(
      String atividadeId);

  // --------------------- Respostas ---------------------

  /// 💾 Salva uma lista de respostas
  Future<bool> salvarRespostas(List<ChecklistRespostaTableDto> respostas);

  /// 🔍 Busca respostas associadas a um checklist preenchido
  Future<List<ChecklistRespostaTableDto>> buscarRespostas(
      int checklistPreenchidoId);

  /// ❌ Deleta todas as respostas associadas a um checklist preenchido
  Future<void> deletarRespostas(String atividadeId);

  /// 🔍 Verifica se existem respostas para determinado checklist preenchido
  Future<bool> existeRespostas(int checklistPreenchidoId);
}
