import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/app_database.dart';

class AprTableDto {
  final String uuid;
  final String nome;
  final String? descricao;
  final String tipoAtividadeId;

  AprTableDto({
    required this.uuid,
    required this.nome,
    this.descricao,
    required this.tipoAtividadeId,
  });

  factory AprTableDto.fromJson(Map<String, dynamic> json) {
    return AprTableDto(
      uuid: json['id'],
      nome: json['nome'],
      descricao: json['descricao'],
      tipoAtividadeId: json['tipoAtividadeId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': uuid,
      'nome': nome,
      'descricao': descricao,
      'tipoAtividadeId': tipoAtividadeId,
    };
  }

  // 🔄 Conversão para Companion (para inserção no Drift)
  AprTableCompanion toCompanion() {
    return AprTableCompanion(
      uuid: Value(uuid),
      nome: Value(nome),
      tipoAtividadeId: Value(tipoAtividadeId),
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
      tipoAtividadeId: data.tipoAtividadeId,
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
      tipoAtividadeId: tipoAtividadeId ?? this.tipoAtividadeId,
    );
  }
}
