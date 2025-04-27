import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/tables/apr_preenchida_table.dart';
import 'package:sympla_app/core/storage/tables/tecnicos_table.dart';
import 'package:sympla_app/core/storage/tables/usuario_table.dart';

class AprAssinaturaTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get aprPreenchidaId =>
      integer().references(AprPreenchidaTable, #id)();
  IntColumn get usuarioId => integer().references(UsuarioTable, #id)();
  DateTimeColumn get dataAssinatura => dateTime()();
  IntColumn get tecnicoId => integer().references(TecnicosTable, #id)();
  TextColumn get assinatura => text()();
  TextColumn get assinaturaPath => text().nullable()();
}
