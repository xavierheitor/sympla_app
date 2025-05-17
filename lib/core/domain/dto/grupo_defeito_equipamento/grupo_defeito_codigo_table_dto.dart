import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/app_database.dart';

class GrupoDefeitoCodigoTableDto {
  final String uuid;
  final String sigla;
  final String codigo;
  final String grupoDefeitoId;

  GrupoDefeitoCodigoTableDto({
    required this.uuid,
    required this.sigla,
    required this.codigo,
    required this.grupoDefeitoId,
  });

  // 🔄 De JSON para DTO
  factory GrupoDefeitoCodigoTableDto.fromJson(Map<String, dynamic> json) {
    return GrupoDefeitoCodigoTableDto(
      uuid: json['id'],
      sigla: json['sigla'],
      codigo: json['codigo'],
      grupoDefeitoId: json['grupoId'],
    );
  }

  // 🔄 De DTO para JSON
  Map<String, dynamic> toJson() {
    return {
      'id': uuid,
      'sigla': sigla,
      'codigo': codigo,
      'grupoId': grupoDefeitoId,
    };
  }

  // 🔄 De DTO para Companion
  GrupoDefeitoCodigoTableCompanion toCompanion() {
    return GrupoDefeitoCodigoTableCompanion(
      uuid: Value(uuid),
      sigla: Value(sigla),
      codigo: Value(codigo),
      grupoDefeitoId: Value(grupoDefeitoId),
      createdAt: Value(DateTime.now()),
      updatedAt: Value(DateTime.now()),
      sincronizado: const Value(true),
    );
  }

  // 🔄 De TableData para DTO
  factory GrupoDefeitoCodigoTableDto.fromData(
    GrupoDefeitoCodigoTableData data,
  ) {
    return GrupoDefeitoCodigoTableDto(
      uuid: data.uuid,
      sigla: data.sigla,
      codigo: data.codigo,
      grupoDefeitoId: data.grupoDefeitoId,
    );
  }
}
