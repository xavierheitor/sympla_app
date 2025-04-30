import 'package:drift/drift.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/tables/apr/apr_table.dart';
import 'package:sympla_app/core/storage/tables/atividade/tipo_atividade_table.dart'; // <- IMPORTANTE!!

part 'apr_dao.g.dart';

@DriftAccessor(tables: [AprTable, TipoAtividadeTable]) // <- Aqui também!!
class AprDao extends DatabaseAccessor<AppDatabase> with _$AprDaoMixin {
  AprDao(super.db);

  Future<void> inserirOuAtualizar(AprTableCompanion entry) async {
    AppLogger.d('💾 Salvando APR: ${entry.toString()}', tag: 'AprDao');
    await into(aprTable).insertOnConflictUpdate(entry);
  }

  Future<List<AprTableData>> buscarTodos() async {
    final result = await select(aprTable).get();
    AppLogger.d('📄 Listou ${result.length} APRs', tag: 'AprDao');
    return result;
  }

  Future<void> sincronizarComApi(List<AprTableCompanion> entradas) async {
    AppLogger.d('🔄 Sincronizando ${entradas.length} APRs', tag: 'AprDao');
    await batch((batch) {
      batch.update(
        aprTable,
        const AprTableCompanion(sincronizado: Value(false)),
      );
      batch.insertAllOnConflictUpdate(
        aprTable,
        entradas
            .map((e) => e.copyWith(sincronizado: const Value(true)))
            .toList(),
      );
    });
    final apagados = await (delete(aprTable)
          ..where((tbl) => tbl.sincronizado.equals(false)))
        .go();
    AppLogger.d('🧹 Removidos $apagados APRs obsoletos', tag: 'AprDao');
  }

  Future<void> deletarTudo() async {
    AppLogger.w('🗑️ Apagando todos registros de APR', tag: 'AprDao');
    await delete(aprTable).go();
  }

  Future<bool> estaVazio() async {
    final result = await select(aprTable).get();
    return result.isEmpty;
  }

  Future<AprTableData> buscarPorTipoAtividade(int idTipoAtividade) async {
    final query = select(db.tipoAtividadeTable).join([
      innerJoin(
        aprTable,
        aprTable.id.equalsExp(db.tipoAtividadeTable.aprId),
      ),
    ])
      ..where(db.tipoAtividadeTable.id.equals(idTipoAtividade));

    final row = await query.getSingleOrNull();

    if (row == null) {
      throw Exception('Não encontrado APR para TipoAtividade $idTipoAtividade');
    }

    final apr = row.readTable(aprTable);
    return apr;
  }
}
