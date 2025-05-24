import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/app_database.dart';

class MedicaoResistenciaContatoTableDto {
  final int? id;
  final int formularioDisjuntorId;
  final int numeroCamara;
  final double? resistenciaFaseA;
  final double? resistenciaFaseB;
  final double? resistenciaFaseC;
  final double? temperaturaDisjuntor;
  final double? umidadeRelativaAr;

  MedicaoResistenciaContatoTableDto({
    this.id,
    required this.formularioDisjuntorId,
    required this.numeroCamara,
    this.resistenciaFaseA,
    this.resistenciaFaseB,
    this.resistenciaFaseC,
    this.temperaturaDisjuntor,
    this.umidadeRelativaAr,
  });

  factory MedicaoResistenciaContatoTableDto.fromData(
      MpDjResistenciaContatoTableData data) {
    return MedicaoResistenciaContatoTableDto(
      id: data.id,
      formularioDisjuntorId: data.mpDjFormId,
      numeroCamara: data.numeroCamara,
      resistenciaFaseA: data.resistenciaFaseA,
      resistenciaFaseB: data.resistenciaFaseB,
      resistenciaFaseC: data.resistenciaFaseC,
      temperaturaDisjuntor: data.temperaturaDisjuntor,
      umidadeRelativaAr: data.umidadeRelativaAr,
    );
  }

  MpDjResistenciaContatoTableCompanion toCompanion() {
    return MpDjResistenciaContatoTableCompanion(
      id: id != null ? Value(id!) : const Value.absent(),
      mpDjFormId: Value(formularioDisjuntorId),
      numeroCamara: Value(numeroCamara),
      resistenciaFaseA: Value(resistenciaFaseA),
      resistenciaFaseB: Value(resistenciaFaseB),
      resistenciaFaseC: Value(resistenciaFaseC),
      temperaturaDisjuntor: Value(temperaturaDisjuntor),
      umidadeRelativaAr: Value(umidadeRelativaAr),
    );
  }
}
