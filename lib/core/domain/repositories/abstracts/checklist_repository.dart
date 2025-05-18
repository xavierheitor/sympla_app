import 'package:sympla_app/core/domain/dto/checklist/checklist_pergunta_table_dto.dart';
import 'package:sympla_app/core/domain/dto/checklist/checklist_preenchido_table_dto.dart';
import 'package:sympla_app/core/domain/dto/checklist/checklist_resposta_table_dto.dart';
import 'package:sympla_app/core/domain/dto/checklist/checklist_table_dto.dart';

abstract class ChecklistRepository {
  // --------------------- Modelo ---------------------
  Future<ChecklistTableDto?> buscarModeloPorTipoAtividade(
      String idTipoAtividade);
  Future<bool> checklistEstaVazio(); // <-- Corrigido

  // --------------------- Perguntas ---------------------
  Future<List<ChecklistPerguntaTableDto>> buscarPerguntasRelacionadas(
      String checklistId);

  // --------------------- Checklist Preenchido ---------------------
  Future<int> criarChecklistPreenchido(ChecklistPreenchidoTableDto checklist);
  Future<void> atualizarDataPreenchimento(
      int checklistPreenchidoId, DateTime data);
  Future<void> deletarChecklistPreenchido(int checklistPreenchidoId);
  Future<bool> existeChecklistPreenchido(String atividadeId);
  Future<ChecklistPreenchidoTableDto?> buscarChecklistPreenchido(
      String atividadeId);

  // --------------------- Respostas ---------------------
  Future<bool> salvarRespostas(List<ChecklistRespostaTableDto> respostas);
  Future<List<ChecklistRespostaTableDto>> buscarRespostas(
      int checklistPreenchidoId);
  Future<void> deletarRespostas(int checklistPreenchidoId);
  Future<bool> existeRespostas(int checklistPreenchidoId);
}
