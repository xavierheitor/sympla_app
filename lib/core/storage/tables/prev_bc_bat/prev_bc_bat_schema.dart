import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/converters/tipo_bateria_converter.dart';
import 'package:sympla_app/core/storage/tables/atividade/atividade_table.dart';

class FormularioBateriaTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get atividadeId => integer().references(AtividadeTable, #id)();
  TextColumn get fabricante => text().nullable()();
  RealColumn get resistenciaNominal => real().nullable()();
  RealColumn get densidadeNominal => real().nullable()();
  RealColumn get tensaoFlutuacaoCelula => real().nullable()();
  RealColumn get densidadeCritica => real().nullable()();
  TextColumn get tipoBateria => text().map(const TipoBateriaConverter())();
  TextColumn get modelo => text().nullable()();
  IntColumn get capacidadeAh => integer().nullable()();
  IntColumn get quantidadeCelulas => integer().nullable()();
  RealColumn get tensaoFlutuacaoBanco => real().nullable()();
  RealColumn get rippleMedido => real().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();
}

class MedicaoElementoBateriaTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get formularioBateriaId => integer()
      .references(FormularioBateriaTable, #id, onDelete: KeyAction.cascade)();
  IntColumn get elementoBateriaNumero => integer()();
  RealColumn get tensao => real().nullable()();
  RealColumn get resistenciaInterna => real().nullable()();
}
