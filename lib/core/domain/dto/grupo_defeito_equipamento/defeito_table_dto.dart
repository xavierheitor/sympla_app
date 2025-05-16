import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/converters/prioridade_defeito_converter.dart';

class DefeitoTableDto {
  final String uuid;
  final String grupoId;
  final String subgrupoId;
  final String grupoDefeitoCodigoId;
  final String codigoSap;
  final String descricao;
  final PrioridadeDefeito prioridade;

  DefeitoTableDto({
    required this.uuid,
    required this.grupoId,
    required this.subgrupoId,
    required this.grupoDefeitoCodigoId,
    required this.codigoSap,
    required this.descricao,
    required this.prioridade,
  });

  // 🔄 De JSON para DTO
  factory DefeitoTableDto.fromJson(Map<String, dynamic> json) {
    return DefeitoTableDto(
      uuid: json['uuid'],
      grupoId: json['grupoId'],
      subgrupoId: json['subgrupoId'],
      grupoDefeitoCodigoId: json['grupoDefeitoCodigoId'],
      codigoSap: json['codigoSap'],
      descricao: json['descricao'],
      prioridade: PrioridadeDefeito.values.firstWhere(
        (e) => e.name == json['prioridade'],
        orElse: () => PrioridadeDefeito.p1,
      ),
    );
  }

  // 🔄 De DTO para JSON
  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'grupoId': grupoId,
      'subgrupoId': subgrupoId,
      'grupoDefeitoCodigoId': grupoDefeitoCodigoId,
      'codigoSap': codigoSap,
      'descricao': descricao,
      'prioridade': prioridade.name,
    };
  }

  // 🔄 De DTO para Companion
  DefeitoTableCompanion toCompanion() {
    return DefeitoTableCompanion(
      uuid: Value(uuid),
      grupoId: Value(grupoId),
      subgrupoId: Value(subgrupoId),
      grupoDefeitoCodigoId: Value(grupoDefeitoCodigoId),
      codigoSap: Value(codigoSap),
      descricao: Value(descricao),
      prioridade: Value(prioridade),
      createdAt: Value(DateTime.now()),
      updatedAt: Value(DateTime.now()),
      sincronizado: const Value(true),
    );
  }

  // 🔄 De TableData para DTO
  factory DefeitoTableDto.fromData(DefeitoTableData data) {
    return DefeitoTableDto(
      uuid: data.uuid,
      grupoId: data.grupoId,
      subgrupoId: data.subgrupoId,
      grupoDefeitoCodigoId: data.grupoDefeitoCodigoId,
      codigoSap: data.codigoSap,
      descricao: data.descricao,
      prioridade: PrioridadeDefeito.values.firstWhere(
        (e) => e.name == data.prioridade.name,
        orElse: () => PrioridadeDefeito.p1,
      ),
    );
  }
}
