import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/app_database.dart';

class AprTableDto {
  final String uuid;
  final String nome;
  final String? descricao;

  AprTableDto({
    required this.uuid,
    required this.nome,
    this.descricao,
  });

  factory AprTableDto.fromJson(Map<String, dynamic> json) {
    return AprTableDto(
      uuid: json['id'],
      nome: json['nome'],
      descricao: json['descricao'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': uuid,
      'nome': nome,
      'descricao': descricao,
    };
  }

  // 🔄 Conversão para Companion (para inserção no Drift)
  AprTableCompanion toCompanion() {
    return AprTableCompanion(
      uuid: Value(uuid),
      nome: Value(nome),
      descricao: Value(descricao),
      createdAt: Value(DateTime.now()),
      updatedAt: Value(DateTime.now()),
    );
  }

  // 🔄 Conversão a partir de AprTableData (banco → modelo)
  factory AprTableDto.fromData(AprTableData data) {
    return AprTableDto(
      uuid: data.uuid,
      nome: data.nome,
      descricao: data.descricao,
    );
  }

  AprTableDto copyWith({
    String? uuid,
    String? nome,
    String? descricao,
    String? tipoAtividadeId,
  }) {
    return AprTableDto(
      uuid: uuid ?? this.uuid,
      nome: nome ?? this.nome,
      descricao: descricao ?? this.descricao,
    );
  }
}
