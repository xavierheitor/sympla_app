import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/converters/posicao_disjuntor_ensaio_converter.dart';

class MedicaoResistenciaIsolamentoTableDto {
  final int? id;
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
    this.id,
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

  factory MedicaoResistenciaIsolamentoTableDto.fromData(
      MpDjResistenciaIsolamentoTableData data) {
    return MedicaoResistenciaIsolamentoTableDto(
      id: data.id,
      formularioDisjuntorId: data.mpDjFormId,
      linha: data.linha.name,
      terra: data.terra.name,
      guarda: data.guarda.name,
      tensaoKv: data.tensaoKv,
      resistenciaFaseA: data.resistenciaFaseA,
      resistenciaFaseB: data.resistenciaFaseB,
      resistenciaFaseC: data.resistenciaFaseC,
      temperaturaDisjuntor: data.temperaturaDisjuntor,
      umidadeRelativaAr: data.umidadeRelativaAr,
    );
  }

  MpDjResistenciaIsolamentoTableCompanion toCompanion() {
    return MpDjResistenciaIsolamentoTableCompanion(
      id: id != null ? Value(id!) : const Value.absent(),
      mpDjFormId: Value(formularioDisjuntorId),
      linha: Value(PosicaoDisjuntorEnsaio.values.byName(linha)),
      terra: Value(PosicaoDisjuntorEnsaio.values.byName(terra)),
      guarda: Value(PosicaoDisjuntorEnsaio.values.byName(guarda)),
      tensaoKv: Value(tensaoKv),
      resistenciaFaseA: Value(resistenciaFaseA),
      resistenciaFaseB: Value(resistenciaFaseB),
      resistenciaFaseC: Value(resistenciaFaseC),
      temperaturaDisjuntor: Value(temperaturaDisjuntor),
      umidadeRelativaAr: Value(umidadeRelativaAr),
    );
  }
}
