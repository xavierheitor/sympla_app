import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/app_database.dart';

class AprPreenchidaTableDto {
  final int? id;
  final String atividadeId;
  final String aprId;
  final String usuarioId;
  final DateTime dataPreenchimento;

  AprPreenchidaTableDto({
    this.id,
    required this.atividadeId,
    required this.aprId,
    required this.usuarioId,
    required this.dataPreenchimento,
  });

  // 🔄 De JSON para DTO
  factory AprPreenchidaTableDto.fromJson(Map<String, dynamic> json) {
    return AprPreenchidaTableDto(
      id: json['id'],
      atividadeId: json['atividadeId'],
      aprId: json['aprId'],
      usuarioId: json['usuarioId'],
      dataPreenchimento: DateTime.parse(json['dataPreenchimento']),
    );
  }

  // 🔄 De DTO para JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'atividadeId': atividadeId,
      'aprId': aprId,
      'usuarioId': usuarioId,
      'dataPreenchimento': dataPreenchimento.toIso8601String(),
    };
  }

  // 🔄 De DTO para Companion
  AprPreenchidaTableCompanion toCompanion() {
    return AprPreenchidaTableCompanion(
      id: id != null ? Value(id!) : const Value.absent(),
      atividadeId: Value(atividadeId),
      aprId: Value(aprId),
      usuarioId: Value(usuarioId),
      dataPreenchimento: Value(dataPreenchimento),
    );
  }

  // 🔄 De TableData para DTO
  factory AprPreenchidaTableDto.fromData(AprPreenchidaTableData data) {
    return AprPreenchidaTableDto(
      id: data.id,
      atividadeId: data.atividadeId,
      aprId: data.aprId,
      usuarioId: data.usuarioId,
      dataPreenchimento: data.dataPreenchimento,
    );
  }

  AprPreenchidaTableDto copyWith({
    int? id,
    String? atividadeId,
    String? aprId,
    String? usuarioId,
    DateTime? dataPreenchimento,
  }) {
    return AprPreenchidaTableDto(
      id: id ?? this.id,
      atividadeId: atividadeId ?? this.atividadeId,
      aprId: aprId ?? this.aprId,
      usuarioId: usuarioId ?? this.usuarioId,
      dataPreenchimento: dataPreenchimento ?? this.dataPreenchimento,
    );
  }
}
