import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/app_database.dart';

class ChecklistPerguntaRelacionamentoTableDto {
  final String uuid;
  final String checklistId;
  final String perguntaId;
  final int ordem;

  ChecklistPerguntaRelacionamentoTableDto({
    required this.uuid,
    required this.checklistId,
    required this.perguntaId,
    required this.ordem,
  });

  // 🔄 De JSON para DTO
  factory ChecklistPerguntaRelacionamentoTableDto.fromJson(
      Map<String, dynamic> json) {
    return ChecklistPerguntaRelacionamentoTableDto(
      uuid: json['uuid'],
      checklistId: json['checklistId'],
      perguntaId: json['perguntaId'],
      ordem: json['ordem'] ?? 0,
    );
  }

  // 🔄 De DTO para JSON
  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'checklistId': checklistId,
      'perguntaId': perguntaId,
      'ordem': ordem,
    };
  }

  // 🔄 De DTO para Companion
  ChecklistPerguntaRelacionamentoTableCompanion toCompanion() {
    return ChecklistPerguntaRelacionamentoTableCompanion(
      uuid: Value(uuid),
      checklistId: Value(checklistId),
      perguntaId: Value(perguntaId),
      ordem: Value(ordem),
      createdAt: Value(DateTime.now()),
      updatedAt: Value(DateTime.now()),
      sincronizado: const Value(true),
    );
  }

  // 🔄 De TableData para DTO
  factory ChecklistPerguntaRelacionamentoTableDto.fromData(
      ChecklistPerguntaRelacionamentoTableData data) {
    return ChecklistPerguntaRelacionamentoTableDto(
      uuid: data.uuid,
      checklistId: data.checklistId,
      perguntaId: data.perguntaId,
      ordem: data.ordem,
    );
  }
}
