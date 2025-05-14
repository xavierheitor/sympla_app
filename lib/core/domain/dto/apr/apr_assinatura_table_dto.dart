import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/app_database.dart';

class AprAssinaturaTableDto {
  final int? id;
  final int aprPreenchidaId;
  final String usuarioId;
  final DateTime dataAssinatura;
  final String tecnicoId;
  final Uint8List assinatura;
  final String? assinaturaPath;

  AprAssinaturaTableDto({
    this.id,
    required this.aprPreenchidaId,
    required this.usuarioId,
    required this.dataAssinatura,
    required this.tecnicoId,
    required this.assinatura,
    this.assinaturaPath,
  });

  // 🔄 De JSON para DTO
  factory AprAssinaturaTableDto.fromJson(Map<String, dynamic> json) {
    return AprAssinaturaTableDto(
      id: json['id'],
      aprPreenchidaId: json['aprPreenchidaId'],
      usuarioId: json['usuarioId'],
      dataAssinatura: DateTime.parse(json['dataAssinatura']),
      tecnicoId: json['tecnicoId'],
      assinatura: Uint8List.fromList(List<int>.from(json['assinatura'])),
      assinaturaPath: json['assinaturaPath'],
    );
  }

  // 🔄 De DTO para JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'aprPreenchidaId': aprPreenchidaId,
      'usuarioId': usuarioId,
      'dataAssinatura': dataAssinatura.toIso8601String(),
      'tecnicoId': tecnicoId,
      'assinatura': assinatura,
      'assinaturaPath': assinaturaPath,
    };
  }

  // 🔄 De DTO para Companion
  AprAssinaturaTableCompanion toCompanion() {
    return AprAssinaturaTableCompanion(
      id: id != null ? Value(id!) : const Value.absent(),
      aprPreenchidaId: Value(aprPreenchidaId),
      usuarioId: Value(usuarioId),
      dataAssinatura: Value(dataAssinatura),
      tecnicoId: Value(tecnicoId),
      assinatura: Value(assinatura),
      assinaturaPath: Value(assinaturaPath),
    );
  }

  // 🔄 De TableData para DTO
  factory AprAssinaturaTableDto.fromData(AprAssinaturaTableData data) {
    return AprAssinaturaTableDto(
      id: data.id,
      aprPreenchidaId: data.aprPreenchidaId,
      usuarioId: data.usuarioId,
      dataAssinatura: data.dataAssinatura,
      tecnicoId: data.tecnicoId,
      assinatura: data.assinatura,
      assinaturaPath: data.assinaturaPath,
    );
  }
}
