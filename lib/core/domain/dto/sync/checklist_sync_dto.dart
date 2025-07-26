import 'package:sympla_app/core/domain/dto/checklist/checklist_preenchido_table_dto.dart';
import 'package:sympla_app/core/domain/dto/checklist/checklist_resposta_table_dto.dart';

/// DTO para sincronização do checklist de uma atividade
class ChecklistSyncDto {
  final int? id;
  final String atividadeId;
  final String checklistId;
  final String usuarioId;
  final DateTime dataPreenchimento;
  final List<ChecklistRespostaSyncDto> respostas;

  ChecklistSyncDto({
    this.id,
    required this.atividadeId,
    required this.checklistId,
    required this.usuarioId,
    required this.dataPreenchimento,
    this.respostas = const [],
  });

  /// Converte de ChecklistPreenchidoTableDto para ChecklistSyncDto
  factory ChecklistSyncDto.fromChecklistPreenchidoDto(
    ChecklistPreenchidoTableDto checklistPreenchido,
    List<ChecklistRespostaTableDto> respostas,
  ) {
    return ChecklistSyncDto(
      id: checklistPreenchido.id,
      atividadeId: checklistPreenchido.atividadeId,
      checklistId: checklistPreenchido.checklistId,
      usuarioId: checklistPreenchido.usuarioId,
      dataPreenchimento: checklistPreenchido.dataPreenchimento,
      respostas: respostas.map(ChecklistRespostaSyncDto.fromRespostaDto).toList(),
    );
  }

  /// Converte para JSON para envio ao backend
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'atividadeId': atividadeId,
      'checklistId': checklistId,
      'usuarioId': usuarioId,
      'dataPreenchimento': dataPreenchimento.toIso8601String(),
      'respostas': respostas.map((r) => r.toJson()).toList(),
    };
  }
}

/// DTO para sincronização de uma resposta do checklist
class ChecklistRespostaSyncDto {
  final int? id;
  final int checklistPreenchidoId;
  final String perguntaId;
  final String resposta;

  ChecklistRespostaSyncDto({
    this.id,
    required this.checklistPreenchidoId,
    required this.perguntaId,
    required this.resposta,
  });

  /// Converte de ChecklistRespostaTableDto para ChecklistRespostaSyncDto
  factory ChecklistRespostaSyncDto.fromRespostaDto(ChecklistRespostaTableDto resposta) {
    return ChecklistRespostaSyncDto(
      id: resposta.id,
      checklistPreenchidoId: resposta.checklistPreenchidoId,
      perguntaId: resposta.perguntaId,
      resposta: resposta.resposta.name,
    );
  }

  /// Converte para JSON para envio ao backend
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'checklistPreenchidoId': checklistPreenchidoId,
      'perguntaId': perguntaId,
      'resposta': resposta,
    };
  }
}
