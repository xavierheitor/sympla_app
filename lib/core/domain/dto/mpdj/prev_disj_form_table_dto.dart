class PrevDisjFormTableDto {
  final int id;
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

  PrevDisjFormTableDto({
    required this.id,
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
}
