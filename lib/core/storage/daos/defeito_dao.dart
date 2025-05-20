import 'package:drift/drift.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/tables/schema.dart';

part 'generated/defeito_dao.g.dart';

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
  Future<void> sincronizarDefeitosComApi(
      List<DefeitoTableCompanion> items) async {
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

  Future<void> sincronizaGruposDefeitoEquipamentoComApi(
      List<GrupoDefeitoEquipamentoTableCompanion> items) async {
    await transaction(() async {
      await delete(grupoDefeitoEquipamentoTable).go();
      final op = batch((b) {
        for (final item in items) {
          b.insert(grupoDefeitoEquipamentoTable, item);
        }
      });
      await op;
    });
  }

  Future<void> sincronizarGruposDefeitoCodigoComApi(
      List<GrupoDefeitoCodigoTableCompanion> items) async {
    await transaction(() async {
      await delete(grupoDefeitoCodigoTable).go();
      final op = batch((b) {
        for (final item in items) {
          b.insert(grupoDefeitoCodigoTable, item);
        }
      });
      await op;
    });
  }

  Future<void> sincronizarSubgruposDefeitoEquipamentoComApi(
      List<SubgrupoDefeitoEquipamentoTableCompanion> items) async {
    await transaction(() async {
      await delete(subgrupoDefeitoEquipamentoTable).go();
      final op = batch((b) {
        for (final item in items) {
          b.insert(subgrupoDefeitoEquipamentoTable, item);
        }
      });
      await op;
    });
  }

  Future<GrupoDefeitoCodigoTableData?> buscarGrupoDefeitoCodigo(
      String grupoDefeitoCodigo) {
    return (select(grupoDefeitoCodigoTable)
          ..where((tbl) => tbl.codigo.equals(grupoDefeitoCodigo)))
        .getSingleOrNull();
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

  Future<bool> estaVazioDefeito() async {
    final count = await select(defeitoTable).get();
    return count.isEmpty;
  }

  Future<bool> estaVazioGrupoDefeitoEquipamento() async {
    final count = await select(grupoDefeitoEquipamentoTable).get();
    return count.isEmpty;
  }

  Future<bool> estaVazioGrupoDefeitoCodigo() async {
    final count = await select(grupoDefeitoCodigoTable).get();
    return count.isEmpty;
  }

  Future<bool> estaVazioSubgrupoDefeitoEquipamento() async {
    final count = await select(subgrupoDefeitoEquipamentoTable).get();
    return count.isEmpty;
  }

  Future<List<DefeitoTableData>> buscarDefeitosPorEquipamentoCodigo(
      String equipamentoCodigo) async {
    final grupo = await buscarGrupoDefeitoCodigo(equipamentoCodigo);

    if (grupo == null) {
      AppLogger.w(
          '[DefeitoDao] Grupo de defeito código não encontrado para código: $equipamentoCodigo');
      return [];
    }

    final lista = await (select(defeitoTable)
          ..where((tbl) => tbl.grupoDefeitoCodigoId.equals(grupo.uuid)))
        .get();

    return lista;
  }
}
