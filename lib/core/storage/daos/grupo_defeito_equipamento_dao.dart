import 'package:drift/drift.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/tables/grupo_defeito_equipamento.dart';

part 'grupo_defeito_equipamento_dao.g.dart';

@DriftAccessor(tables: [GrupoDefeitoEquipamentoTable])
class GrupoDefeitoEquipamentoDao extends DatabaseAccessor<AppDatabase>
    with _$GrupoDefeitoEquipamentoDaoMixin {
  GrupoDefeitoEquipamentoDao(AppDatabase db) : super(db);

  Future<void> inserirOuAtualizar(
      GrupoDefeitoEquipamentoTableCompanion data) async {
    AppLogger.d('🔄 GrupoDefeito: ${data.toString()}', tag: 'GrupoDefeitoDAO');
    await into(grupoDefeitoEquipamentoTable).insertOnConflictUpdate(data);
  }

  Future<void> sincronizarComApi(
      List<GrupoDefeitoEquipamentoTableCompanion> dadosApi) async {
    AppLogger.d('🔄 Sincronizando ${dadosApi.length} grupos...',
        tag: 'GrupoDefeitoDAO');

    await batch((batch) {
      batch.update(
          grupoDefeitoEquipamentoTable,
          const GrupoDefeitoEquipamentoTableCompanion(
              sincronizado: Value(false)));

      batch.insertAllOnConflictUpdate(
        grupoDefeitoEquipamentoTable,
        dadosApi
            .map((e) => e.copyWith(sincronizado: const Value(true)))
            .toList(),
      );
    });

    final apagados = await (delete(grupoDefeitoEquipamentoTable)
          ..where((t) => t.sincronizado.equals(false)))
        .go();

    AppLogger.d('🧹 Removidos $apagados grupos obsoletos',
        tag: 'GrupoDefeitoDAO');
  }
}
