import 'package:drift/drift.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/tables/tecnicos_table.dart';

part 'generated/tecnicos_dao.g.dart';

@DriftAccessor(tables: [TecnicosTable])
class TecnicosDao extends DatabaseAccessor<AppDatabase>
    with _$TecnicosDaoMixin {
  TecnicosDao(super.db);

  Future<void> inserirOuAtualizar(TecnicosTableCompanion entry) async {
    AppLogger.d('💾 Salvando Técnico: ${entry.toString()}', tag: 'TecnicosDao');
    await into(tecnicosTable).insertOnConflictUpdate(entry);
  }

  Future<List<TecnicosTableData>> buscarTodos() async {
    final result = await select(tecnicosTable).get();
    AppLogger.d('📄 Listou ${result.length} Técnicos', tag: 'TecnicosDao');
    return result;
  }

  Future<void> sincronizarComApi(List<TecnicosTableCompanion> tecnicos) async {
    AppLogger.d('🔄 Iniciando sincronização de ${tecnicos.length} Técnicos',
        tag: 'TecnicosDao');
    await batch((batch) {
      batch.update(
        tecnicosTable,
        const TecnicosTableCompanion(sincronizado: Value(false)),
      );
      batch.insertAllOnConflictUpdate(
        tecnicosTable,
        tecnicos
            .map((e) => e.copyWith(sincronizado: const Value(true)))
            .toList(),
      );
    });
    final apagados = await (delete(tecnicosTable)
          ..where((tbl) => tbl.sincronizado.equals(false)))
        .go();
    AppLogger.d('🧹 Removidos $apagados Técnicos obsoletos',
        tag: 'TecnicosDao');
  }

  Future<void> deletarTudo() async {
    AppLogger.w('🗑️ Deletando todos os Técnicos', tag: 'TecnicosDao');
    await delete(tecnicosTable).go();
  }

  Future<bool> estaVazio() async {
    final result = await select(tecnicosTable).get();
    return result.isEmpty;
  }
}
