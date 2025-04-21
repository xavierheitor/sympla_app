import 'package:drift/drift.dart';

enum TipoAtividadeMobile {
  ivItIu,
  prevBcBat,
  prevDisjuntor,
  medMalha,
  testeCaCc,
  coletaOleo,
  testesFuncDisjuntor,
}

class TipoAtividadeMobileConverter
    extends TypeConverter<TipoAtividadeMobile, String> {
  const TipoAtividadeMobileConverter();

  @override
  TipoAtividadeMobile fromSql(String fromDb) {
    return TipoAtividadeMobile.values.firstWhere(
      (e) => e.name == fromDb,
      orElse: () => TipoAtividadeMobile.ivItIu, // fallback seguro
    );
  }

  @override
  String toSql(TipoAtividadeMobile value) => value.name;
}
