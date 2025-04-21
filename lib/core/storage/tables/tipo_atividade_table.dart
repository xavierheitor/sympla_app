import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/converters/tipo_atividade_mobile_converter.dart';
import 'package:sympla_app/core/storage/tables/syncable_table.dart';

class TipoAtividadeTable extends SyncableTable {
  TextColumn get nome => text().withLength(min: 2, max: 100)();

  TextColumn get tipoAtividadeMobile =>
      text().map(const TipoAtividadeMobileConverter())();

  IntColumn get aprId => integer()(); // referência futura
  IntColumn get checklistId => integer()(); // referência futura
}
