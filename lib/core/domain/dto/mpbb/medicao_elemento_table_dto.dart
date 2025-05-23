import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/app_database.dart';

class MedicaoElementoMpbbTableDto {
  final int? id;
  final int formularioBateriaId;
  final int elementoBateriaNumero;
  final double? tensao;
  final double? resistenciaInterna;

  MedicaoElementoMpbbTableDto({
    this.id,
    required this.formularioBateriaId,
    required this.elementoBateriaNumero,
    this.tensao,
    this.resistenciaInterna,
  });

  factory MedicaoElementoMpbbTableDto.fromData(
      MedicaoElementoMpbbTableData data) {
    return MedicaoElementoMpbbTableDto(
      id: data.id,
      formularioBateriaId: data.formularioMpbbId,
      elementoBateriaNumero: data.elementoBateriaNumero,
      tensao: data.tensao,
      resistenciaInterna: data.resistenciaInterna,
    );
  }

  MedicaoElementoMpbbTableCompanion toCompanion() {
    return MedicaoElementoMpbbTableCompanion(
      id: Value(id ?? 0),
      formularioMpbbId: Value(formularioBateriaId),
      elementoBateriaNumero: Value(elementoBateriaNumero),
      tensao: Value(tensao),
      resistenciaInterna: Value(resistenciaInterna),
    );
  }

  factory MedicaoElementoMpbbTableDto.fromJson(Map<String, dynamic> json) {
    return MedicaoElementoMpbbTableDto(
      id: json['id'],
      formularioBateriaId: json['formularioBateriaId'],
      elementoBateriaNumero: json['elementoBateriaNumero'],
      tensao: json['tensao'],
      resistenciaInterna: json['resistenciaInterna'],
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

  MedicaoElementoMpbbTableDto copyWith({
    int? id,
    int? formularioBateriaId,
    int? elementoBateriaNumero,
    double? tensao,
    double? resistenciaInterna,
  }) {
    return MedicaoElementoMpbbTableDto(
      id: id ?? this.id,
      formularioBateriaId: formularioBateriaId ?? this.formularioBateriaId,
      elementoBateriaNumero:
          elementoBateriaNumero ?? this.elementoBateriaNumero,
      tensao: tensao ?? this.tensao,
      resistenciaInterna: resistenciaInterna ?? this.resistenciaInterna,
    );
  }
}
