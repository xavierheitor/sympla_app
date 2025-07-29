import 'package:drift/drift.dart';

/// 🔧 Converter para o enum EstadoDisjuntor
///
/// 🔌 Mapeia os valores do enum para strings no banco de dados
/// - aberto: Disjuntor aberto
/// - fechado: Disjuntor fechado
class EstadoDisjuntorConverter extends TypeConverter<EstadoDisjuntor, String> {
  const EstadoDisjuntorConverter();

  @override
  EstadoDisjuntor fromSql(String fromDb) {
    switch (fromDb) {
      case 'aberto':
        return EstadoDisjuntor.aberto;
      case 'fechado':
        return EstadoDisjuntor.fechado;
      default:
        return EstadoDisjuntor.fechado; // Valor padrão
    }
  }

  @override
  String toSql(EstadoDisjuntor value) {
    switch (value) {
      case EstadoDisjuntor.aberto:
        return 'aberto';
      case EstadoDisjuntor.fechado:
        return 'fechado';
    }
  }
}

/// 🔌 Enum para o estado do disjuntor durante o ensaio
enum EstadoDisjuntor {
  aberto, // Disjuntor aberto
  fechado, // Disjuntor fechado
}

extension EstadoDisjuntorExt on EstadoDisjuntor {
  String get label {
    switch (this) {
      case EstadoDisjuntor.aberto:
        return 'Aberto';
      case EstadoDisjuntor.fechado:
        return 'Fechado';
    }
  }
}
