import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/app_database.dart';

class ChecklistPerguntaTableDto {
  final String uuid;
  final String pergunta;

  ChecklistPerguntaTableDto({
    required this.uuid,
    required this.pergunta,
  });

  // 🔄 De JSON para DTO
  factory ChecklistPerguntaTableDto.fromJson(Map<String, dynamic> json) {
    return ChecklistPerguntaTableDto(
      uuid: json['id'],
      pergunta: json['pergunta'],
    );
  }

  // 🔄 De DTO para JSON
  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'pergunta': pergunta,
    };
  }

  // 🔄 De DTO para Companion
  ChecklistPerguntaTableCompanion toCompanion() {
    return ChecklistPerguntaTableCompanion(
      uuid: Value(uuid),
      pergunta: Value(pergunta),
      createdAt: Value(DateTime.now()),
      updatedAt: Value(DateTime.now()),
      sincronizado: const Value(true),
    );
  }

  // 🔄 De TableData para DTO
  factory ChecklistPerguntaTableDto.fromData(ChecklistPerguntaTableData data) {
    return ChecklistPerguntaTableDto(
      uuid: data.uuid,
      pergunta: data.pergunta,
    );
  }
}
