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
      // Aqui estamos atualizando a tabela correta: aprQuestionTable
      batch.deleteWhere(
          aprQuestionTable,
          (tbl) =>
              const Constant(true)); // Opcional: limpa tudo antes se quiser
      batch.insertAllOnConflictUpdate(
        aprQuestionTable,
        entradas,
      );
    });
  }

  Future<void> deletarTudo() async {
    AppLogger.w('🗑️ Deletando todas perguntas', tag: 'AprPerguntaDao');
    await delete(aprQuestionTable).go();
  }

  Future<bool> estaVazio() async {
    final result = await select(aprQuestionTable).get();
    return result.isEmpty;
  }
}
