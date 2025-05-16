import 'package:drift/drift.dart';
import 'package:sympla_app/core/constants/tipo_atividade_mobile.dart';
import 'package:sympla_app/core/storage/app_database.dart';

class TipoAtividadeTableDto {
  final String uuid;
  final String nome;
  final TipoAtividadeMobile tipoAtividadeMobile;

  TipoAtividadeTableDto({
    required this.uuid,
    required this.nome,
    required this.tipoAtividadeMobile,
  });

  // 🔄 De JSON para DTO
  factory TipoAtividadeTableDto.fromJson(Map<String, dynamic> json) {
    return TipoAtividadeTableDto(
      uuid: json['uuid'],
      nome: json['nome'],
      tipoAtividadeMobile: TipoAtividadeMobile.values.firstWhere(
        (e) => e.name == json['tipoAtividadeMobile'],
        orElse: () => TipoAtividadeMobile.ivItIu,
      ),
    );
  }

  // 🔄 De DTO para JSON
  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'nome': nome,
      'tipoAtividadeMobile': tipoAtividadeMobile.name,
    };
  }

  // 🔄 De DTO para Companion
  TipoAtividadeTableCompanion toCompanion() {
    return TipoAtividadeTableCompanion(
      uuid: Value(uuid),
      nome: Value(nome),
      tipoAtividadeMobile: Value(tipoAtividadeMobile),
      createdAt: Value(DateTime.now()),
      updatedAt: Value(DateTime.now()),
      sincronizado: const Value(true),
    );
  }

  // 🔄 De TableData para DTO
  factory TipoAtividadeTableDto.fromData(TipoAtividadeTableData data) {
    return TipoAtividadeTableDto(
      uuid: data.uuid,
      nome: data.nome,
      tipoAtividadeMobile: TipoAtividadeMobile.values.firstWhere(
        (e) => e.name == data.tipoAtividadeMobile.name,
        orElse: () => TipoAtividadeMobile.ivItIu,
      ),
    );
  }
}
