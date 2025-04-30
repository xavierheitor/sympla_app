import 'package:drift/drift.dart';

enum LadoAnomalia {
  fonte,
  carga,
  fonteECarga,
}

class LadoAnomaliaConverter extends TypeConverter<LadoAnomalia, String> {
  const LadoAnomaliaConverter();

  @override
  LadoAnomalia fromSql(String fromDb) => LadoAnomalia.values.firstWhere(
        (e) => e.name == fromDb,
        orElse: () => LadoAnomalia.fonte,
      );

  @override
  String toSql(LadoAnomalia value) => value.name;
}

extension LadoAnomaliaExt on LadoAnomalia {
  String get label {
    switch (this) {
      case LadoAnomalia.fonte:
        return 'FONTE';
      case LadoAnomalia.carga:
        return 'CARGA';
      case LadoAnomalia.fonteECarga:
        return 'FONTE E CARGA';
    }
  }
}
