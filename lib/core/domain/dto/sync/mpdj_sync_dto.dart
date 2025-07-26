import 'package:sympla_app/core/domain/dto/mpdj/medicao_pressao_sf6_table_dto.dart';
import 'package:sympla_app/core/domain/dto/mpdj/medicao_resistencia_contato_table_dto.dart';
import 'package:sympla_app/core/domain/dto/mpdj/medicao_resistencia_isolamento_table_dto.dart';
import 'package:sympla_app/core/domain/dto/mpdj/medicao_tempo_operacao_table_dto.dart';
import 'package:sympla_app/core/domain/dto/mpdj/prev_disj_form_table_dto.dart';

/// DTO para sincronização do MPDJ de uma atividade
class MpDjSyncDto {
  final int? id;
  final String atividadeId;
  final String? caracterizacaoEnsaio;
  final String? disjuntorFabricante;
  final String? disjuntorAnoFabricacao;
  final double? disjuntorTensaoNominal;
  final int? disjuntorCorrenteNominal;
  final int? disjuntorCapInterrupcaoNominal;
  final String? disjuntorTipoExtinsao;
  final String? disjuntorTipoAcionamento;
  final double? disjuntorPressaoSf6Nominal;
  final double? disjuntorPressaoSf6NominalTemperatura;
  final double? dadoPlacaFechamento;
  final double? dadoPlacaAbertura;
  final DateTime dataEnsaio;

  // Medições
  final List<MpDjResistenciaContatoSyncDto> medicoesResistenciaContato;
  final List<MpDjResistenciaIsolamentoSyncDto> medicoesResistenciaIsolamento;
  final List<MpDjPressaoSf6SyncDto> medicoesPressaoSf6;
  final List<MpDjTempoOperacaoSyncDto> medicoesTempoOperacao;

  MpDjSyncDto({
    this.id,
    required this.atividadeId,
    this.caracterizacaoEnsaio,
    this.disjuntorFabricante,
    this.disjuntorAnoFabricacao,
    this.disjuntorTensaoNominal,
    this.disjuntorCorrenteNominal,
    this.disjuntorCapInterrupcaoNominal,
    this.disjuntorTipoExtinsao,
    this.disjuntorTipoAcionamento,
    this.disjuntorPressaoSf6Nominal,
    this.disjuntorPressaoSf6NominalTemperatura,
    this.dadoPlacaFechamento,
    this.dadoPlacaAbertura,
    required this.dataEnsaio,
    this.medicoesResistenciaContato = const [],
    this.medicoesResistenciaIsolamento = const [],
    this.medicoesPressaoSf6 = const [],
    this.medicoesTempoOperacao = const [],
  });

  /// Converte de MpdjFormTableDto para MpDjSyncDto
  factory MpDjSyncDto.fromMpdjFormDto(
    MpdjFormTableDto formulario,
    List<MedicaoResistenciaContatoTableDto> medicoesContato,
    List<MedicaoResistenciaIsolamentoTableDto> medicoesIsolamento,
    List<MedicaoPressaoSf6TableDto> medicoesPressao,
    List<MedicaoTempoOperacaoTableDto> medicoesTempo,
  ) {
    return MpDjSyncDto(
      id: formulario.id,
      atividadeId: formulario.atividadeId,
      caracterizacaoEnsaio: formulario.caracterizacaoEnsaio,
      disjuntorFabricante: formulario.disjuntorFabricante,
      disjuntorAnoFabricacao: formulario.disjuntorAnoFabricacao,
      disjuntorTensaoNominal: formulario.disjuntorTensaoNominal,
      disjuntorCorrenteNominal: formulario.disjuntorCorrenteNominal,
      disjuntorCapInterrupcaoNominal: formulario.disjuntorCapInterrupcaoNominal,
      disjuntorTipoExtinsao: formulario.disjuntorTipoExtinsao,
      disjuntorTipoAcionamento: formulario.disjuntorTipoAcionamento,
      disjuntorPressaoSf6Nominal: formulario.disjuntorPressaoSf6Nominal,
      disjuntorPressaoSf6NominalTemperatura: formulario.disjuntorPressaoSf6NominalTemperatura,
      dadoPlacaFechamento: formulario.dadoPlacaFechamento,
      dadoPlacaAbertura: formulario.dadoPlacaAbertura,
      dataEnsaio: formulario.dataEnsaio,
      medicoesResistenciaContato: medicoesContato.map(MpDjResistenciaContatoSyncDto.fromMedicaoDto).toList(),
      medicoesResistenciaIsolamento: medicoesIsolamento.map(MpDjResistenciaIsolamentoSyncDto.fromMedicaoDto).toList(),
      medicoesPressaoSf6: medicoesPressao.map(MpDjPressaoSf6SyncDto.fromMedicaoDto).toList(),
      medicoesTempoOperacao: medicoesTempo.map(MpDjTempoOperacaoSyncDto.fromMedicaoDto).toList(),
    );
  }

