import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/app_database.dart';

class CorrecaoAnomaliaTableDto {
  final int? id;
  final int anomaliaId;
  final String atividadeId;
  final Uint8List? foto;

  CorrecaoAnomaliaTableDto({
    this.id,
    required this.anomaliaId,
    required this.atividadeId,
    this.foto,
  });

  // 🔄 De JSON para DTO
  factory CorrecaoAnomaliaTableDto.fromJson(Map<String, dynamic> json) {
    return CorrecaoAnomaliaTableDto(
      id: json['id'],
      anomaliaId: json['anomaliaId'],
      atividadeId: json['atividadeId'],
      foto: json['foto'], // cuidado: deve ser Uint8List
    );
  }

  // 🔄 De DTO para JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'anomaliaId': anomaliaId,
      'atividadeId': atividadeId,
      'foto': foto,
    };
  }

  // 🔄 De DTO para Companion
  CorrecaoAnomaliaTableCompanion toCompanion() {
    return CorrecaoAnomaliaTableCompanion(
      id: id != null ? Value(id!) : const Value.absent(),
      anomaliaId: Value(anomaliaId),
      atividadeId: Value(atividadeId),
      foto: Value(foto),
    );
  }

  // 🔄 De TableData para DTO
  factory CorrecaoAnomaliaTableDto.fromData(CorrecaoAnomaliaTableData data) {
    return CorrecaoAnomaliaTableDto(
      id: data.id,
      anomaliaId: data.anomaliaId,
      atividadeId: data.atividadeId,
      foto: data.foto,
    );
  }
}
