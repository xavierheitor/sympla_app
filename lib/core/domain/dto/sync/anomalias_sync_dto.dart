import 'package:sympla_app/core/domain/dto/anomalia/anomalia_table_dto.dart';

/// DTO para sincronização de uma anomalia
class AnomaliaSyncDto {
  final int? id;
  final String? perguntaId;
  final String atividadeId;
  final String equipamentoId;
  final String defeitoId;
  final String fase;
  final String lado;
  final double? delta;
  final String? observacao;
  final List<int>? foto; // Uint8List convertido para List<int>
  final bool corrigida;
  final String? nomeEquipamento;
  final String? codigoSapDefeito;

  AnomaliaSyncDto({
    this.id,
    this.perguntaId,
    required this.atividadeId,
    required this.equipamentoId,
    required this.defeitoId,
    required this.fase,
    required this.lado,
    this.delta,
    this.observacao,
    this.foto,
    this.corrigida = false,
    this.nomeEquipamento,
    this.codigoSapDefeito,
  });

  /// Converte de AnomaliaTableDto para AnomaliaSyncDto
  factory AnomaliaSyncDto.fromAnomaliaDto(AnomaliaTableDto anomalia) {
    return AnomaliaSyncDto(
      id: anomalia.id,
      perguntaId: anomalia.perguntaId,
      atividadeId: anomalia.atividadeId,
      equipamentoId: anomalia.equipamentoId,
      defeitoId: anomalia.defeitoId,
      fase: anomalia.fase.name,
      lado: anomalia.lado.name,
      delta: anomalia.delta,
      observacao: anomalia.observacao,
      foto: anomalia.foto?.toList(), // Uint8List para List<int>
      corrigida: anomalia.corrigida,
      nomeEquipamento: anomalia.nomeEquipamento,
      codigoSapDefeito: anomalia.codigoSapDefeito,
    );
  }

  /// Converte para JSON para envio ao backend
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'perguntaId': perguntaId,
      'atividadeId': atividadeId,
      'equipamentoId': equipamentoId,
      'defeitoId': defeitoId,
      'fase': fase,
      'lado': lado,
      'delta': delta,
      'observacao': observacao,
      'foto': foto,
      'corrigida': corrigida,
      'nomeEquipamento': nomeEquipamento,
      'codigoSapDefeito': codigoSapDefeito,
    };
  }
}
