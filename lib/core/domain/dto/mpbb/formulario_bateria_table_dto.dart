import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/converters/tipo_bateria_converter.dart';

class FormularioBateriaTableDto {
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

  FormularioBateriaTableDto({
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
  });

  factory FormularioBateriaTableDto.fromData(FormularioMpbbTableData data) {
    return FormularioBateriaTableDto(
      id: data.id,
      atividadeId: data.atividadeId,
      fabricante: data.fabricante,
      resistenciaNominal: data.resistenciaNominal,
      densidadeNominal: data.densidadeNominal,
      tensaoFlutuacaoCelula: data.tensaoFlutuacaoCelula,
      densidadeCritica: data.densidadeCritica,
      tipoBateria: data.tipoBateria.name,
      modelo: data.modelo,
      capacidadeAh: data.capacidadeAh,
      quantidadeCelulas: data.quantidadeCelulas,
      tensaoFlutuacaoBanco: data.tensaoFlutuacaoBanco,
      rippleMedido: data.rippleMedido,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
    );
  }

  FormularioMpbbTableCompanion toCompanion() {
    return FormularioMpbbTableCompanion(
      id: id != null
          ? Value(id!)
          : const Value.absent(), // 👈 Se não tem id, não passa
      atividadeId: Value(atividadeId),
      fabricante: Value(fabricante),
      resistenciaNominal: Value(resistenciaNominal),
      densidadeNominal: Value(densidadeNominal),
      tensaoFlutuacaoCelula: Value(tensaoFlutuacaoCelula),
      densidadeCritica: Value(densidadeCritica),
      tipoBateria: Value(TipoBateria.values.firstWhere(
        (e) => e.name == tipoBateria,
        orElse: () => TipoBateria.selada,
      )),
      modelo: Value(modelo),
      capacidadeAh: Value(capacidadeAh),
      quantidadeCelulas: Value(quantidadeCelulas),
      tensaoFlutuacaoBanco: Value(tensaoFlutuacaoBanco),
      rippleMedido: Value(rippleMedido),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory FormularioBateriaTableDto.fromJson(Map<String, dynamic> json) {
    return FormularioBateriaTableDto(
      id: json['id'],
      atividadeId: json['atividadeId'],
      fabricante: json['fabricante'],
      resistenciaNominal: json['resistenciaNominal'],
      densidadeNominal: json['densidadeNominal'],
      tensaoFlutuacaoCelula: json['tensaoFlutuacaoCelula'],
      densidadeCritica: json['densidadeCritica'],
      tipoBateria: json['tipoBateria'],
      modelo: json['modelo'],
      capacidadeAh: json['capacidadeAh'],
      quantidadeCelulas: json['quantidadeCelulas'],
      tensaoFlutuacaoBanco: json['tensaoFlutuacaoBanco'],
      rippleMedido: json['rippleMedido'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

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
    };
  }
}
