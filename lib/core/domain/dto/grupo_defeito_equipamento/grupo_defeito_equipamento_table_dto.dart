import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/app_database.dart';

class GrupoDefeitoEquipamentoTableDto {
  final String uuid;
  final String nome;
  final String codigo;

  GrupoDefeitoEquipamentoTableDto({
    required this.uuid,
    required this.nome,
    required this.codigo,
  });

  // 🔄 De JSON para DTO
  factory GrupoDefeitoEquipamentoTableDto.fromJson(Map<String, dynamic> json) {
    return GrupoDefeitoEquipamentoTableDto(
      uuid: json['id'],
      nome: json['nome'],
      codigo: json['codigo'],
    );
  }

  // 🔄 De DTO para JSON
  Map<String, dynamic> toJson() {
    return {
      'id': uuid,
      'nome': nome,
      'codigo': codigo,
    };
  }

  // 🔄 De DTO para Companion
  GrupoDefeitoEquipamentoTableCompanion toCompanion() {
    return GrupoDefeitoEquipamentoTableCompanion(
      uuid: Value(uuid),
      nome: Value(nome),
      codigo: Value(codigo),
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
      codigo: data.codigo,
    );
  }
}
