import 'package:drift/drift.dart';
import 'package:sympla_app/core/constants/tipo_atividade_mobile.dart';

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
