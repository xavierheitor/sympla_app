class MedicaoTempoOperacaoTableDto {
  final int id;
  final int formularioDisjuntorId;
  final String fase;

  final double? fechamentoBobina1;
  final double? fechamentoBobina2;

  final double? aberturaBobina1;
  final double? aberturaBobina2;

  MedicaoTempoOperacaoTableDto({
    required this.id,
    required this.formularioDisjuntorId,
    required this.fase,
    this.fechamentoBobina1,
    this.fechamentoBobina2,
    this.aberturaBobina1,
    this.aberturaBobina2,
  });
}
