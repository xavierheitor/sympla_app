import 'package:sympla_app/core/domain/dto/atividade/atividade_table_dto.dart';
import 'package:sympla_app/core/domain/dto/sync/anomalias_sync_dto.dart';
import 'package:sympla_app/core/domain/dto/sync/apr_sync_dto.dart';
import 'package:sympla_app/core/domain/dto/sync/checklist_sync_dto.dart';
import 'package:sympla_app/core/domain/dto/sync/mpbb_sync_dto.dart';
import 'package:sympla_app/core/domain/dto/sync/mpdj_sync_dto.dart';

/// DTO principal para sincronização de uma atividade completa
/// Contém todos os dados correlatos: atividade, checklist, apr, anomalias, mpdj, mpbb
class AtividadeSyncDto {
  final String uuid;
  final String titulo;
  final String ordemServico;
  final String descricao;
  final String subestacao;
  final String status;
  final DateTime dataLimite;
  final DateTime? dataInicio;
  final DateTime? dataFim;
  final String equipamentoId;
  final String tipoAtividadeId;
  final String? equipamentoNome;
  final String? tipoAtividadeNome;

  // Dados correlatos
  final ChecklistSyncDto? checklist;
  final AprSyncDto? apr;
  final List<AnomaliaSyncDto> anomalias;
  final MpDjSyncDto? mpdj;
  final MpBbSyncDto? mpbb;

  AtividadeSyncDto({
    required this.uuid,
    required this.titulo,
    required this.ordemServico,
    required this.descricao,
    required this.subestacao,
    required this.status,
    required this.dataLimite,
    this.dataInicio,
    this.dataFim,
    required this.equipamentoId,
    required this.tipoAtividadeId,
    this.equipamentoNome,
    this.tipoAtividadeNome,
    this.checklist,
    this.apr,
    this.anomalias = const [],
    this.mpdj,
    this.mpbb,
  });

  /// Converte de AtividadeTableDto para AtividadeSyncDto
  factory AtividadeSyncDto.fromAtividadeDto(AtividadeTableDto atividade) {
    return AtividadeSyncDto(
      uuid: atividade.uuid,
      titulo: atividade.titulo,
      ordemServico: atividade.ordemServico,
      descricao: atividade.descricao,
      subestacao: atividade.subestacao,
      status: atividade.status.name,
      dataLimite: atividade.dataLimite,
      dataInicio: atividade.dataInicio,
      dataFim: atividade.dataFim,
      equipamentoId: atividade.equipamentoId,
      tipoAtividadeId: atividade.tipoAtividadeId,
      equipamentoNome: atividade.equipamento?.nome,
      tipoAtividadeNome: atividade.tipoAtividade?.nome,
    );
  }

  /// Converte para JSON para envio ao backend
  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'titulo': titulo,
      'ordemServico': ordemServico,
      'descricao': descricao,
      'subestacao': subestacao,
      'status': status,
      'dataLimite': dataLimite.toIso8601String(),
      'dataInicio': dataInicio?.toIso8601String(),
      'dataFim': dataFim?.toIso8601String(),
      'equipamentoId': equipamentoId,
      'tipoAtividadeId': tipoAtividadeId,
      'equipamentoNome': equipamentoNome,
      'tipoAtividadeNome': tipoAtividadeNome,
      'checklist': checklist?.toJson(),
      'apr': apr?.toJson(),
      'anomalias': anomalias.map((a) => a.toJson()).toList(),
      'mpdj': mpdj?.toJson(),
      'mpbb': mpbb?.toJson(),
    };
  }

  /// Cria uma cópia com dados atualizados
  AtividadeSyncDto copyWith({
    String? uuid,
    String? titulo,
    String? ordemServico,
    String? descricao,
    String? subestacao,
    String? status,
    DateTime? dataLimite,
    DateTime? dataInicio,
    DateTime? dataFim,
    String? equipamentoId,
    String? tipoAtividadeId,
    String? equipamentoNome,
    String? tipoAtividadeNome,
    ChecklistSyncDto? checklist,
    AprSyncDto? apr,
    List<AnomaliaSyncDto>? anomalias,
    MpDjSyncDto? mpdj,
    MpBbSyncDto? mpbb,
  }) {
    return AtividadeSyncDto(
      uuid: uuid ?? this.uuid,
      titulo: titulo ?? this.titulo,
      ordemServico: ordemServico ?? this.ordemServico,
      descricao: descricao ?? this.descricao,
      subestacao: subestacao ?? this.subestacao,
      status: status ?? this.status,
      dataLimite: dataLimite ?? this.dataLimite,
      dataInicio: dataInicio ?? this.dataInicio,
      dataFim: dataFim ?? this.dataFim,
      equipamentoId: equipamentoId ?? this.equipamentoId,
      tipoAtividadeId: tipoAtividadeId ?? this.tipoAtividadeId,
      equipamentoNome: equipamentoNome ?? this.equipamentoNome,
      tipoAtividadeNome: tipoAtividadeNome ?? this.tipoAtividadeNome,
      checklist: checklist ?? this.checklist,
      apr: apr ?? this.apr,
      anomalias: anomalias ?? this.anomalias,
      mpdj: mpdj ?? this.mpdj,
      mpbb: mpbb ?? this.mpbb,
    );
  }
}
