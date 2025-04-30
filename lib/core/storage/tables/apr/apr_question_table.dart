import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/tables/syncable_table.dart';

class AprQuestionTable extends SyncableTable {
  TextColumn get texto => text()();
}
