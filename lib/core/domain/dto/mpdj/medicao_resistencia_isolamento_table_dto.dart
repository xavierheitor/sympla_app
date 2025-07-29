import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/app_database.dart';

/// 📊 DTO para configurações gerais de medições de resistência de isolamento
///
/// 🔧 ESTRUTURA ATUALIZADA:
/// - Configurações gerais do ensaio (fixas, não mudam por medição)
/// - Referência ao formulário MP DJ
/// - Tensão, temperatura e umidade do ambiente
class MedicaoResistenciaIsolamentoTableDto {
  final int? id;
  final int mpDjFormId;

  /// 🔧 Configurações gerais do ensaio (fixas, não mudam por medição)
  final double tensaoKv;
  final double? temperaturaDisjuntor;
  final double? umidadeRelativaAr;

  MedicaoResistenciaIsolamentoTableDto({
    this.id,
    required this.mpDjFormId,
    required this.tensaoKv,
    this.temperaturaDisjuntor,
    this.umidadeRelativaAr,
  });

  factory MedicaoResistenciaIsolamentoTableDto.fromData(MpDjResistenciaIsolamentoTableData data) {
    return MedicaoResistenciaIsolamentoTableDto(
      id: data.id,
      mpDjFormId: data.mpDjFormId,
      tensaoKv: data.tensaoKv,
      temperaturaDisjuntor: data.temperaturaDisjuntor,
      umidadeRelativaAr: data.umidadeRelativaAr,
    );
  }

  MpDjResistenciaIsolamentoTableCompanion toCompanion() {
    return MpDjResistenciaIsolamentoTableCompanion(
      id: id != null ? Value(id!) : const Value.absent(),
      mpDjFormId: Value(mpDjFormId),
      tensaoKv: Value(tensaoKv),
      temperaturaDisjuntor: Value(temperaturaDisjuntor),
      umidadeRelativaAr: Value(umidadeRelativaAr),
    );
  }
}
