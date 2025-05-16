import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/converters/resposta_apr_converter.dart';

class AprRespostaTableDto {
  final int? id;
  final int aprPreenchidaId;
  final String perguntaId;
  final RespostaApr? resposta;
  final String? observacao;

  AprRespostaTableDto({
    this.id,
    required this.aprPreenchidaId,
    required this.perguntaId,
    required this.resposta,
    this.observacao,
  });

  // 🔄 De JSON para DTO
  factory AprRespostaTableDto.fromJson(Map<String, dynamic> json) {
    return AprRespostaTableDto(
      id: json['id'],
      aprPreenchidaId: json['aprPreenchidaId'],
      perguntaId: json['perguntaId'],
      resposta: RespostaApr.values.firstWhere(
        (e) => e.name == json['resposta'],
        orElse: () => RespostaApr.nao, // fallback seguro
      ),
      observacao: json['observacao'],
    );
  }

  // 🔄 De DTO para JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'aprPreenchidaId': aprPreenchidaId,
      'perguntaId': perguntaId,
      'resposta': resposta?.name,
      'observacao': observacao,
    };
  }

  // 🔄 De DTO para Companion
  AprRespostaTableCompanion toCompanion() {
    return AprRespostaTableCompanion(
      id: id != null ? Value(id!) : const Value.absent(),
      aprPreenchidaId: Value(aprPreenchidaId),
      perguntaId: Value(perguntaId),
      resposta: Value(resposta!),
      observacao: Value(observacao),
    );
  }

  // 🔄 De TableData para DTO
  factory AprRespostaTableDto.fromData(AprRespostaTableData data) {
    return AprRespostaTableDto(
      id: data.id,
      aprPreenchidaId: data.aprPreenchidaId,
      perguntaId: data.perguntaId,
      resposta: RespostaApr.values.firstWhere(
        (e) => e.name == data.resposta.name,
        orElse: () => RespostaApr.nao,
      ),
      observacao: data.observacao,
    );
  }
}
