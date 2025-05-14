import 'package:drift/drift.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/tables/schema.dart';

part 'apr_dao.g.dart';

@DriftAccessor(tables: [
  AprTable,
  TipoAtividadeTable,
  AprQuestionTable,
  AprPerguntaRelacionamentoTable,
  AprPreenchidaTable,
  AprRespostaTable,
  AprAssinaturaTable,
])
class AprDao extends DatabaseAccessor<AppDatabase> with _$AprDaoMixin {
  AprDao(super.db);

  // === MODELO DE APR ===

  /// Salva ou atualiza um modelo de APR
  Future<void> salvarApr(AprTableCompanion entry) async {
    AppLogger.d('💾 Salvando APR: $entry', tag: 'AprDao');
    await into(aprTable).insertOnConflictUpdate(entry);
  }

  /// Lista todos os modelos de APR
  Future<List<AprTableData>> buscarTodosAprs() async {
    final result = await select(aprTable).get();
    AppLogger.d('📄 Listou ${result.length} APRs', tag: 'AprDao');
    return result;
  }

  /// Sincroniza modelos de APR com a API
  Future<void> sincronizarAprs(List<AprTableCompanion> entradas) async {
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

  /// Busca o modelo de APR vinculado a um tipo de atividade
  Future<AprTableData> buscarPorTipoAtividade(String tipoAtividadeUuid) async {
    final query = select(tipoAtividadeTable).join([
      innerJoin(
        aprTable,
        aprTable.tipoAtividadeId.equalsExp(tipoAtividadeTable.uuid),
      )
    ])
      ..where(tipoAtividadeTable.uuid.equals(tipoAtividadeUuid));

    final row = await query.getSingleOrNull();
    if (row == null) {
      throw Exception(
          'Não encontrado APR para TipoAtividade $tipoAtividadeUuid');
    }

    return row.readTable(aprTable);
  }

  // === PERGUNTAS E RELACIONAMENTOS ===

  /// Sincroniza perguntas da APR com a API
  Future<void> sincronizarPerguntas(
      List<AprQuestionTableCompanion> entradas) async {
    AppLogger.d('🔄 Sincronizando ${entradas.length} perguntas APR',
        tag: 'AprDao');
    await batch((batch) {
      batch.update(
        aprQuestionTable,
        const AprQuestionTableCompanion(sincronizado: Value(false)),
      );
      batch.insertAllOnConflictUpdate(
        aprQuestionTable,
        entradas
            .map((e) => e.copyWith(sincronizado: const Value(true)))
            .toList(),
      );
    });
    final apagados = await (delete(aprQuestionTable)
          ..where((tbl) => tbl.sincronizado.equals(false)))
        .go();
    AppLogger.d('🧹 Removidos $apagados perguntas', tag: 'AprDao');
  }

  /// Sincroniza relacionamentos pergunta <-> APR
  Future<void> sincronizarRelacionamentos(
      List<AprPerguntaRelacionamentoTableCompanion> entradas) async {
    AppLogger.d('🔄 Sincronizando ${entradas.length} relações de perguntas',
        tag: 'AprDao');
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
          ..where((tbl) => tbl.sincronizado.equals(false)))
        .go();
    AppLogger.d('🧹 Removidos $apagados relações de perguntas', tag: 'AprDao');
  }

  /// Busca perguntas de um modelo de APR ordenadas por ordem
  Future<List<AprQuestionTableData>> buscarPerguntasPorApr(
      String aprUuid) async {
    final query = select(aprQuestionTable).join([
      innerJoin(
        aprPerguntaRelacionamentoTable,
        aprPerguntaRelacionamentoTable.perguntaId
            .equalsExp(aprQuestionTable.uuid),
      )
    ])
      ..where(aprPerguntaRelacionamentoTable.aprId.equals(aprUuid))
      ..orderBy([OrderingTerm.asc(aprPerguntaRelacionamentoTable.ordem)]);

    final result = await query.get();
    return result.map((row) => row.readTable(aprQuestionTable)).toList();
  }

  // === APR PREENCHIDA ===

  /// Insere um registro de APR preenchida
  Future<int> inserirAprPreenchida(AprPreenchidaTableCompanion entry) async {
    AppLogger.d('💾 Salvando AprPreenchida: $entry', tag: 'AprDao');
    return into(aprPreenchidaTable).insert(entry);
  }

