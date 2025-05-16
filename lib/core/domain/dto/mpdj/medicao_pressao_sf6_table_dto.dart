class MedicaoPressaoSf6TableDto {
  final int id;
  final int formularioDisjuntorId;
  final String fase;

  final double valorPressao;
  final double temperatura;

  MedicaoPressaoSf6TableDto({
    required this.id,
    required this.formularioDisjuntorId,
    required this.fase,
    required this.valorPressao,
    required this.temperatura,
  });
}
