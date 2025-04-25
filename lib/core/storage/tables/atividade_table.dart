import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/converters/tipo_atividade_mobile_converter.dart';
import 'package:sympla_app/core/storage/tables/syncable_table.dart';
import 'package:sympla_app/core/storage/tables/tipo_atividade_table.dart';
import 'package:sympla_app/core/storage/tables/equipamento_table.dart';
import 'package:sympla_app/core/storage/converters/status_atividade_converter.dart';

class AtividadeTable extends SyncableTable {
  TextColumn get titulo => text().withLength(min: 2, max: 100)();
  TextColumn get ordemServico => text().withLength(min: 2, max: 50)();
  TextColumn get descricao => text().withLength(min: 2, max: 200)();
  DateTimeColumn get dataLimite => dateTime()();
  TextColumn get subestacao => text().withLength(min: 1, max: 3)();
  IntColumn get equipamentoId => integer().references(EquipamentoTable, #id)();

  TextColumn get status => text().map(const StatusAtividadeConverter())();
  DateTimeColumn get dataInicio => dateTime().nullable()();
  DateTimeColumn get dataFim => dateTime().nullable()();

  IntColumn get tipoAtividadeId =>
      integer().references(TipoAtividadeTable, #id)();
  TextColumn get tipoAtividadeMobile =>
      text().map(const TipoAtividadeMobileConverter())();
}
