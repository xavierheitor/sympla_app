import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/tables/syncable_table.dart';

class SubgrupoDefeitoEquipamentoTable extends SyncableTable {
  TextColumn get nome => text().withLength(min: 2, max: 100)();
}
