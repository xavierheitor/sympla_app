import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/app_database.dart';

class UsuarioTableDto {
  final String uuid;
  final String nome;
  final String matricula;
  final String? token;
  final String? refreshToken;
  final DateTime? ultimoLogin;

  UsuarioTableDto({
    required this.uuid,
    required this.nome,
    required this.matricula,
    this.token,
    this.refreshToken,
    this.ultimoLogin,
  });

  // 🔄 De JSON para DTO
  factory UsuarioTableDto.fromJson(Map<String, dynamic> json) {
    return UsuarioTableDto(
      uuid: json['uuid'],
      nome: json['nome'],
      matricula: json['matricula'],
      token: json['token'],
      refreshToken: json['refreshToken'],
      ultimoLogin: json['ultimoLogin'] != null
          ? DateTime.parse(json['ultimoLogin'])
          : null,
    );
  }

  // 🔄 De DTO para JSON
  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'nome': nome,
      'matricula': matricula,
      'token': token,
      'refreshToken': refreshToken,
      'ultimoLogin': ultimoLogin?.toIso8601String(),
    };
  }

  // 🔄 De DTO para Companion
  UsuarioTableCompanion toCompanion() {
    return UsuarioTableCompanion(
      uuid: Value(uuid),
      nome: Value(nome),
      matricula: Value(matricula),
      token: Value(token),
      refreshToken: Value(refreshToken),
      ultimoLogin: Value(ultimoLogin),
      createdAt: Value(DateTime.now()),
    );
  }

  // 🔄 De TableData para DTO
  factory UsuarioTableDto.fromData(UsuarioTableData data) {
    return UsuarioTableDto(
      uuid: data.uuid,
      nome: data.nome,
      matricula: data.matricula,
      token: data.token,
      refreshToken: data.refreshToken,
      ultimoLogin: data.ultimoLogin,
    );
  }
}
