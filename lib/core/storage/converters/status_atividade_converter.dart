import 'package:drift/drift.dart';

enum StatusAtividade {
  pendente,
  emAndamento,
  concluido,
  cancelado,
  sincronizado,
}

class StatusAtividadeConverter extends TypeConverter<StatusAtividade, String> {
  const StatusAtividadeConverter();

  @override
  StatusAtividade fromSql(String fromDb) {
    return StatusAtividade.values.firstWhere(
      (e) => e.name == fromDb,
      orElse: () => StatusAtividade.pendente,
    );
  }

  @override
  String toSql(StatusAtividade value) => value.name;
}
