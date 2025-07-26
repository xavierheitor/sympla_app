import 'package:sympla_app/core/domain/dto/mpbb/formulario_bateria_table_dto.dart';
import 'package:sympla_app/core/domain/dto/mpbb/medicao_elemento_table_dto.dart';

/// DTO para sincronização do MPBB de uma atividade
class MpBbSyncDto {
  final int? id;
  final String atividadeId;
  final String? fabricante;
  final double? resistenciaNominal;
  final double? densidadeNominal;
  final double? tensaoFlutuacaoCelula;
  final double? densidadeCritica;
  final String tipoBateria;
  final String? modelo;
  final int? capacidadeAh;
  final int? quantidadeCelulas;
  final double? tensaoFlutuacaoBanco;
  final double? rippleMedido;
  final DateTime createdAt;
  final DateTime? updatedAt;

  // Medições de elementos
  final List<MpBbElementoSyncDto> medicoesElementos;

  MpBbSyncDto({
    this.id,
    required this.atividadeId,
    this.fabricante,
    this.resistenciaNominal,
    this.densidadeNominal,
    this.tensaoFlutuacaoCelula,
    this.densidadeCritica,
    required this.tipoBateria,
    this.modelo,
    this.capacidadeAh,
    this.quantidadeCelulas,
    this.tensaoFlutuacaoBanco,
    this.rippleMedido,
    required this.createdAt,
    this.updatedAt,
    this.medicoesElementos = const [],
  });

  /// Converte de FormularioBateriaTableDto para MpBbSyncDto
  factory MpBbSyncDto.fromFormularioBateriaDto(
    FormularioBateriaTableDto formulario,
    List<MedicaoElementoMpbbTableDto> medicoesElementos,
  ) {
    return MpBbSyncDto(
      id: formulario.id,
      atividadeId: formulario.atividadeId,
      fabricante: formulario.fabricante,
      resistenciaNominal: formulario.resistenciaNominal,
      densidadeNominal: formulario.densidadeNominal,
      tensaoFlutuacaoCelula: formulario.tensaoFlutuacaoCelula,
      densidadeCritica: formulario.densidadeCritica,
      tipoBateria: formulario.tipoBateria,
      modelo: formulario.modelo,
      capacidadeAh: formulario.capacidadeAh,
      quantidadeCelulas: formulario.quantidadeCelulas,
      tensaoFlutuacaoBanco: formulario.tensaoFlutuacaoBanco,
      rippleMedido: formulario.rippleMedido,
      createdAt: formulario.createdAt,
      updatedAt: formulario.updatedAt,
      medicoesElementos: medicoesElementos.map(MpBbElementoSyncDto.fromMedicaoDto).toList(),
    );
  }

  /// Converte para JSON para envio ao backend
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'atividadeId': atividadeId,
      'fabricante': fabricante,
      'resistenciaNominal': resistenciaNominal,
      'densidadeNominal': densidadeNominal,
      'tensaoFlutuacaoCelula': tensaoFlutuacaoCelula,
      'densidadeCritica': densidadeCritica,
      'tipoBateria': tipoBateria,
      'modelo': modelo,
      'capacidadeAh': capacidadeAh,
      'quantidadeCelulas': quantidadeCelulas,
      'tensaoFlutuacaoBanco': tensaoFlutuacaoBanco,
      'rippleMedido': rippleMedido,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'medicoesElementos': medicoesElementos.map((m) => m.toJson()).toList(),
    };
  }
}

/// DTO para sincronização de medição de elemento da bateria
class MpBbElementoSyncDto {
  final int? id;
  final int? formularioBateriaId;
  final int elementoBateriaNumero;
  final double? tensao;
  final double? resistenciaInterna;

  MpBbElementoSyncDto({
    this.id,
    this.formularioBateriaId,
    required this.elementoBateriaNumero,
    this.tensao,
    this.resistenciaInterna,
  });

  factory MpBbElementoSyncDto.fromMedicaoDto(MedicaoElementoMpbbTableDto medicao) {
    return MpBbElementoSyncDto(
      id: medicao.id,
      formularioBateriaId: medicao.formularioBateriaId,
      elementoBateriaNumero: medicao.elementoBateriaNumero,
      tensao: medicao.tensao,
      resistenciaInterna: medicao.resistenciaInterna,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'formularioBateriaId': formularioBateriaId,
      'elementoBateriaNumero': elementoBateriaNumero,
      'tensao': tensao,
      'resistenciaInterna': resistenciaInterna,
    };
  }
}
