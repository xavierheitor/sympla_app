import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/tables/apr_preenchida_table.dart';
import 'package:sympla_app/core/storage/tables/tecnicos_table.dart';
import 'package:sympla_app/core/storage/tables/usuario_table.dart';

class AprAssinaturaTable extends Table {
  //id
  IntColumn get id => integer().autoIncrement()();
  //id da atividade preenchida
  IntColumn get aprPreenchidaId =>
      integer().references(AprPreenchidaTable, #id)();
  //id do usuário
  IntColumn get usuarioId => integer().references(UsuarioTable, #id)();
  //data da assinatura
  DateTimeColumn get dataAssinatura => dateTime()();
  //id do técnico
  IntColumn get tecnicoId => integer().references(TecnicosTable, #id)();
  //assinatura em bytes
  BlobColumn get assinatura => blob()();
  //caminho da assinatura
  TextColumn get assinaturaPath => text().nullable()();
}
