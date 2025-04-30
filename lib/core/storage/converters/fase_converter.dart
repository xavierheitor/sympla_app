import 'package:drift/drift.dart';

enum FaseAnomalia {
  a,
  b,
  c,
}

class FaseAnomaliaConverter extends TypeConverter<FaseAnomalia, String> {
  const FaseAnomaliaConverter();

  @override
  FaseAnomalia fromSql(String fromDb) => FaseAnomalia.values.firstWhere(
        (e) => e.name == fromDb,
        orElse: () => FaseAnomalia.a,
      );

  @override
  String toSql(FaseAnomalia value) => value.name;
}

extension FaseAnomaliaExt on FaseAnomalia {
  String get label {
    switch (this) {
      case FaseAnomalia.a:
        return 'Fase A';
      case FaseAnomalia.b:
        return 'Fase B';
      case FaseAnomalia.c:
        return 'Fase C';
    }
  }
}