  /// Converte para JSON para envio ao backend
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'atividadeId': atividadeId,
      'caracterizacaoEnsaio': caracterizacaoEnsaio,
      'disjuntorFabricante': disjuntorFabricante,
      'disjuntorAnoFabricacao': disjuntorAnoFabricacao,
      'disjuntorTensaoNominal': disjuntorTensaoNominal,
      'disjuntorCorrenteNominal': disjuntorCorrenteNominal,
      'disjuntorCapInterrupcaoNominal': disjuntorCapInterrupcaoNominal,
      'disjuntorTipoExtinsao': disjuntorTipoExtinsao,
      'disjuntorTipoAcionamento': disjuntorTipoAcionamento,
      'disjuntorPressaoSf6Nominal': disjuntorPressaoSf6Nominal,
      'disjuntorPressaoSf6NominalTemperatura': disjuntorPressaoSf6NominalTemperatura,
      'dadoPlacaFechamento': dadoPlacaFechamento,
      'dadoPlacaAbertura': dadoPlacaAbertura,
      'dataEnsaio': dataEnsaio.toIso8601String(),
      'medicoesResistenciaContato': medicoesResistenciaContato.map((m) => m.toJson()).toList(),
      'medicoesResistenciaIsolamento': medicoesResistenciaIsolamento.map((m) => m.toJson()).toList(),
      'medicoesPressaoSf6': medicoesPressaoSf6.map((m) => m.toJson()).toList(),
      'medicoesTempoOperacao': medicoesTempoOperacao.map((m) => m.toJson()).toList(),
    };
  }
}

/// DTO para sincronização de medição de resistência de contato
class MpDjResistenciaContatoSyncDto {
  final int? id;
  final int formularioDisjuntorId;
  final int numeroCamara;
  final double? resistenciaFaseA;
  final double? resistenciaFaseB;
  final double? resistenciaFaseC;
  final double? temperaturaDisjuntor;
  final double? umidadeRelativaAr;

  MpDjResistenciaContatoSyncDto({
    this.id,
    required this.formularioDisjuntorId,
    required this.numeroCamara,
    this.resistenciaFaseA,
    this.resistenciaFaseB,
    this.resistenciaFaseC,
    this.temperaturaDisjuntor,
    this.umidadeRelativaAr,
  });

  factory MpDjResistenciaContatoSyncDto.fromMedicaoDto(MedicaoResistenciaContatoTableDto medicao) {
    return MpDjResistenciaContatoSyncDto(
      id: medicao.id,
      formularioDisjuntorId: medicao.formularioDisjuntorId,
      numeroCamara: medicao.numeroCamara,
      resistenciaFaseA: medicao.resistenciaFaseA,
      resistenciaFaseB: medicao.resistenciaFaseB,
      resistenciaFaseC: medicao.resistenciaFaseC,
      temperaturaDisjuntor: medicao.temperaturaDisjuntor,
      umidadeRelativaAr: medicao.umidadeRelativaAr,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'formularioDisjuntorId': formularioDisjuntorId,
      'numeroCamara': numeroCamara,
      'resistenciaFaseA': resistenciaFaseA,
      'resistenciaFaseB': resistenciaFaseB,
      'resistenciaFaseC': resistenciaFaseC,
      'temperaturaDisjuntor': temperaturaDisjuntor,
      'umidadeRelativaAr': umidadeRelativaAr,
    };
  }
}

