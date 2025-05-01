import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/converters/fase_converter.dart';
import 'package:sympla_app/core/storage/converters/lado_converter.dart';
import 'package:sympla_app/core/storage/converters/resposta_checklist_converter.dart';
import 'package:sympla_app/core/storage/tables/equipamento/grupo_defeito_equipamento.dart';
import 'package:sympla_app/core/storage/tables/equipamento/subgrupo_defeito_equipamento.dart';
import 'package:sympla_app/core/storage/tables/syncable_table.dart';

// ---------------------- Tabelas que herdam de SyncableTable ----------------------
class ChecklistGrupoTable extends SyncableTable {
  TextColumn get nome => text()();
}

class ChecklistSubgrupoTable extends SyncableTable {
  IntColumn get grupoId => integer().references(ChecklistGrupoTable, #id)();
  TextColumn get nome => text()();
}

class ChecklistPerguntaTable extends SyncableTable {
  IntColumn get subgrupoId =>
      integer().references(ChecklistSubgrupoTable, #id)();
  TextColumn get pergunta => text()();
}

class DefeitoTable extends SyncableTable {
  IntColumn get grupoId =>
      integer().references(GrupoDefeitoEquipamentoTable, #id)();
  IntColumn get subgrupoId =>
      integer().references(SubgrupoDefeitoEquipamentoTable, #id)();
  TextColumn get codigoSap => text()();
  TextColumn get descricao => text()();
  TextColumn get prioridade => text()(); // Ex: A, P1, P2
}

// ---------------------- Tabelas auxiliares que NÃO herdam de SyncableTable ----------------------

class ChecklistRespostaTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get perguntaId =>
      integer().references(ChecklistPerguntaTable, #id)();
  IntColumn get atividadeId => integer()();
  TextColumn get resposta => text().map(const RespostaChecklistConverter())();
}

class AnomaliaTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get perguntaId =>
      integer().nullable()(); // Vinculada só durante o checklist
  IntColumn get atividadeId => integer()();
  IntColumn get equipamentoId => integer()();
  IntColumn get defeitoId => integer().references(DefeitoTable, #id)();
  TextColumn get fase => text().map(const FaseAnomaliaConverter())();
  TextColumn get lado => text().map(const LadoAnomaliaConverter())();
  RealColumn get delta => real().nullable()();
  TextColumn get observacao => text().nullable()();
  BlobColumn get foto => blob().nullable()(); // Imagem tirada na hora
  BoolColumn get corrigida => boolean().withDefault(const Constant(false))();
}

class CorrecaoAnomaliaTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get anomaliaId => integer().references(AnomaliaTable, #id)();
  IntColumn get atividadeId => integer()();
  TextColumn get foto =>
      text().nullable()(); // Pode ser base64 ou caminho local
}
