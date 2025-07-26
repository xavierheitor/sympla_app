import 'package:sympla_app/core/domain/dto/apr/apr_assinatura_table_dto.dart';
import 'package:sympla_app/core/domain/dto/apr/apr_preenchida_table_dto.dart';
import 'package:sympla_app/core/domain/dto/apr/apr_resposta_table_dto.dart';

/// DTO para sincronização da APR de uma atividade
class AprSyncDto {
  final int? id;
  final String atividadeId;
  final String aprId;
  final String usuarioId;
  final DateTime dataPreenchimento;
  final List<AprRespostaSyncDto> respostas;
  final List<AprAssinaturaSyncDto> assinaturas;

  AprSyncDto({
    this.id,
    required this.atividadeId,
    required this.aprId,
    required this.usuarioId,
    required this.dataPreenchimento,
    this.respostas = const [],
    this.assinaturas = const [],
  });

  /// Converte de AprPreenchidaTableDto para AprSyncDto
  factory AprSyncDto.fromAprPreenchidaDto(
    AprPreenchidaTableDto aprPreenchida,
    List<AprRespostaTableDto> respostas,
    List<AprAssinaturaTableDto> assinaturas,
  ) {
    return AprSyncDto(
      id: aprPreenchida.id,
      atividadeId: aprPreenchida.atividadeId,
      aprId: aprPreenchida.aprId,
      usuarioId: aprPreenchida.usuarioId,
      dataPreenchimento: aprPreenchida.dataPreenchimento,
      respostas: respostas.map(AprRespostaSyncDto.fromRespostaDto).toList(),
      assinaturas: assinaturas.map(AprAssinaturaSyncDto.fromAssinaturaDto).toList(),
    );
  }

  /// Converte para JSON para envio ao backend
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'atividadeId': atividadeId,
      'aprId': aprId,
      'usuarioId': usuarioId,
      'dataPreenchimento': dataPreenchimento.toIso8601String(),
      'respostas': respostas.map((r) => r.toJson()).toList(),
      'assinaturas': assinaturas.map((a) => a.toJson()).toList(),
    };
  }
}

/// DTO para sincronização de uma resposta da APR
class AprRespostaSyncDto {
  final int? id;
  final int aprPreenchidaId;
  final String perguntaId;
  final String? resposta;
  final String? observacao;

  AprRespostaSyncDto({
    this.id,
    required this.aprPreenchidaId,
    required this.perguntaId,
    this.resposta,
    this.observacao,
  });

  /// Converte de AprRespostaTableDto para AprRespostaSyncDto
  factory AprRespostaSyncDto.fromRespostaDto(AprRespostaTableDto resposta) {
    return AprRespostaSyncDto(
      id: resposta.id,
      aprPreenchidaId: resposta.aprPreenchidaId,
      perguntaId: resposta.perguntaId,
      resposta: resposta.resposta?.name,
      observacao: resposta.observacao,
    );
  }

  /// Converte para JSON para envio ao backend
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'aprPreenchidaId': aprPreenchidaId,
      'perguntaId': perguntaId,
      'resposta': resposta,
      'observacao': observacao,
    };
  }
}

/// DTO para sincronização de uma assinatura da APR
class AprAssinaturaSyncDto {
  final int? id;
  final int aprPreenchidaId;
  final String usuarioId;
  final DateTime dataAssinatura;
  final String tecnicoId;
  final List<int> assinatura; // Uint8List convertido para List<int>
  final String? assinaturaPath;

  AprAssinaturaSyncDto({
    this.id,
    required this.aprPreenchidaId,
    required this.usuarioId,
    required this.dataAssinatura,
    required this.tecnicoId,
    required this.assinatura,
    this.assinaturaPath,
  });

  /// Converte de AprAssinaturaTableDto para AprAssinaturaSyncDto
  factory AprAssinaturaSyncDto.fromAssinaturaDto(AprAssinaturaTableDto assinatura) {
    return AprAssinaturaSyncDto(
      id: assinatura.id,
      aprPreenchidaId: assinatura.aprPreenchidaId,
      usuarioId: assinatura.usuarioId,
      dataAssinatura: assinatura.dataAssinatura,
      tecnicoId: assinatura.tecnicoId,
      assinatura: assinatura.assinatura.toList(), // Uint8List para List<int>
      assinaturaPath: assinatura.assinaturaPath,
    );
  }

  /// Converte para JSON para envio ao backend
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'aprPreenchidaId': aprPreenchidaId,
      'usuarioId': usuarioId,
      'dataAssinatura': dataAssinatura.toIso8601String(),
      'tecnicoId': tecnicoId,
      'assinatura': assinatura,
      'assinaturaPath': assinaturaPath,
    };
  }
}
