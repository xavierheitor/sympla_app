import 'package:drift/drift.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/tables/schema.dart';

part 'defeito_dao.g.dart';

@DriftAccessor(tables: [
  DefeitoTable,
  GrupoDefeitoEquipamentoTable,
  SubgrupoDefeitoEquipamentoTable,
  EquipamentoTable,
])
class DefeitoDao extends DatabaseAccessor<AppDatabase> with _$DefeitoDaoMixin {
  DefeitoDao(super.db);

  Future<List<DefeitoTableData>> getAll() => select(defeitoTable).get();

  Future<int> insert(DefeitoTableCompanion data) =>
      into(defeitoTable).insert(data);

  Future<bool> updateItem(DefeitoTableData data) =>
      update(defeitoTable).replace(data);

  Future<int> deleteById(int id) =>
      (delete(defeitoTable)..where((tbl) => tbl.id.equals(id))).go();

  Future<void> clearAndInsertAll(List<DefeitoTableCompanion> items) async {
    await transaction(() async {
      await delete(defeitoTable).go();
      for (final item in items) {
        await into(defeitoTable).insert(item);
      }
    });
  }

  Future<void> sincronizarDefeitosComApi(
      List<DefeitoTableCompanion> items) async {
    await transaction(() async {
      await delete(defeitoTable).go();
      await batch((b) {
        b.insertAll(defeitoTable, items);
      });
    });
  }

  Future<void> sincronizarGruposDefeitoEquipamentoComApi(
      List<GrupoDefeitoEquipamentoTableCompanion> items) async {
    await transaction(() async {
      await delete(grupoDefeitoEquipamentoTable).go();
      await batch((b) {
        b.insertAll(grupoDefeitoEquipamentoTable, items);
      });
    });
  }

  Future<void> sincronizarSubgruposDefeitoEquipamentoComApi(
      List<SubgrupoDefeitoEquipamentoTableCompanion> items) async {
    await transaction(() async {
      await delete(subgrupoDefeitoEquipamentoTable).go();
      await batch((b) {
        b.insertAll(subgrupoDefeitoEquipamentoTable, items);
      });
    });
  }

  Future<List<DefeitoTableData>> getByGrupoId(String grupoId) {
    return (select(defeitoTable)..where((tbl) => tbl.grupoId.equals(grupoId)))
        .get();
  }

  Future<List<DefeitoTableData>> getBySubgrupoId(String subgrupoId) {
    return (select(defeitoTable)
          ..where((tbl) => tbl.subgrupoId.equals(subgrupoId)))
        .get();
  }

  Future<List<DefeitoTableData>> buscarPorEquipamento(
      EquipamentoTableData equipamento) {
    AppLogger.d(
        '[DefeitoDao] Buscando por grupo=${equipamento.grupoId}');
    return (select(defeitoTable)
          ..where((tbl) => tbl.grupoId.equals(equipamento.grupoId)))
        .get();
  }

  Future<bool> estaVazioDefeito() async =>
      (await select(defeitoTable).get()).isEmpty;

  Future<bool> estaVazioGrupoDefeitoEquipamento() async =>
      (await select(grupoDefeitoEquipamentoTable).get()).isEmpty;

  Future<bool> estaVazioSubgrupoDefeitoEquipamento() async =>
      (await select(subgrupoDefeitoEquipamentoTable).get()).isEmpty;

  Future<List<DefeitoTableData>> buscarDefeitosPorEquipamentoCodigo(
      String equipamentoCodigo) async {
    final grupo = await buscarGrupoDefeitoCodigo(equipamentoCodigo);

    if (grupo == null) {
      AppLogger.w(
          '[DefeitoDao] Grupo de defeito não encontrado para código: $equipamentoCodigo');
      return [];
    }

    return (select(defeitoTable)
          ..where((tbl) => tbl.grupoId.equals(grupo.uuid)))
        .get();
  }

  Future<GrupoDefeitoEquipamentoTableData?> buscarGrupoDefeitoCodigo(
      String codigo) async {
    return (select(grupoDefeitoEquipamentoTable)
          ..where((tbl) => tbl.uuid.equals(codigo)))
        .getSingleOrNull();
  }
}
