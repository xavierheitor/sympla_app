import 'package:drift/drift.dart';

/// Representa a posição do disjuntor durante o ensaio:
/// Entrada (E), Saída (S) ou Terra (T)
enum PosicaoDisjuntorEnsaio { entrada, saida, terra }

class PosicaoDisjuntorEnsaioConverter
    extends TypeConverter<PosicaoDisjuntorEnsaio, String> {
  const PosicaoDisjuntorEnsaioConverter();

  @override
  PosicaoDisjuntorEnsaio fromSql(String fromDb) {
    switch (fromDb.toUpperCase()) {
      case 'E':
        return PosicaoDisjuntorEnsaio.entrada;
      case 'S':
        return PosicaoDisjuntorEnsaio.saida;
      case 'T':
        return PosicaoDisjuntorEnsaio.terra;
      default:
        throw ArgumentError('Posição inválida no banco: $fromDb');
    }
  }

  @override
  String toSql(PosicaoDisjuntorEnsaio value) {
    switch (value) {
      case PosicaoDisjuntorEnsaio.entrada:
        return 'E';
      case PosicaoDisjuntorEnsaio.saida:
        return 'S';
      case PosicaoDisjuntorEnsaio.terra:
        return 'T';
    }
  }
}
