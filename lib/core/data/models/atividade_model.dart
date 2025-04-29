import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/converters/status_atividade_converter.dart';

class AtividadeModel {
  final int id;
  final String uuid;
  final String titulo;
  final String descricao;
  final String subestacao;
  final String ordemServico;
  final StatusAtividade status;
  final DateTime? dataInicio;
  final DateTime? dataFim;
  final DateTime dataLimite;
  final int tipoAtividadeId;
  final int? equipamentoId;
  final String? nomeEquipamento; // <- Nome do equipamento junto!

  AtividadeModel({
    required this.id,
    required this.uuid,
    required this.titulo,
    required this.descricao,
    required this.subestacao,
    required this.ordemServico,
    required this.status,
    this.dataInicio,
    this.dataFim,
    required this.dataLimite,
    required this.tipoAtividadeId,
    this.equipamentoId,
    this.nomeEquipamento,
  });

  // Facilita criar a partir do JOIN
  factory AtividadeModel.fromJoin({
    required AtividadeTableData atividade,
    EquipamentoTableData? equipamento,
  }) {
    return AtividadeModel(
      id: atividade.id,
      uuid: atividade.uuid,
      titulo: atividade.titulo,
      descricao: atividade.descricao,
      subestacao: atividade.subestacao,
      ordemServico: atividade.ordemServico,
      status: atividade.status,
      dataInicio: atividade.dataInicio,
      dataFim: atividade.dataFim,
      dataLimite: atividade.dataLimite,
      tipoAtividadeId: atividade.tipoAtividadeId,
      equipamentoId: equipamento?.id,
      nomeEquipamento: equipamento?.nome,
    );
  }
}
