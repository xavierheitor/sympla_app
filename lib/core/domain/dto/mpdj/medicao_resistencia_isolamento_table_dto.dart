class MedicaoResistenciaIsolamentoTableDto {
  final int id;
  final int formularioDisjuntorId;

  final String linha;
  final String terra;
  final String guarda;

  final double tensaoKv;
  final double? resistenciaFaseA;
  final double? resistenciaFaseB;
  final double? resistenciaFaseC;

  final double? temperaturaDisjuntor;
  final double? umidadeRelativaAr;

  MedicaoResistenciaIsolamentoTableDto({
    required this.id,
    required this.formularioDisjuntorId,
    required this.linha,
    required this.terra,
    required this.guarda,
    required this.tensaoKv,
    this.resistenciaFaseA,
    this.resistenciaFaseB,
    this.resistenciaFaseC,
    this.temperaturaDisjuntor,
    this.umidadeRelativaAr,
  });
}
