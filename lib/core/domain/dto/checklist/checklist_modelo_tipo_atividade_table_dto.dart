import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/app_database.dart';

class ChecklistModeloTipoAtividadeTableDto {
  final String uuid;
  final String checklistId;
  final String tipoAtividadeId;

  ChecklistModeloTipoAtividadeTableDto({
    required this.uuid,
    required this.checklistId,
    required this.tipoAtividadeId,
  });

  factory ChecklistModeloTipoAtividadeTableDto.fromJson(Map<String, dynamic> json) {
    return ChecklistModeloTipoAtividadeTableDto(
      uuid: json['id'],
      checklistId: json['modeloId'],
      tipoAtividadeId: json['tipoAtividadeId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': uuid,
      'modeloId': checklistId,
      'tipoAtividadeId': tipoAtividadeId,
    };
  }

  ChecklistTipoAtividadeTableCompanion toCompanion() {
    return ChecklistTipoAtividadeTableCompanion(
      uuid: Value(uuid),
      checklistId: Value(checklistId),
      tipoAtividadeId: Value(tipoAtividadeId),
      createdAt: Value(DateTime.now()),
      updatedAt: Value(DateTime.now()),
      sincronizado: const Value(true),
    );
  }

  factory ChecklistModeloTipoAtividadeTableDto.fromData(
    ChecklistTipoAtividadeTableData data,
  ) {
    return ChecklistModeloTipoAtividadeTableDto(
      uuid: data.uuid,
      checklistId: data.checklistId,
      tipoAtividadeId: data.tipoAtividadeId,
    );
  }

  ChecklistModeloTipoAtividadeTableDto copyWith({
    String? uuid,
    String? checklistId,
    String? tipoAtividadeId,
  }) {
    return ChecklistModeloTipoAtividadeTableDto(
      uuid: uuid ?? this.uuid,
      checklistId: checklistId ?? this.checklistId,
      tipoAtividadeId: tipoAtividadeId ?? this.tipoAtividadeId,
    );
  }
}
