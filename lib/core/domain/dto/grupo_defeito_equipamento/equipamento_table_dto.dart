import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/app_database.dart';

class EquipamentoTableDto {
  final String uuid;
  final String nome;
  final String descricao;
  final String subestacao;
  final String grupoId;

  EquipamentoTableDto({
    required this.uuid,
    required this.nome,
    required this.descricao,
    required this.subestacao,
    required this.grupoId,
  });

  // 🔄 De JSON para DTO - com tratamento de null
  factory EquipamentoTableDto.fromJson(Map<String, dynamic> json) {
    return EquipamentoTableDto(
      uuid: (json['id'] ?? '').toString(),
      nome: (json['nome'] ?? '').toString(),
      descricao: (json['descricao'] ?? json['nome'] ?? '').toString(),
      subestacao: (json['subestacao'] ?? '').toString(),
      grupoId: (json['grupoId'] ?? '').toString(),
    );
  }

  // 🔄 De DTO para JSON
  Map<String, dynamic> toJson() {
    return {
      'id': uuid,
      'nome': nome,
      'descricao': descricao,
      'subestacao': subestacao,
      'grupoId': grupoId,
    };
  }

  // 🔄 De DTO para Companion
  EquipamentoTableCompanion toCompanion() {
    return EquipamentoTableCompanion(
      uuid: Value(uuid),
      nome: Value(nome),
      descricao: Value(descricao.isNotEmpty ? descricao : nome),
      subestacao: Value(subestacao),
      grupoId: Value(grupoId.isNotEmpty ? grupoId : 'NAO_ENCONTRADO'),
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
      grupoId: data.grupoId,
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