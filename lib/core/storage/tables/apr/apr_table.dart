import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/tables/syncable_table.dart';

class AprTable extends SyncableTable {
  TextColumn get nome => text()();
  TextColumn get descricao => text().nullable()();
}
