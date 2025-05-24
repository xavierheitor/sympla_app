import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/converters/fase_converter.dart';

class MedicaoTempoOperacaoTableDto {
  final int? id;
  final int formularioDisjuntorId;
  final String fase;
  final double? fechamentoBobina1;
  final double? fechamentoBobina2;
  final double? aberturaBobina1;
  final double? aberturaBobina2;

  MedicaoTempoOperacaoTableDto({
    this.id,
    required this.formularioDisjuntorId,
    required this.fase,
    this.fechamentoBobina1,
    this.fechamentoBobina2,
    this.aberturaBobina1,
    this.aberturaBobina2,
  });

  factory MedicaoTempoOperacaoTableDto.fromData(
      MpDjTempoOperacaoTableData data) {
    return MedicaoTempoOperacaoTableDto(
      id: data.id,
      formularioDisjuntorId: data.mpDjFormId,
      fase: data.fase.name,
      fechamentoBobina1: data.fechamentoBobina1,
      fechamentoBobina2: data.fechamentoBobina2,
      aberturaBobina1: data.aberturaBobina1,
      aberturaBobina2: data.aberturaBobina2,
    );
  }

  MpDjTempoOperacaoTableCompanion toCompanion() {
    return MpDjTempoOperacaoTableCompanion(
      id: id != null ? Value(id!) : const Value.absent(),
      mpDjFormId: Value(formularioDisjuntorId),
      fase: Value(FaseAnomalia.values.byName(fase)),
      fechamentoBobina1: Value(fechamentoBobina1),
      fechamentoBobina2: Value(fechamentoBobina2),
      aberturaBobina1: Value(aberturaBobina1),
      aberturaBobina2: Value(aberturaBobina2),
    );
  }
}
