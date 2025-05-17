import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/app_database.dart';

class GrupoDefeitoEquipamentoTableDto {
  final String uuid;
  final String nome;

  GrupoDefeitoEquipamentoTableDto({
    required this.uuid,
    required this.nome,
  });

  // 🔄 De JSON para DTO
  factory GrupoDefeitoEquipamentoTableDto.fromJson(Map<String, dynamic> json) {
    return GrupoDefeitoEquipamentoTableDto(
      uuid: json['id'],
      nome: json['nome'],
    );
  }

  // 🔄 De DTO para JSON
  Map<String, dynamic> toJson() {
    return {
      'id': uuid,
      'nome': nome,
    };
  }

  // 🔄 De DTO para Companion
  GrupoDefeitoEquipamentoTableCompanion toCompanion() {
    return GrupoDefeitoEquipamentoTableCompanion(
      uuid: Value(uuid),
      nome: Value(nome),
      createdAt: Value(DateTime.now()),
      updatedAt: Value(DateTime.now()),
      sincronizado: const Value(true),
    );
  }

  // 🔄 De TableData para DTO
  factory GrupoDefeitoEquipamentoTableDto.fromData(
    GrupoDefeitoEquipamentoTableData data,
  ) {
    return GrupoDefeitoEquipamentoTableDto(
      uuid: data.uuid,
      nome: data.nome,
    );
  }
}
