import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/app_database.dart';

class AprPerguntaRelacionamentoTableDto {
  final String uuid;
  final String aprId;
  final String perguntaId;
  final int ordem;

  AprPerguntaRelacionamentoTableDto({
    required this.uuid,
    required this.aprId,
    required this.perguntaId,
    required this.ordem,
  });

  // 🔄 De JSON para DTO
  factory AprPerguntaRelacionamentoTableDto.fromJson(
      Map<String, dynamic> json) {
    return AprPerguntaRelacionamentoTableDto(
      uuid: json['uuid'],
      aprId: json['aprId'],
      perguntaId: json['perguntaId'],
      ordem: json['ordem'],
    );
  }

  // 🔄 De DTO para JSON
  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'aprId': aprId,
      'perguntaId': perguntaId,
      'ordem': ordem,
    };
  }

  // 🔄 De DTO para Companion
  AprPerguntaRelacionamentoTableCompanion toCompanion() {
    return AprPerguntaRelacionamentoTableCompanion(
      uuid: Value(uuid),
      aprId: Value(aprId),
      perguntaId: Value(perguntaId),
      ordem: Value(ordem),
      createdAt: Value(DateTime.now()),
      updatedAt: Value(DateTime.now()),
      sincronizado: const Value(true),
    );
  }

  // 🔄 De TableData para DTO
  factory AprPerguntaRelacionamentoTableDto.fromData(
    AprPerguntaRelacionamentoTableData data,
  ) {
    return AprPerguntaRelacionamentoTableDto(
      uuid: data.uuid,
      aprId: data.aprId,
      perguntaId: data.perguntaId,
      ordem: data.ordem,
    );
  }
}
