import 'package:drift/drift.dart';

enum TipoBateria {
  ventilada,
  selada,
  automotiva,
}

class TipoBateriaConverter extends TypeConverter<TipoBateria, String> {
  const TipoBateriaConverter();

  @override
  TipoBateria fromSql(String fromDb) => TipoBateria.values.firstWhere(
        (e) => e.name == fromDb,
        orElse: () => TipoBateria.ventilada,
      );

  @override
  String toSql(TipoBateria value) => value.name;
}

extension TipoBateriaExt on TipoBateria {
  String get label {
    switch (this) {
      case TipoBateria.ventilada:
        return 'VENTILADA';
      case TipoBateria.selada:
        return 'SELADA';
      case TipoBateria.automotiva:
        return 'AUTOMOTIVA';
    }
  }
}
