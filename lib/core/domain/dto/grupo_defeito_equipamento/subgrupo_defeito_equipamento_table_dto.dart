import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/app_database.dart';

class SubgrupoDefeitoEquipamentoTableDto {
  final String uuid;
  final String nome;
  final String grupoDefeitoId;

  SubgrupoDefeitoEquipamentoTableDto({
    required this.uuid,
    required this.nome,
    required this.grupoDefeitoId,
  });

  // 🔄 De JSON para DTO
  factory SubgrupoDefeitoEquipamentoTableDto.fromJson(
      Map<String, dynamic> json) {
    return SubgrupoDefeitoEquipamentoTableDto(
      uuid: json['uuid'],
      nome: json['nome'],
      grupoDefeitoId: json['grupoDefeitoId'],
    );
  }

  // 🔄 De DTO para JSON
  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'nome': nome,
      'grupoDefeitoId': grupoDefeitoId,
    };
  }

  // 🔄 De DTO para Companion
  SubgrupoDefeitoEquipamentoTableCompanion toCompanion() {
    return SubgrupoDefeitoEquipamentoTableCompanion(
      uuid: Value(uuid),
      nome: Value(nome),
      grupoDefeitoId: Value(grupoDefeitoId),
      createdAt: Value(DateTime.now()),
      updatedAt: Value(DateTime.now()),
      sincronizado: const Value(true),
    );
  }

  // 🔄 De TableData para DTO
  factory SubgrupoDefeitoEquipamentoTableDto.fromData(
    SubgrupoDefeitoEquipamentoTableData data,
  ) {
    return SubgrupoDefeitoEquipamentoTableDto(
      uuid: data.uuid,
      nome: data.nome,
      grupoDefeitoId: data.grupoDefeitoId,
    );
  }
}
