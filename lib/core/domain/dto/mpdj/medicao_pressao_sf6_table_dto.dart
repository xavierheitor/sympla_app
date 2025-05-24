import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/converters/fase_converter.dart';

class MedicaoPressaoSf6TableDto {
  final int? id;
  final int formularioDisjuntorId;
  final String fase;
  final double valorPressao;
  final double temperatura;

  MedicaoPressaoSf6TableDto({
    this.id,
    required this.formularioDisjuntorId,
    required this.fase,
    required this.valorPressao,
    required this.temperatura,
  });

  factory MedicaoPressaoSf6TableDto.fromData(MpDjPressaoSf6TableData data) {
    return MedicaoPressaoSf6TableDto(
      id: data.id,
      formularioDisjuntorId: data.mpDjFormId,
      fase: data.fase.name,
      valorPressao: data.valorPressao,
      temperatura: data.temperatura,
    );
  }

  MpDjPressaoSf6TableCompanion toCompanion() {
    return MpDjPressaoSf6TableCompanion(
      id: id != null ? Value(id!) : const Value.absent(),
      mpDjFormId: Value(formularioDisjuntorId),
      fase: Value(FaseAnomalia.values.byName(fase)),
      valorPressao: Value(valorPressao),
      temperatura: Value(temperatura),
    );
  }
}
