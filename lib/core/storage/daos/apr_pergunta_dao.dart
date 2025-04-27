import 'package:drift/drift.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/tables/apr_pergunta_relacionamento_table.dart';
import 'package:sympla_app/core/storage/tables/apr_question_table.dart';

part 'generated/apr_pergunta_dao.g.dart';

@DriftAccessor(tables: [AprPerguntaRelacionamentoTable, AprQuestionTable])
class AprPerguntaDao extends DatabaseAccessor<AppDatabase>
    with _$AprPerguntaDaoMixin {
  AprPerguntaDao(super.db);

  Future<void> inserirOuAtualizar(
      AprPerguntaRelacionamentoTableCompanion entry) async {
    AppLogger.d('💾 Salvando Pergunta-Relacionamento: ${entry.toString()}',
        tag: 'AprPerguntaDao');
    await into(aprPerguntaRelacionamentoTable).insertOnConflictUpdate(entry);
  }

  Future<List<AprQuestionTableData>> buscarPerguntasPorApr(int aprId) async {
    final query = select(aprQuestionTable).join([
      innerJoin(
        aprPerguntaRelacionamentoTable,
        aprPerguntaRelacionamentoTable.perguntaId
            .equalsExp(aprQuestionTable.id),
      )
    ])
      ..where(aprPerguntaRelacionamentoTable.aprId.equals(aprId))
      ..orderBy([OrderingTerm.asc(aprPerguntaRelacionamentoTable.ordem)]);

    final result = await query.get();
    return result.map((row) => row.readTable(aprQuestionTable)).toList();
  }

  Future<void> sincronizarComApi(
      List<AprQuestionTableCompanion> entradas) async {
    AppLogger.d('🔄 Sincronizando ${entradas.length} perguntas APR',
        tag: 'AprPerguntaDao');
    await batch((batch) {
      batch.update(
        aprPerguntaRelacionamentoTable,
        const AprPerguntaRelacionamentoTableCompanion(
            sincronizado: Value(false)),
      );
      batch.insertAllOnConflictUpdate(
        aprPerguntaRelacionamentoTable,
        entradas
            .map((e) => e.copyWith(sincronizado: const Value(true)))
            .toList(),
      );
    });
    final apagados = await (delete(aprPerguntaRelacionamentoTable)
          ..where((t) => t.sincronizado.equals(false)))
        .go();
    AppLogger.d('🧹 Removidos $apagados perguntas', tag: 'AprPerguntaDao');
  }

  Future<void> deletarTudo() async {
    AppLogger.w('🗑️ Deletando todas perguntas', tag: 'AprPerguntaDao');
    await delete(aprPerguntaRelacionamentoTable).go();
  }

  Future<bool> estaVazio() async {
    final result = await select(aprPerguntaRelacionamentoTable).get();
    return result.isEmpty;
  }
}
