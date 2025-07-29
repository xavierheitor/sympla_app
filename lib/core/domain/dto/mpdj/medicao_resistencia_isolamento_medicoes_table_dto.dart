import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/converters/estado_disjuntor_converter.dart';
import 'package:sympla_app/core/storage/converters/fase_isolamento_converter.dart';
import 'package:sympla_app/core/storage/converters/posicao_disjuntor_ensaio_converter.dart';

/// 📊 DTO para medições específicas de resistência de isolamento
///
/// 🔧 ESTRUTURA:
/// - Configurações variáveis (mudam a cada medição)
/// - Posições do disjuntor, fase, estado
/// - 11 medições de resistência (30s até 10min)
/// - Timestamp da medição
class MedicaoResistenciaIsolamentoMedicoesTableDto {
  final int? id;
  final int mpDjResistenciaIsolamentoId;
  final DateTime dataMedicao;

  /// 🔌 Configurações de posição do disjuntor
  final PosicaoDisjuntorEnsaio linha;
  final PosicaoDisjuntorEnsaio terra;
  final PosicaoDisjuntorEnsaio guarda;

  /// ⚡ Fase selecionada para medição
  final FaseIsolamento fase;

  /// 🔌 Estado do disjuntor durante o ensaio
  final EstadoDisjuntor estadoDisjuntor;

  /// 📊 Medições de resistência (11 campos: 30s, 1min, 2min... até 10min)
  final double? resistencia30s;
  final double? resistencia1min;
  final double? resistencia2min;
  final double? resistencia3min;
  final double? resistencia4min;
  final double? resistencia5min;
  final double? resistencia6min;
  final double? resistencia7min;
  final double? resistencia8min;
  final double? resistencia9min;
  final double? resistencia10min;

  MedicaoResistenciaIsolamentoMedicoesTableDto({
    this.id,
    required this.mpDjResistenciaIsolamentoId,
    required this.dataMedicao,
    required this.linha,
    required this.terra,
    required this.guarda,
    required this.fase,
    required this.estadoDisjuntor,
    this.resistencia30s,
    this.resistencia1min,
    this.resistencia2min,
    this.resistencia3min,
    this.resistencia4min,
    this.resistencia5min,
    this.resistencia6min,
    this.resistencia7min,
    this.resistencia8min,
    this.resistencia9min,
    this.resistencia10min,
  });

  factory MedicaoResistenciaIsolamentoMedicoesTableDto.fromData(
      MpDjResistenciaIsolamentoMedicoesTableData data) {
    return MedicaoResistenciaIsolamentoMedicoesTableDto(
      id: data.id,
      mpDjResistenciaIsolamentoId: data.mpDjResistenciaIsolamentoId,
      dataMedicao: data.dataMedicao,
      linha: data.linha,
      terra: data.terra,
      guarda: data.guarda,
      fase: data.fase,
      estadoDisjuntor: data.estadoDisjuntor,
      resistencia30s: data.resistencia30s,
      resistencia1min: data.resistencia1min,
      resistencia2min: data.resistencia2min,
      resistencia3min: data.resistencia3min,
      resistencia4min: data.resistencia4min,
      resistencia5min: data.resistencia5min,
      resistencia6min: data.resistencia6min,
      resistencia7min: data.resistencia7min,
      resistencia8min: data.resistencia8min,
      resistencia9min: data.resistencia9min,
      resistencia10min: data.resistencia10min,
    );
  }

  MpDjResistenciaIsolamentoMedicoesTableCompanion toCompanion() {
    return MpDjResistenciaIsolamentoMedicoesTableCompanion(
      id: id != null ? Value(id!) : const Value.absent(),
      mpDjResistenciaIsolamentoId: Value(mpDjResistenciaIsolamentoId),
      dataMedicao: Value(dataMedicao),
      linha: Value(linha),
      terra: Value(terra),
      guarda: Value(guarda),
      fase: Value(fase),
      estadoDisjuntor: Value(estadoDisjuntor),
      resistencia30s: Value(resistencia30s),
      resistencia1min: Value(resistencia1min),
      resistencia2min: Value(resistencia2min),
      resistencia3min: Value(resistencia3min),
      resistencia4min: Value(resistencia4min),
      resistencia5min: Value(resistencia5min),
      resistencia6min: Value(resistencia6min),
      resistencia7min: Value(resistencia7min),
      resistencia8min: Value(resistencia8min),
      resistencia9min: Value(resistencia9min),
      resistencia10min: Value(resistencia10min),
    );
  }
} 