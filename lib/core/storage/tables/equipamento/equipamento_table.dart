import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/tables/equipamento/grupo_defeito_equipamento.dart';
import 'package:sympla_app/core/storage/tables/equipamento/subgrupo_defeito_equipamento.dart';
import 'package:sympla_app/core/storage/tables/syncable_table.dart';

class EquipamentoTable extends SyncableTable {
  TextColumn get nome => text().withLength(min: 2, max: 100)();
  TextColumn get descricao => text().withLength(min: 2, max: 200)();
  TextColumn get subestacao => text().withLength(min: 1, max: 3)();

  IntColumn get grupoId =>
      integer().references(GrupoDefeitoEquipamentoTable, #id)();

  IntColumn get subgrupoId =>
      integer().references(SubgrupoDefeitoEquipamentoTable, #id)();
}
