import 'package:drift/drift.dart';

abstract class SyncableTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get uuid => text().named('uuid').withLength(min: 1, max: 100)();

  DateTimeColumn get createdAt => dateTime().named('created_at')();
  DateTimeColumn get updatedAt => dateTime().named('updated_at')();

  BoolColumn get sincronizado => boolean().withDefault(const Constant(false))();
}
