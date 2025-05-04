import 'package:drift/drift.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/tables/prev_disj/prev_disj_schema.dart';

part 'prev_disj_form_dao.g.dart';

@DriftAccessor(tables: [PrevDisjForm])
class PrevDisjFormDao extends DatabaseAccessor<AppDatabase>
    with _$PrevDisjFormDaoMixin {
  PrevDisjFormDao(super.db);

  Future<List<PrevDisjFormData>> getAll() => select(prevDisjForm).get();

  Future<PrevDisjFormData?> getByAtividadeId(int atividadeId) {
    return (select(prevDisjForm)
          ..where((t) => t.atividadeId.equals(atividadeId)))
        .getSingleOrNull();
  }

  Future<int> insert(PrevDisjFormCompanion entry) async {
    final existente = await getByAtividadeId(entry.atividadeId.value);

    if (existente != null) {
      final atualizado = PrevDisjFormData(
        id: existente.id,
        atividadeId: entry.atividadeId.value,
        caracterizacaoEnsaio: entry.caracterizacaoEnsaio.present
            ? entry.caracterizacaoEnsaio.value
            : null,
        termohigrometroFabricante: entry.termohigrometroFabricante.present
            ? entry.termohigrometroFabricante.value
            : null,
        termohigrometroTipo: entry.termohigrometroTipo.present
            ? entry.termohigrometroTipo.value
            : null,
        termohigrometroUltimaCalibracao:
            entry.termohigrometroUltimaCalibracao.present
                ? entry.termohigrometroUltimaCalibracao.value
                : null,
        micromimetroFabricante: entry.micromimetroFabricante.present
            ? entry.micromimetroFabricante.value
            : null,
        micromimetroTipo: entry.micromimetroTipo.present
            ? entry.micromimetroTipo.value
            : null,
        micromimetroUltimaCalibracao: entry.micromimetroUltimaCalibracao.present
            ? entry.micromimetroUltimaCalibracao.value
            : null,
        megometroFabricante: entry.megometroFabricante.present
            ? entry.megometroFabricante.value
            : null,
        megometroTipo:
            entry.megometroTipo.present ? entry.megometroTipo.value : null,
        megometroUltimaCalibracao: entry.megometroUltimaCalibracao.present
            ? entry.megometroUltimaCalibracao.value
            : null,
        oscilografoFabricante: entry.oscilografoFabricante.present
            ? entry.oscilografoFabricante.value
            : null,
        oscilografoTipo:
            entry.oscilografoTipo.present ? entry.oscilografoTipo.value : null,
        oscilografoUltimaCalibracao: entry.oscilografoUltimaCalibracao.present
            ? entry.oscilografoUltimaCalibracao.value
            : null,
        disjuntorFabricante: entry.disjuntorFabricante.present
            ? entry.disjuntorFabricante.value
            : null,
        disjuntorAnoFabricacao: entry.disjuntorAnoFabricacao.present
            ? entry.disjuntorAnoFabricacao.value
            : null,
        disjuntorTensaoNominal: entry.disjuntorTensaoNominal.present
            ? entry.disjuntorTensaoNominal.value
            : null,
        disjuntorCorrenteNominal: entry.disjuntorCorrenteNominal.present
            ? entry.disjuntorCorrenteNominal.value
            : null,
        disjuntorCapInterrupcaoNominal:
            entry.disjuntorCapInterrupcaoNominal.present
                ? entry.disjuntorCapInterrupcaoNominal.value
                : null,
        disjuntorTipoExtinsao: entry.disjuntorTipoExtinsao.present
            ? entry.disjuntorTipoExtinsao.value
            : null,
        disjuntorTipoAcionamento: entry.disjuntorTipoAcionamento.present
            ? entry.disjuntorTipoAcionamento.value
            : null,
        disjuntorPressaoSf6Nominal: entry.disjuntorPressaoSf6Nominal.present
            ? entry.disjuntorPressaoSf6Nominal.value
            : null,
        disjuntorPressaoSf6NominalTemperatura:
            entry.disjuntorPressaoSf6NominalTemperatura.present
                ? entry.disjuntorPressaoSf6NominalTemperatura.value
                : null,
        dataEnsaio:
            entry.dataEnsaio.present ? entry.dataEnsaio.value : DateTime.now(),
      );

      await update(prevDisjForm).replace(atualizado);
      return existente.id;
    } else {
      return into(prevDisjForm).insert(entry);
    }
  }

  Future<void> insertAll(List<PrevDisjFormCompanion> entries) async {
    await batch((batch) {
      batch.insertAll(prevDisjForm, entries);
    });
  }

  Future<void> updateItem(PrevDisjFormData data) async {
    await update(prevDisjForm).replace(data);
  }

  Future<void> deleteById(int id) async {
    await (delete(prevDisjForm)..where((t) => t.id.equals(id))).go();
  }

  Future<void> deleteByAtividadeId(int atividadeId) async {
    await (delete(prevDisjForm)
          ..where((t) => t.atividadeId.equals(atividadeId)))
        .go();
  }

  Future<void> clearAll() => delete(prevDisjForm).go();
}
