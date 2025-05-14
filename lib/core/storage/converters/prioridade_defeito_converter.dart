import 'package:drift/drift.dart';

enum PrioridadeDefeito { a, p1, p2, p3 }

class PrioridadeDefeitoConverter
    extends TypeConverter<PrioridadeDefeito, String> {
  const PrioridadeDefeitoConverter();

  @override
  PrioridadeDefeito fromSql(String fromDb) {
    return PrioridadeDefeito.values.byName(fromDb);
  }

  @override
  String toSql(PrioridadeDefeito value) {
    return value.name;
  }
}

extension PrioridadeDefeitoExtension on PrioridadeDefeito {
  String get name => toString().split('.').last;
}
