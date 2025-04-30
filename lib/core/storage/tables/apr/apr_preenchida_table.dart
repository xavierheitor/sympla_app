import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/tables/apr/apr_table.dart';
import 'package:sympla_app/core/storage/tables/atividade/atividade_table.dart';
import 'package:sympla_app/core/storage/tables/usuario_table.dart';

class AprPreenchidaTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get atividadeId => integer().references(AtividadeTable, #id)();
  IntColumn get aprId => integer().references(AprTable, #id)();
  IntColumn get usuarioId => integer().references(UsuarioTable, #id)();
  DateTimeColumn get dataPreenchimento => dateTime()();
}
