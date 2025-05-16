class MedicaoResistenciaContatoTableDto {
  final int id;
  final int formularioDisjuntorId;
  final int numeroCamara;

  final double? resistenciaFaseA;
  final double? resistenciaFaseB;
  final double? resistenciaFaseC;

  final double? temperaturaDisjuntor;
  final double? umidadeRelativaAr;

  MedicaoResistenciaContatoTableDto({
    required this.id,
    required this.formularioDisjuntorId,
    required this.numeroCamara,
    this.resistenciaFaseA,
    this.resistenciaFaseB,
    this.resistenciaFaseC,
    this.temperaturaDisjuntor,
    this.umidadeRelativaAr,
  });
}
