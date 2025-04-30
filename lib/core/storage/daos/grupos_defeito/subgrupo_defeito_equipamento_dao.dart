import 'package:drift/drift.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/tables/equipamento/subgrupo_defeito_equipamento.dart';

part 'subgrupo_defeito_equipamento_dao.g.dart';

@DriftAccessor(tables: [SubgrupoDefeitoEquipamentoTable])
class SubgrupoDefeitoEquipamentoDao extends DatabaseAccessor<AppDatabase>
    with _$SubgrupoDefeitoEquipamentoDaoMixin {
  SubgrupoDefeitoEquipamentoDao(super.db);

  Future<void> inserirOuAtualizar(
      SubgrupoDefeitoEquipamentoTableCompanion data) async {
    AppLogger.d('🔄 SubgrupoDefeito: ${data.toString()}',
        tag: 'SubgrupoDefeitoDAO');
    await into(subgrupoDefeitoEquipamentoTable).insertOnConflictUpdate(data);
  }

  Future<void> sincronizarComApi(
      List<SubgrupoDefeitoEquipamentoTableCompanion> dadosApi) async {
    AppLogger.d('🔄 Sincronizando ${dadosApi.length} subgrupos...',
        tag: 'SubgrupoDefeitoDAO');

    await batch((batch) {
      batch.update(
          subgrupoDefeitoEquipamentoTable,
          const SubgrupoDefeitoEquipamentoTableCompanion(
              sincronizado: Value(false)));

      batch.insertAllOnConflictUpdate(
        subgrupoDefeitoEquipamentoTable,
        dadosApi
            .map((e) => e.copyWith(sincronizado: const Value(true)))
            .toList(),
      );
    });

    final apagados = await (delete(subgrupoDefeitoEquipamentoTable)
          ..where((t) => t.sincronizado.equals(false)))
        .go();

    AppLogger.d('🧹 Removidos $apagados subgrupos obsoletos',
        tag: 'SubgrupoDefeitoDAO');
  }

  Future<bool> estaVazio() async {
    final result = await select(subgrupoDefeitoEquipamentoTable).get();
    return result.isEmpty;
  }
}