  /// Verifica se já existe APR preenchida para a atividade
  Future<bool> existePreenchida(String atividadeUuid) async {
    final result = await (selectOnly(aprPreenchidaTable)
          ..addColumns([aprPreenchidaTable.id])
          ..where(aprPreenchidaTable.atividadeId.equals(atividadeUuid)))
        .get();
    return result.isNotEmpty;
  }

  /// Busca todas APRs preenchidas para uma atividade
  Future<List<AprPreenchidaTableData>> buscarPreenchidasPorAtividade(
      String atividadeUuid) async {
    final result = await (select(aprPreenchidaTable)
          ..where((t) => t.atividadeId.equals(atividadeUuid)))
        .get();
    AppLogger.d(
        '📄 Listou ${result.length} APRs preenchidas da atividade $atividadeUuid',
        tag: 'AprDao');
    return result;
  }

  /// Atualiza a data de preenchimento de uma APR
  Future<void> atualizarDataPreenchimento(
      int id, DateTime dataPreenchimento) async {
    await (update(aprPreenchidaTable)..where((t) => t.id.equals(id)))
        .write(AprPreenchidaTableCompanion(
      dataPreenchimento: Value(dataPreenchimento),
    ));
  }

  // === RESPOSTAS ===

  /// Salva todas as respostas da APR preenchida
  Future<void> salvarRespostas(
      List<AprRespostaTableCompanion> respostas) async {
    AppLogger.d('💾 Salvando ${respostas.length} respostas de APR',
        tag: 'AprDao');
    await batch((batch) {
      batch.insertAllOnConflictUpdate(aprRespostaTable, respostas);
    });
  }

  /// Busca todas as respostas de uma APR preenchida
  Future<List<AprRespostaTableData>> buscarRespostas(
      int aprPreenchidaId) async {
    final result = await (select(aprRespostaTable)
          ..where((t) => t.aprPreenchidaId.equals(aprPreenchidaId)))
        .get();
    AppLogger.d(
        '📄 Listou ${result.length} respostas da aprPreenchidaId=$aprPreenchidaId',
        tag: 'AprDao');
    return result;
  }

  // === ASSINATURAS ===

  /// Insere uma nova assinatura
  Future<void> salvarAssinatura(AprAssinaturaTableCompanion entry) async {
    AppLogger.d('✍️ Salvando Assinatura: $entry', tag: 'AprDao');
    await into(aprAssinaturaTable).insert(entry);
  }

  /// Conta o total de assinaturas de uma APR preenchida
  Future<int> contarAssinaturas(int aprPreenchidaId) async {
    final query = selectOnly(aprAssinaturaTable)
      ..addColumns([aprAssinaturaTable.id.count()])
      ..where(aprAssinaturaTable.aprPreenchidaId.equals(aprPreenchidaId));

    final result = await query.getSingle();
    return result.read(aprAssinaturaTable.id.count()) ?? 0;
  }

  /// Lista as assinaturas vinculadas a uma APR preenchida
  Future<List<AprAssinaturaTableData>> buscarAssinaturas(
      int aprPreenchidaId) async {
    final result = await (select(aprAssinaturaTable)
          ..where((t) => t.aprPreenchidaId.equals(aprPreenchidaId)))
        .get();
    return result;
  }

  /// Remove todas as assinaturas de uma APR preenchida
  Future<void> deletarAssinaturasDaApr(int aprPreenchidaId) async {
    AppLogger.w('🗑️ Deletando assinaturas da aprPreenchidaId=$aprPreenchidaId',
        tag: 'AprDao');
    await (delete(aprAssinaturaTable)
          ..where((t) => t.aprPreenchidaId.equals(aprPreenchidaId)))
        .go();
  }

  // === UTILITÁRIOS DE LIMPEZA ===

  Future<void> deletarTudo() async {
    AppLogger.w(
        '🧨 Limpando todos os dados de APR (modelo, preenchimentos, etc.)',
        tag: 'AprDao');
    await batch((batch) {
      delete(aprRespostaTable).go();
      delete(aprAssinaturaTable).go();
      delete(aprPreenchidaTable).go();
      delete(aprPerguntaRelacionamentoTable).go();
      delete(aprQuestionTable).go();
      delete(aprTable).go();
    });
  }

  deletarAprPreenchida(int aprPreenchidaId) {}
}
