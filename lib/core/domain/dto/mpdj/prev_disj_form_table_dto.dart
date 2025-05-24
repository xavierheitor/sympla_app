import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/converters/caracterizacao_ensaio_converter.dart';
import 'package:sympla_app/core/storage/converters/tipo_extinsao_disjutnor_converter.dart';

class MpdjFormTableDto {
  final int? id;
  final String atividadeId;
  final String? caracterizacaoEnsaio;

  final String? disjuntorFabricante;
  final String? disjuntorAnoFabricacao;
  final double? disjuntorTensaoNominal;
  final int? disjuntorCorrenteNominal;
  final int? disjuntorCapInterrupcaoNominal;
  final String? disjuntorTipoExtinsao;
  final String? disjuntorTipoAcionamento;
  final double? disjuntorPressaoSf6Nominal;
  final double? disjuntorPressaoSf6NominalTemperatura;

  final double? dadoPlacaFechamento;
  final double? dadoPlacaAbertura;

  final DateTime dataEnsaio;

  MpdjFormTableDto({
    this.id,
    required this.atividadeId,
    this.caracterizacaoEnsaio,
    this.disjuntorFabricante,
    this.disjuntorAnoFabricacao,
    this.disjuntorTensaoNominal,
    this.disjuntorCorrenteNominal,
    this.disjuntorCapInterrupcaoNominal,
    this.disjuntorTipoExtinsao,
    this.disjuntorTipoAcionamento,
    this.disjuntorPressaoSf6Nominal,
    this.disjuntorPressaoSf6NominalTemperatura,
    this.dadoPlacaFechamento,
    this.dadoPlacaAbertura,
    required this.dataEnsaio,
  });

  factory MpdjFormTableDto.fromData(MpDjFormTableData data) {
    return MpdjFormTableDto(
      id: data.id,
      atividadeId: data.atividadeId,
      caracterizacaoEnsaio: data.caracterizacaoEnsaio?.name,
      disjuntorFabricante: data.disjuntorFabricante,
      disjuntorAnoFabricacao: data.disjuntorAnoFabricacao,
      disjuntorTensaoNominal: data.disjuntorTensaoNominal,
      disjuntorCorrenteNominal: data.disjuntorCorrenteNominal,
      disjuntorCapInterrupcaoNominal: data.disjuntorCapInterrupcaoNominal,
      disjuntorTipoExtinsao: data.disjuntorTipoExtinsao?.name,
      disjuntorTipoAcionamento: data.disjuntorTipoAcionamento,
      disjuntorPressaoSf6Nominal: data.disjuntorPressaoSf6Nominal,
      disjuntorPressaoSf6NominalTemperatura:
          data.disjuntorPressaoSf6NominalTemperatura,
      dadoPlacaFechamento: data.dadoPlacaFechamento,
      dadoPlacaAbertura: data.dadoPlacaAbertura,
      dataEnsaio: data.dataEnsaio,
    );
  }

  MpDjFormTableCompanion toCompanion() {
    return MpDjFormTableCompanion(
      id: id != null ? Value(id!) : const Value.absent(),
      atividadeId: Value(atividadeId),
      caracterizacaoEnsaio: caracterizacaoEnsaio != null
          ? Value(CaracterizacaoEnsaio.values.byName(caracterizacaoEnsaio!))
          : const Value.absent(),
      disjuntorFabricante: Value(disjuntorFabricante),
      disjuntorAnoFabricacao: Value(disjuntorAnoFabricacao),
      disjuntorTensaoNominal: Value(disjuntorTensaoNominal),
      disjuntorCorrenteNominal: Value(disjuntorCorrenteNominal),
      disjuntorCapInterrupcaoNominal: Value(disjuntorCapInterrupcaoNominal),
      disjuntorTipoExtinsao: disjuntorTipoExtinsao != null
          ? Value(TipoExtinsaoDisjuntor.values.byName(disjuntorTipoExtinsao!))
          : const Value.absent(),
      disjuntorTipoAcionamento: Value(disjuntorTipoAcionamento),
      disjuntorPressaoSf6Nominal: Value(disjuntorPressaoSf6Nominal),
      disjuntorPressaoSf6NominalTemperatura:
          Value(disjuntorPressaoSf6NominalTemperatura),
      dadoPlacaFechamento: Value(dadoPlacaFechamento),
      dadoPlacaAbertura: Value(dadoPlacaAbertura),
      dataEnsaio: Value(dataEnsaio),
    );
  }

  MpdjFormTableDto copyWith({
    int? id,
    String? atividadeId,
    String? caracterizacaoEnsaio,
    String? disjuntorFabricante,
    String? disjuntorAnoFabricacao,
    double? disjuntorTensaoNominal,
    int? disjuntorCorrenteNominal,
    int? disjuntorCapInterrupcaoNominal,
    String? disjuntorTipoExtinsao,
    String? disjuntorTipoAcionamento,
    double? disjuntorPressaoSf6Nominal,
    double? disjuntorPressaoSf6NominalTemperatura,
    double? dadoPlacaFechamento,
    double? dadoPlacaAbertura,
    DateTime? dataEnsaio,
  }) {
    return MpdjFormTableDto(
      id: id ?? this.id,
      atividadeId: atividadeId ?? this.atividadeId,
      caracterizacaoEnsaio: caracterizacaoEnsaio ?? this.caracterizacaoEnsaio,
      disjuntorFabricante: disjuntorFabricante ?? this.disjuntorFabricante,
      disjuntorAnoFabricacao:
          disjuntorAnoFabricacao ?? this.disjuntorAnoFabricacao,
      disjuntorTensaoNominal:
          disjuntorTensaoNominal ?? this.disjuntorTensaoNominal,
      disjuntorCorrenteNominal:
          disjuntorCorrenteNominal ?? this.disjuntorCorrenteNominal,
      disjuntorCapInterrupcaoNominal:
          disjuntorCapInterrupcaoNominal ?? this.disjuntorCapInterrupcaoNominal,
      disjuntorTipoExtinsao:
          disjuntorTipoExtinsao ?? this.disjuntorTipoExtinsao,
      disjuntorTipoAcionamento:
          disjuntorTipoAcionamento ?? this.disjuntorTipoAcionamento,
      disjuntorPressaoSf6Nominal:
          disjuntorPressaoSf6Nominal ?? this.disjuntorPressaoSf6Nominal,
      disjuntorPressaoSf6NominalTemperatura:
          disjuntorPressaoSf6NominalTemperatura ??
              this.disjuntorPressaoSf6NominalTemperatura,
      dadoPlacaFechamento: dadoPlacaFechamento ?? this.dadoPlacaFechamento,
      dadoPlacaAbertura: dadoPlacaAbertura ?? this.dadoPlacaAbertura,
      dataEnsaio: dataEnsaio ?? this.dataEnsaio,
    );
  }
}
