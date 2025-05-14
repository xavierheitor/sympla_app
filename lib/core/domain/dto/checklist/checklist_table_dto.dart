import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/app_database.dart';

class ChecklistTableDto {
  final String uuid;
  final String nome;
  final String? descricao;
  final String tipoAtividadeId;

  ChecklistTableDto({
    required this.uuid,
    required this.nome,
    this.descricao,
    required this.tipoAtividadeId,
  });

  // 🔄 De JSON para DTO
  factory ChecklistTableDto.fromJson(Map<String, dynamic> json) {
    return ChecklistTableDto(
      uuid: json['uuid'],
      nome: json['nome'],
      descricao: json['descricao'],
      tipoAtividadeId: json['tipoAtividadeId'],
    );
  }

  // 🔄 De DTO para JSON
  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'nome': nome,
      'descricao': descricao,
      'tipoAtividadeId': tipoAtividadeId,
    };
  }

  // 🔄 De DTO para Companion
  ChecklistTableCompanion toCompanion() {
    return ChecklistTableCompanion(
      uuid: Value(uuid),
      nome: Value(nome),
      descricao: Value(descricao),
      tipoAtividadeId: Value(tipoAtividadeId),
      createdAt: Value(DateTime.now()),
      updatedAt: Value(DateTime.now()),
      sincronizado: const Value(true),
    );
  }

  // 🔄 De TableData para DTO
  factory ChecklistTableDto.fromData(ChecklistTableData data) {
    return ChecklistTableDto(
      uuid: data.uuid,
      nome: data.nome,
      descricao: data.descricao,
      tipoAtividadeId: data.tipoAtividadeId,
    );
  }
}