/// DTO para sincronização de medição de resistência de isolamento
class MpDjResistenciaIsolamentoSyncDto {
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

  MpDjResistenciaIsolamentoSyncDto({
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

  factory MpDjResistenciaIsolamentoSyncDto.fromMedicaoDto(MedicaoResistenciaIsolamentoTableDto medicao) {
    return MpDjResistenciaIsolamentoSyncDto(
      id: medicao.id,
      formularioDisjuntorId: medicao.formularioDisjuntorId,
      linha: medicao.linha,
      terra: medicao.terra,
      guarda: medicao.guarda,
      tensaoKv: medicao.tensaoKv,
      resistenciaFaseA: medicao.resistenciaFaseA,
      resistenciaFaseB: medicao.resistenciaFaseB,
      resistenciaFaseC: medicao.resistenciaFaseC,
      temperaturaDisjuntor: medicao.temperaturaDisjuntor,
      umidadeRelativaAr: medicao.umidadeRelativaAr,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'formularioDisjuntorId': formularioDisjuntorId,
      'linha': linha,
      'terra': terra,
      'guarda': guarda,
      'tensaoKv': tensaoKv,
      'resistenciaFaseA': resistenciaFaseA,
      'resistenciaFaseB': resistenciaFaseB,
      'resistenciaFaseC': resistenciaFaseC,
      'temperaturaDisjuntor': temperaturaDisjuntor,
      'umidadeRelativaAr': umidadeRelativaAr,
    };
  }
}

/// DTO para sincronização de medição de pressão SF6
class MpDjPressaoSf6SyncDto {
  final int? id;
  final int formularioDisjuntorId;
  final String fase;
  final double valorPressao;
  final double temperatura;

  MpDjPressaoSf6SyncDto({
    this.id,
    required this.formularioDisjuntorId,
    required this.fase,
    required this.valorPressao,
    required this.temperatura,
  });

  factory MpDjPressaoSf6SyncDto.fromMedicaoDto(MedicaoPressaoSf6TableDto medicao) {
    return MpDjPressaoSf6SyncDto(
      id: medicao.id,
      formularioDisjuntorId: medicao.formularioDisjuntorId,
      fase: medicao.fase,
      valorPressao: medicao.valorPressao,
      temperatura: medicao.temperatura,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'formularioDisjuntorId': formularioDisjuntorId,
      'fase': fase,
      'valorPressao': valorPressao,
      'temperatura': temperatura,
    };
  }
}

/// DTO para sincronização de medição de tempo de operação
class MpDjTempoOperacaoSyncDto {
  final int? id;
  final int formularioDisjuntorId;
  final String fase;
  final double? fechamentoBobina1;
  final double? fechamentoBobina2;
  final double? aberturaBobina1;
  final double? aberturaBobina2;

  MpDjTempoOperacaoSyncDto({
    this.id,
    required this.formularioDisjuntorId,
    required this.fase,
    this.fechamentoBobina1,
    this.fechamentoBobina2,
    this.aberturaBobina1,
    this.aberturaBobina2,
  });

  factory MpDjTempoOperacaoSyncDto.fromMedicaoDto(MedicaoTempoOperacaoTableDto medicao) {
    return MpDjTempoOperacaoSyncDto(
      id: medicao.id,
      formularioDisjuntorId: medicao.formularioDisjuntorId,
      fase: medicao.fase,
      fechamentoBobina1: medicao.fechamentoBobina1,
      fechamentoBobina2: medicao.fechamentoBobina2,
      aberturaBobina1: medicao.aberturaBobina1,
      aberturaBobina2: medicao.aberturaBobina2,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'formularioDisjuntorId': formularioDisjuntorId,
      'fase': fase,
      'fechamentoBobina1': fechamentoBobina1,
      'fechamentoBobina2': fechamentoBobina2,
      'aberturaBobina1': aberturaBobina1,
      'aberturaBobina2': aberturaBobina2,
    };
  }
}
