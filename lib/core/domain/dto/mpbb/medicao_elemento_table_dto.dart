import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/app_database.dart';

class MedicaoElementoBateriaDto {
  final int id;
  final int formularioBateriaId;
  final int elementoBateriaNumero;
  final double? tensao;
  final double? resistenciaInterna;

  MedicaoElementoBateriaDto({
    required this.id,
    required this.formularioBateriaId,
    required this.elementoBateriaNumero,
    this.tensao,
    this.resistenciaInterna,
  });

  factory MedicaoElementoBateriaDto.fromData(
      MedicaoElementoBateriaTableData data) {
    return MedicaoElementoBateriaDto(
      id: data.id,
      formularioBateriaId: data.formularioBateriaId,
      elementoBateriaNumero: data.elementoBateriaNumero,
      tensao: data.tensao,
      resistenciaInterna: data.resistenciaInterna,
    );
  }

  MedicaoElementoBateriaTableCompanion toCompanion() {
    return MedicaoElementoBateriaTableCompanion(
      id: Value(id),
      formularioBateriaId: Value(formularioBateriaId),
      elementoBateriaNumero: Value(elementoBateriaNumero),
      tensao: Value(tensao),
      resistenciaInterna: Value(resistenciaInterna),
    );
  }

  factory MedicaoElementoBateriaDto.fromJson(Map<String, dynamic> json) {
    return MedicaoElementoBateriaDto(
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
}
