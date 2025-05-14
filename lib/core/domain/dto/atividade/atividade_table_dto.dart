import 'package:drift/drift.dart';
import 'package:sympla_app/core/domain/dto/atividade/tipo_atividade_table_dto.dart';
import 'package:sympla_app/core/domain/dto/grupo_defeito_equipamento/equipamento_table_dto.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/converters/status_atividade_converter.dart';

class AtividadeTableDto {
  final String uuid;
  final String titulo;
  final String ordemServico;
  final String descricao;
  final String subestacao;
  final StatusAtividade status;

  final DateTime dataLimite;
  final DateTime? dataInicio;
  final DateTime? dataFim;

  final String equipamentoId;
  final String tipoAtividadeId;

  final EquipamentoTableDto? equipamento;
  final TipoAtividadeTableDto? tipoAtividade;

  AtividadeTableDto({
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
    this.equipamento,
    this.tipoAtividade,
  });

  // 🔄 De JSON para DTO
  factory AtividadeTableDto.fromJson(Map<String, dynamic> json) {
    return AtividadeTableDto(
      uuid: json['uuid'],
      titulo: json['titulo'],
      ordemServico: json['ordemServico'],
      descricao: json['descricao'],
      subestacao: json['subestacao'],
      status: StatusAtividade.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => StatusAtividade.pendente,
      ),
      dataLimite: DateTime.parse(json['dataLimite']),
      dataInicio: json['dataInicio'] != null
          ? DateTime.parse(json['dataInicio'])
          : null,
      dataFim: json['dataFim'] != null ? DateTime.parse(json['dataFim']) : null,
      equipamentoId: json['equipamentoId'],
      tipoAtividadeId: json['tipoAtividadeId'],
    );
  }

  // 🔄 De DTO para JSON
  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'titulo': titulo,
      'ordemServico': ordemServico,
      'descricao': descricao,
      'subestacao': subestacao,
      'status': status.name,
      'dataLimite': dataLimite.toIso8601String(),
      'dataInicio': dataInicio?.toIso8601String(),
      'dataFim': dataFim?.toIso8601String(),
      'equipamentoId': equipamentoId,
      'tipoAtividadeId': tipoAtividadeId,
    };
  }

  // 🔄 De DTO para Companion
  AtividadeTableCompanion toCompanion() {
    return AtividadeTableCompanion(
      uuid: Value(uuid),
      titulo: Value(titulo),
      ordemServico: Value(ordemServico),
      descricao: Value(descricao),
      subestacao: Value(subestacao),
      status: Value(status),
      dataLimite: Value(dataLimite),
      dataInicio: Value(dataInicio),
      dataFim: Value(dataFim),
      equipamentoId: Value(equipamentoId),
      tipoAtividadeId: Value(tipoAtividadeId),
      createdAt: Value(DateTime.now()),
      updatedAt: Value(DateTime.now()),
      sincronizado: const Value(true),
    );
  }

  // 🔄 De TableData para DTO
  factory AtividadeTableDto.fromData(AtividadeTableData data) {
    return AtividadeTableDto(
      uuid: data.uuid,
      titulo: data.titulo,
      ordemServico: data.ordemServico,
      descricao: data.descricao,
      subestacao: data.subestacao,
      status: StatusAtividade.values.firstWhere(
        (e) => e.name == data.status,
        orElse: () => StatusAtividade.pendente,
      ),
      dataLimite: data.dataLimite,
      dataInicio: data.dataInicio,
      dataFim: data.dataFim,
      equipamentoId: data.equipamentoId,
      tipoAtividadeId: data.tipoAtividadeId,
    );
  }

  // 🔄 De TableData para DTO com join
  factory AtividadeTableDto.fromJoin(AtividadeTableData atividade,
      EquipamentoTableData equipamento, TipoAtividadeTableData tipoAtividade) {
    return AtividadeTableDto(
      uuid: atividade.uuid,
      titulo: atividade.titulo,
      descricao: atividade.descricao,
      ordemServico: atividade.ordemServico,
      subestacao: atividade.subestacao,
      status: atividade.status,
      dataLimite: atividade.dataLimite,
      dataInicio: atividade.dataInicio,
      dataFim: atividade.dataFim,
      equipamentoId: equipamento.uuid,
      tipoAtividadeId: tipoAtividade.uuid,
      equipamento: EquipamentoTableDto.fromData(equipamento),
      tipoAtividade: TipoAtividadeTableDto.fromData(tipoAtividade),
    );
  }
}
