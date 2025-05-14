import 'package:drift/drift.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/tables/schema.dart';

part 'defeito_dao.g.dart';

@DriftAccessor(tables: [
  DefeitoTable,
  GrupoDefeitoEquipamentoTable,
  SubgrupoDefeitoEquipamentoTable,
  GrupoDefeitoCodigoTable,
  EquipamentoTable,
])
class DefeitoDao extends DatabaseAccessor<AppDatabase> with _$DefeitoDaoMixin {
  DefeitoDao(super.db);

  /// Busca todos os defeitos
  Future<List<DefeitoTableData>> getAll() => select(defeitoTable).get();

  /// Insere um novo defeito
  Future<int> insert(DefeitoTableCompanion data) =>
      into(defeitoTable).insert(data);

  /// Atualiza um defeito existente
  Future<bool> updateItem(DefeitoTableData data) =>
      update(defeitoTable).replace(data);

  /// Remove um defeito pelo ID
  Future<int> deleteById(int id) =>
      (delete(defeitoTable)..where((tbl) => tbl.id.equals(id))).go();

  /// Remove todos os defeitos e insere os novos
  Future<void> clearAndInsertAll(List<DefeitoTableCompanion> items) async {
    await transaction(() async {
      await delete(defeitoTable).go();
      for (final item in items) {
        await into(defeitoTable).insert(item);
      }
    });
  }

  /// Sincroniza os dados recebidos da API com o banco local
  Future<void> sincronizarComApi(List<DefeitoTableCompanion> items) async {
    await transaction(() async {
      await delete(defeitoTable).go();
      final op = batch((b) {
        for (final item in items) {
          b.insert(defeitoTable, item);
        }
      });
      await op;
    });
  }

  /// Busca defeitos por grupo
  Future<List<DefeitoTableData>> getByGrupoId(String grupoId) {
    return (select(defeitoTable)..where((tbl) => tbl.grupoId.equals(grupoId)))
        .get();
  }

  /// Busca defeitos por subgrupo
  Future<List<DefeitoTableData>> getBySubgrupoId(String subgrupoId) {
    return (select(defeitoTable)
          ..where((tbl) => tbl.subgrupoId.equals(subgrupoId)))
        .get();
  }

  /// Busca defeitos com base no grupo/subgrupo do equipamento
  Future<List<DefeitoTableData>> buscarPorEquipamento(
      EquipamentoTableData equipamento) {
    AppLogger.d(
        '[DefeitoDao] Buscando por grupo=${equipamento.grupoDefeitoCodigo}}');
    return (select(defeitoTable)
          ..where((tbl) => tbl.grupoId.equals(equipamento.grupoDefeitoCodigo)))
        .get();
  }
}
