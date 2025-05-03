import 'package:drift/drift.dart';

enum CaracterizacaoEnsaio {
  ensaiosFinaisManutencao,
  ensaiosFabrica,
  ensaiosComissionamento,
  ensaiosRotina,
  ensaiosIniciaisManutencao,
  ensaiosIntermediariosManutencao,
}

class CaracterizacaoEnsaioConverter
    extends TypeConverter<CaracterizacaoEnsaio, String> {
  const CaracterizacaoEnsaioConverter();

  @override
  CaracterizacaoEnsaio fromSql(String fromDb) =>
      CaracterizacaoEnsaio.values.firstWhere(
        (e) => e.name == fromDb,
        orElse: () => CaracterizacaoEnsaio.ensaiosFinaisManutencao,
      );

  @override
  String toSql(CaracterizacaoEnsaio value) => value.name;
}

extension CaracterizacaoEnsaioExt on CaracterizacaoEnsaio {
  String get label {
    switch (this) {
      case CaracterizacaoEnsaio.ensaiosFinaisManutencao:
        return 'Ensaio Finais Manutenção';
      case CaracterizacaoEnsaio.ensaiosFabrica:
        return 'Ensaio Fabricação';
      case CaracterizacaoEnsaio.ensaiosComissionamento:
        return 'Ensaio Comissionamento';
      case CaracterizacaoEnsaio.ensaiosRotina:
        return 'Ensaio Rotina';
      case CaracterizacaoEnsaio.ensaiosIniciaisManutencao:
        return 'Ensaio Iniciais Manutenção';
      case CaracterizacaoEnsaio.ensaiosIntermediariosManutencao:
        return 'Ensaio Intermediários Manutenção';
    }
  }
}
