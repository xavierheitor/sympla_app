import 'package:drift/drift.dart';

enum StatusAtividade {
  pendente,
  emAndamento,
  concluido,
  cancelado,
  sincronizado,
  pendenteUpload,
  erroUpload,
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

extension StatusAtividadeExt on StatusAtividade {
  String get label {
    switch (this) {
      case StatusAtividade.pendente:
        return 'Pendente';
      case StatusAtividade.emAndamento:
        return 'Em Andamento';
      case StatusAtividade.concluido:
        return 'Concluído';
      case StatusAtividade.cancelado:
        return 'Cancelado';
      case StatusAtividade.sincronizado:
        return 'Sincronizado';
      case StatusAtividade.pendenteUpload:
        return 'Pendente Upload';
      case StatusAtividade.erroUpload:
        return 'Erro Upload';
    }
  }
}
