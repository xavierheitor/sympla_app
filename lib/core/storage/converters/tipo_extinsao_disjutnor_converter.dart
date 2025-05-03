import 'package:drift/drift.dart';

enum TipoExtinsaoDisjuntor { sf6, vacuo, pvo, gvo, arComprimido }

class TipoExtinsaoDisjuntorConverter
    extends TypeConverter<TipoExtinsaoDisjuntor, String> {
  const TipoExtinsaoDisjuntorConverter();

  @override
  TipoExtinsaoDisjuntor fromSql(String fromDb) {
    return TipoExtinsaoDisjuntor.values.byName(fromDb);
  }

  @override
  String toSql(TipoExtinsaoDisjuntor value) {
    return value.name;
  }
}

extension TipoExtinsaoDisjuntorExtension on TipoExtinsaoDisjuntor {
  String get name => toString().split('.').last;
}
