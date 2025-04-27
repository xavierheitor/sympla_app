import 'package:drift/drift.dart';

enum RespostaApr {
  sim,
  nao,
  naoSeAplica,
}

class RespostaAprConverter extends TypeConverter<RespostaApr, String> {
  const RespostaAprConverter();

  @override
  RespostaApr fromSql(String fromDb) {
    return RespostaApr.values.firstWhere(
      (e) => e.name == fromDb,
      orElse: () => RespostaApr.nao,
    );
  }

  @override
  String toSql(RespostaApr value) => value.name;
}

extension RespostaAprExt on RespostaApr {
  String get label {
    switch (this) {
      case RespostaApr.sim:
        return 'SIM';
      case RespostaApr.nao:
        return 'NAO';
      case RespostaApr.naoSeAplica:
        return 'N/A';
    }
  }
}
