import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/app_database.dart';

class EquipamentoTableDto {
  final String uuid;
  final String nome;
  final String descricao;
  final String subestacao;
  final String grupoDefeitoCodigo;

  EquipamentoTableDto({
    required this.uuid,
    required this.nome,
    required this.descricao,
    required this.subestacao,
    required this.grupoDefeitoCodigo,
  });

  // 🔄 De JSON para DTO
  factory EquipamentoTableDto.fromJson(Map<String, dynamic> json) {
    return EquipamentoTableDto(
      uuid: json['id'],
      nome: json['nome'],
      descricao: json['descricao'],
      subestacao: json['subestacao'],
      grupoDefeitoCodigo: json['grupoDefeitoCodigo'],
    );
  }

  // 🔄 De DTO para JSON
  Map<String, dynamic> toJson() {
    return {
      'id': uuid,
      'nome': nome,
      'descricao': descricao,
      'subestacao': subestacao,
      'grupoDefeitoCodigo': grupoDefeitoCodigo,
    };
  }

  // 🔄 De DTO para Companion
  EquipamentoTableCompanion toCompanion() {
    return EquipamentoTableCompanion(
      uuid: Value(uuid),
      nome: Value(nome),
      descricao: Value(descricao),
      subestacao: Value(subestacao),
      grupoDefeitoCodigo: Value(grupoDefeitoCodigo),
      createdAt: Value(DateTime.now()),
      updatedAt: Value(DateTime.now()),
      sincronizado: const Value(true),
    );
  }

  // 🔄 De TableData para DTO
  factory EquipamentoTableDto.fromData(EquipamentoTableData data) {
    return EquipamentoTableDto(
      uuid: data.uuid,
      nome: data.nome,
      descricao: data.descricao,
      subestacao: data.subestacao,
      grupoDefeitoCodigo: data.grupoDefeitoCodigo,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is EquipamentoTableDto && other.uuid == uuid;
  }

  @override
  int get hashCode => uuid.hashCode;
}
