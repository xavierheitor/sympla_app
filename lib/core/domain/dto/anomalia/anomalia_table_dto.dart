import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/converters/fase_converter.dart';
import 'package:sympla_app/core/storage/converters/lado_converter.dart';

class AnomaliaTableDto {
  final int? id;
  final String? perguntaId;
  final String atividadeId;
  final String equipamentoId;
  final String defeitoId;
  final FaseAnomalia fase;
  final LadoAnomalia lado;
  final double? delta;
  final String? observacao;
  final Uint8List? foto;
  final bool corrigida;
  final String? nomeEquipamento;
  final String? codigoSapDefeito;

  AnomaliaTableDto({
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

  // 🔄 De JSON para DTO
  factory AnomaliaTableDto.fromJson(Map<String, dynamic> json) {
    return AnomaliaTableDto(
      id: json['id'],
      perguntaId: json['perguntaId'],
      atividadeId: json['atividadeId'],
      equipamentoId: json['equipamentoId'],
      defeitoId: json['defeitoId'],
      fase: FaseAnomalia.values.firstWhere(
        (e) => e.name == json['fase'],
        orElse: () => FaseAnomalia.a,
      ),
      lado: LadoAnomalia.values.firstWhere(
        (e) => e.name == json['lado'],
        orElse: () => LadoAnomalia.carga,
      ),
      delta: (json['delta'] as num?)?.toDouble(),
      observacao: json['observacao'],
      foto: json['foto'], // cuidado: deve ser Uint8List
      corrigida: json['corrigida'] ?? false,
    );
  }

  // 🔄 De DTO para JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'perguntaId': perguntaId,
      'atividadeId': atividadeId,
      'equipamentoId': equipamentoId,
      'defeitoId': defeitoId,
      'fase': fase.name,
      'lado': lado.name,
      'delta': delta,
      'observacao': observacao,
      'foto': foto,
      'corrigida': corrigida,
    };
  }

  // 🔄 De DTO para Companion
  AnomaliaTableCompanion toCompanion() {
    return AnomaliaTableCompanion(
      id: id != null ? Value(id!) : const Value.absent(),
      perguntaId: Value(perguntaId),
      atividadeId: Value(atividadeId),
      equipamentoId: Value(equipamentoId),
      defeitoId: Value(defeitoId),
      fase: Value(fase),
      lado: Value(lado),
      delta: Value(delta),
      observacao: Value(observacao),
      foto: Value(foto),
      corrigida: Value(corrigida),
    );
  }

  // 🔄 De TableData para DTO
  factory AnomaliaTableDto.fromData(AnomaliaTableData data) {
    return AnomaliaTableDto(
      id: data.id,
      perguntaId: data.perguntaId,
      atividadeId: data.atividadeId,
      equipamentoId: data.equipamentoId,
      defeitoId: data.defeitoId,
      fase: FaseAnomalia.values.firstWhere(
        (e) => e.name == data.fase.name,
        orElse: () => FaseAnomalia.a,
      ),
      lado: LadoAnomalia.values.firstWhere(
        (e) => e.name == data.lado.name,
        orElse: () => LadoAnomalia.carga,
      ),
      delta: data.delta,
      observacao: data.observacao,
      foto: data.foto,
      corrigida: data.corrigida,
    );
  }

  factory AnomaliaTableDto.fromJoinedData({
    required AnomaliaTableData anomalia,
    String? nomeEquipamento,
    String? codigoSapDefeito,
  }) {
    return AnomaliaTableDto(
      id: anomalia.id,
      perguntaId: anomalia.perguntaId,
      atividadeId: anomalia.atividadeId,
      equipamentoId: anomalia.equipamentoId,
      defeitoId: anomalia.defeitoId,
      fase: FaseAnomalia.values.firstWhere(
        (e) => e.name == anomalia.fase.name,
        orElse: () => FaseAnomalia.a,
      ),
      lado: LadoAnomalia.values.firstWhere(
        (e) => e.name == anomalia.lado.name,
        orElse: () => LadoAnomalia.carga,
      ),
      delta: anomalia.delta,
      observacao: anomalia.observacao,
      foto: anomalia.foto,
      corrigida: anomalia.corrigida,
      nomeEquipamento: nomeEquipamento,
      codigoSapDefeito: codigoSapDefeito,
    );
  }
}
