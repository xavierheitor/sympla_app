import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/app_database.dart';

class AprQuestionTableDto {
  final String uuid;
  final String texto;

  AprQuestionTableDto({
    required this.uuid,
    required this.texto,
  });

  // 🔄 De JSON para DTO
  factory AprQuestionTableDto.fromJson(Map<String, dynamic> json) {
    return AprQuestionTableDto(
      uuid: json['id'],
      texto: json['pergunta'],
    );
  }

  // 🔄 De DTO para JSON
  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'pergunta': texto,
    };
  }

  // 🔄 De DTO para Companion
  AprQuestionTableCompanion toCompanion() {
    return AprQuestionTableCompanion(
      uuid: Value(uuid),
      texto: Value(texto),
      createdAt: Value(DateTime.now()),
      updatedAt: Value(DateTime.now()),
      sincronizado: const Value(true),
    );
  }

  // 🔄 De TableData para DTO
  factory AprQuestionTableDto.fromData(AprQuestionTableData data) {
    return AprQuestionTableDto(
      uuid: data.uuid,
      texto: data.texto,
    );
  }


  AprQuestionTableDto copyWith({
    String? uuid,
    String? texto,
  }) {
    return AprQuestionTableDto(
      uuid: uuid ?? this.uuid,
      texto: texto ?? this.texto,
    );
  }
}
