import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/converters/resposta_checklist_converter.dart';

class ChecklistRespostaTableDto {
  final int? id;
  final int checklistPreenchidoId;
  final String perguntaId;
  final RespostaChecklist resposta;

  ChecklistRespostaTableDto({
    this.id,
    required this.checklistPreenchidoId,
    required this.perguntaId,
    required this.resposta,
  });

  // 🔄 De JSON para DTO
  factory ChecklistRespostaTableDto.fromJson(Map<String, dynamic> json) {
    return ChecklistRespostaTableDto(
      id: json['id'],
      checklistPreenchidoId: json['checklistPreenchidoId'],
      perguntaId: json['perguntaId'],
      resposta: RespostaChecklist.values.firstWhere(
        (e) => e.name == json['resposta'],
        orElse: () => RespostaChecklist.nok,
      ),
    );
  }

  // 🔄 De DTO para JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'checklistPreenchidoId': checklistPreenchidoId,
      'perguntaId': perguntaId,
      'resposta': resposta.name,
    };
  }

  // 🔄 De DTO para Companion
  ChecklistRespostaTableCompanion toCompanion() {
    return ChecklistRespostaTableCompanion(
      checklistPreenchidoId: Value(checklistPreenchidoId),
      perguntaId: Value(perguntaId),
      resposta: Value(resposta),
    );
  }

  // 🔄 De TableData para DTO
  factory ChecklistRespostaTableDto.fromData(ChecklistRespostaTableData data) {
    return ChecklistRespostaTableDto(
      id: data.id,
      checklistPreenchidoId: data.checklistPreenchidoId,
      perguntaId: data.perguntaId,
      resposta: RespostaChecklist.values.firstWhere(
        (e) => e.name == data.resposta.name,
        orElse: () => RespostaChecklist.nok,
      ),
    );
  }
}
