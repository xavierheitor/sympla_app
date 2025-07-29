import 'package:drift/drift.dart';

/// 🔧 Converter para o enum FaseIsolamento
/// 
/// 📊 Mapeia os valores do enum para strings no banco de dados
/// - abc: Todas as fases
/// - a: Fase A
/// - b: Fase B  
/// - c: Fase C
class FaseIsolamentoConverter extends TypeConverter<FaseIsolamento, String> {
  const FaseIsolamentoConverter();

  @override
  FaseIsolamento fromSql(String fromDb) {
    switch (fromDb) {
      case 'abc':
        return FaseIsolamento.abc;
      case 'a':
        return FaseIsolamento.a;
      case 'b':
        return FaseIsolamento.b;
      case 'c':
        return FaseIsolamento.c;
      default:
        return FaseIsolamento.abc; // Valor padrão
    }
  }

  @override
  String toSql(FaseIsolamento value) {
    switch (value) {
      case FaseIsolamento.abc:
        return 'abc';
      case FaseIsolamento.a:
        return 'a';
      case FaseIsolamento.b:
        return 'b';
      case FaseIsolamento.c:
        return 'c';
    }
  }
}

/// ⚡ Enum para as fases do ensaio de resistência de isolamento
enum FaseIsolamento {
  abc, // Todas as fases
  a, // Fase A
  b, // Fase B
  c, // Fase C
}

extension FaseIsolamentoExt on FaseIsolamento {
  String get label {
    switch (this) {
      case FaseIsolamento.abc:
        return 'ABC';
      case FaseIsolamento.a:
        return 'A';
      case FaseIsolamento.b:
        return 'B';
      case FaseIsolamento.c:
        return 'C';
    }
  }
} 