import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/tables/syncable_table.dart';

class TecnicosTable extends SyncableTable {
  TextColumn get nome => text().withLength(min: 2, max: 100)();
  TextColumn get matricula => text().withLength(min: 2, max: 100)();
}
