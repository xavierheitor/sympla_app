import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/app_database.dart';

class ChecklistPreenchidoTableDto {
  final int id;
  final String atividadeId;
  final String checklistId;
  final String usuarioId;
  final DateTime dataPreenchimento;

  ChecklistPreenchidoTableDto({
    required this.id,
    required this.atividadeId,
    required this.checklistId,
    required this.usuarioId,
    required this.dataPreenchimento,
  });

  // 🔄 De JSON para DTO
  factory ChecklistPreenchidoTableDto.fromJson(Map<String, dynamic> json) {
    return ChecklistPreenchidoTableDto(
      id: json['id'],
      atividadeId: json['atividadeId'],
      checklistId: json['checklistId'],
      usuarioId: json['usuarioId'],
      dataPreenchimento: DateTime.parse(json['dataPreenchimento']),
    );
  }

  // 🔄 De DTO para JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'atividadeId': atividadeId,
      'checklistId': checklistId,
      'usuarioId': usuarioId,
      'dataPreenchimento': dataPreenchimento.toIso8601String(),
    };
  }

  // 🔄 De DTO para Companion
  ChecklistPreenchidoTableCompanion toCompanion() {
    return ChecklistPreenchidoTableCompanion(
      id: Value(id),
      atividadeId: Value(atividadeId),
      checklistId: Value(checklistId),
      usuarioId: Value(usuarioId),
      dataPreenchimento: Value(dataPreenchimento),
    );
  }

  // 🔄 De TableData para DTO
  factory ChecklistPreenchidoTableDto.fromData(
      ChecklistPreenchidoTableData data) {
    return ChecklistPreenchidoTableDto(
      id: data.id,
      atividadeId: data.atividadeId,
      checklistId: data.checklistId,
      usuarioId: data.usuarioId,
      dataPreenchimento: data.dataPreenchimento,
    );
  }
}
