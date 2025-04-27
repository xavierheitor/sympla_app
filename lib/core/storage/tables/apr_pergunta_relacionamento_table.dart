import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/tables/syncable_table.dart';
import 'package:sympla_app/core/storage/tables/apr_table.dart';
import 'package:sympla_app/core/storage/tables/apr_question_table.dart';

class AprPerguntaRelacionamentoTable extends SyncableTable {
  IntColumn get aprId => integer().references(AprTable, #id)();
  IntColumn get perguntaId => integer().references(AprQuestionTable, #id)();
  IntColumn get ordem => integer()();
}
