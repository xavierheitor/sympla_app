import 'package:drift/drift.dart';

enum RespostaChecklist {
  ok,
  nok,
  na,
}

class RespostaChecklistConverter
    extends TypeConverter<RespostaChecklist, String> {
  const RespostaChecklistConverter();

  @override
  RespostaChecklist fromSql(String fromDb) =>
      RespostaChecklist.values.firstWhere(
        (e) => e.name == fromDb,
        orElse: () => RespostaChecklist.na,
      );

  @override
  String toSql(RespostaChecklist value) => value.name;
}

extension RespostaChecklistExt on RespostaChecklist {
  String get label {
    switch (this) {
      case RespostaChecklist.ok:
        return 'OK';
      case RespostaChecklist.nok:
        return 'NOK';
      case RespostaChecklist.na:
        return 'N/A';
    }
  }
}
