import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/app_database.dart';

class TecnicoTableDto {
  final String uuid;
  final String nome;
  final String matricula;

  TecnicoTableDto({
    required this.uuid,
    required this.nome,
    required this.matricula,
  });

  // 🔄 De JSON para Modelo
  factory TecnicoTableDto.fromJson(Map<String, dynamic> json) {
    return TecnicoTableDto(
      uuid: json['id'],
      nome: json['nome'],
      matricula: json['matricula'],
    );
  }

  // 🔄 De Modelo para JSON
  Map<String, dynamic> toJson() {
    return {
      'id': uuid,
      'nome': nome,
      'matricula': matricula,
    };
  }

  // 🔄 De Modelo para Companion (inserção/atualização no Drift)
  TecnicoTableCompanion toCompanion() {
    return TecnicoTableCompanion(
      uuid: Value(uuid),
      nome: Value(nome),
      matricula: Value(matricula),
      createdAt: Value(DateTime.now()),
      updatedAt: Value(DateTime.now()),
      sincronizado: const Value(true),
    );
  }

  // 🔄 De Dados do banco para Modelo
  factory TecnicoTableDto.fromData(TecnicoTableData data) {
    return TecnicoTableDto(
      uuid: data.uuid,
      nome: data.nome,
      matricula: data.matricula,
    );
  }
}

class TecnicosTableCompanion {}
