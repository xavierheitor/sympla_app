

import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/app_database.dart';

class AprModeloTipoAtividadeTableDto {
  final String uuid;
  final String aprId;
  final String tipoAtividadeId;

  AprModeloTipoAtividadeTableDto({
    required this.uuid,
    required this.aprId,
    required this.tipoAtividadeId,
  });

  factory AprModeloTipoAtividadeTableDto.fromJson(Map<String, dynamic> json) {
    return AprModeloTipoAtividadeTableDto(
      uuid: json['id'],
      aprId: json['modeloId'],
      tipoAtividadeId: json['tipoAtividadeId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': uuid,
      'modeloId': aprId,
      'tipoAtividadeId': tipoAtividadeId,
    };
  }

  AprTipoAtividadeTableCompanion toCompanion() {
    return AprTipoAtividadeTableCompanion(
      uuid: Value(uuid),
      aprId: Value(aprId),
      tipoAtividadeId: Value(tipoAtividadeId),
      createdAt: Value(DateTime.now()),
      updatedAt: Value(DateTime.now()),
      sincronizado: const Value(true),
    );
  }

  factory AprModeloTipoAtividadeTableDto.fromData(
    AprTipoAtividadeTableData data,
  ) {
    return AprModeloTipoAtividadeTableDto(
      uuid: data.uuid,
      aprId: data.aprId,
      tipoAtividadeId: data.tipoAtividadeId,
    );
  }

  AprModeloTipoAtividadeTableDto copyWith({
    String? uuid,
    String? aprId,
    String? tipoAtividadeId,
  }) {
    return AprModeloTipoAtividadeTableDto(
      uuid: uuid ?? this.uuid,
      aprId: aprId ?? this.aprId,
      tipoAtividadeId: tipoAtividadeId ?? this.tipoAtividadeId,
    );
  }
}