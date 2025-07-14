import 'package:drift/drift.dart';
import 'package:sympla_app/core/domain/dto/checklist/checklist_preenchido_table_dto.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/tables/schema.dart';

part 'checklist_dao.g.dart';

/// DAO unificado para Checklist, incluindo modelo, perguntas, relacionamentos e respostas.
@DriftAccessor(tables: [
  ChecklistTable,
  ChecklistPerguntaTable,
  ChecklistPerguntaRelacionamentoTable,
  ChecklistRespostaTable,
  TipoAtividadeTable,
  ChecklistTipoAtividadeTable,
])
class ChecklistDao extends DatabaseAccessor<AppDatabase>
    with _$ChecklistDaoMixin {
  ChecklistDao(super.db);

  /// Sincroniza modelos de checklist vindos da API
  Future<void> sincronizarModelos(List<ChecklistTableCompanion> items) async {
    AppLogger.d('Sincronizando ${items.length} modelos de checklist',
        tag: 'ChecklistDao');
    await batch((batch) {
      batch.update(
        checklistTable,
        const ChecklistTableCompanion(sincronizado: Value(false)),
      );
      batch.insertAllOnConflictUpdate(
        checklistTable,
        items.map((e) => e.copyWith(sincronizado: const Value(true))).toList(),
      );
    });
    final removidos = await (delete(checklistTable)
          ..where((t) => t.sincronizado.equals(false)))
        .go();
    AppLogger.d('Removidos $removidos modelos de checklist obsoletos',
        tag: 'ChecklistDao');
  }

  /// Sincroniza perguntas vindas da API
  Future<void> sincronizarPerguntas(
      List<ChecklistPerguntaTableCompanion> items) async {
    AppLogger.d('Sincronizando ${items.length} perguntas de checklist',
        tag: 'ChecklistDao');
    await batch((batch) {
      batch.update(
        checklistPerguntaTable,
        const ChecklistPerguntaTableCompanion(sincronizado: Value(false)),
      );
      batch.insertAllOnConflictUpdate(
        checklistPerguntaTable,
        items.map((e) => e.copyWith(sincronizado: const Value(true))).toList(),
      );
    });
    final removidos = await (delete(checklistPerguntaTable)
          ..where((t) => t.sincronizado.equals(false)))
        .go();
    AppLogger.d('Removidas $removidos perguntas obsoletas',
        tag: 'ChecklistDao');
  }

  /// Sincroniza relacionamentos entre perguntas e modelos
  Future<void> sincronizarRelacionamentos(
      List<ChecklistPerguntaRelacionamentoTableCompanion> items) async {
    AppLogger.d('Sincronizando ${items.length} relacionamentos de perguntas',
        tag: 'ChecklistDao');
    await batch((batch) {
      batch.update(
        checklistPerguntaRelacionamentoTable,
        const ChecklistPerguntaRelacionamentoTableCompanion(
            sincronizado: Value(false)),
      );
      batch.insertAllOnConflictUpdate(
        checklistPerguntaRelacionamentoTable,
        items.map((e) => e.copyWith(sincronizado: const Value(true))).toList(),
      );
    });
    final removidos = await (delete(checklistPerguntaRelacionamentoTable)
          ..where((t) => t.sincronizado.equals(false)))
        .go();
    AppLogger.d('Removidos $removidos relacionamentos obsoletos',
        tag: 'ChecklistDao');
  }

  /// Busca checklist associado a um tipo de atividade
  Future<ChecklistTableData> buscarPorTipoAtividade(
      String tipoAtividadeId) async {
    AppLogger.d(
        '🔍 Buscando Checklist vinculado ao tipo de atividade $tipoAtividadeId');

    // Passo 1: buscar relacionamentos na tabela intermediária
    final relacionamentos = await (select(checklistTipoAtividadeTable)
          ..where((tbl) => tbl.tipoAtividadeId.equals(tipoAtividadeId)))
        .get();

    if (relacionamentos.isEmpty) {
      AppLogger.w('⚠️ Nenhum checklist relacionado ao tipo $tipoAtividadeId');
      throw Exception(
          'Nenhum checklist encontrado para tipo de atividade $tipoAtividadeId');
    }

    // Pega o primeiro checklistId encontrado
    final checklistId = relacionamentos.first.checklistId;

    // Passo 2: buscar o checklist na tabela principal
    final checklist = await (select(checklistTable)
          ..where((tbl) => tbl.uuid.equals(checklistId)))
        .getSingleOrNull();

    if (checklist == null) {
      AppLogger.e('❌ Checklist com id $checklistId não encontrado');
      throw Exception('Checklist com id $checklistId não encontrado');
    }

    AppLogger.d(
        '✅ Checklist ${checklist.uuid} encontrado para tipo $tipoAtividadeId');
    return checklist;
  }

  /// Busca perguntas associadas a um checklist
  Future<List<ChecklistPerguntaTableData>> buscarPerguntasPorChecklist(
      String checklistUuid) async {
    final relacoes = await (select(checklistPerguntaRelacionamentoTable)
          ..where((tbl) => tbl.checklistId.equals(checklistUuid)))
        .get();
    final perguntaIds = relacoes.map((e) => e.perguntaId).toList();
    return (select(checklistPerguntaTable)
          ..where((tbl) => tbl.uuid.isIn(perguntaIds)))
        .get();
  }

  /// Salva respostas preenchidas de checklist
  Future<void> salvarRespostas(
      List<ChecklistRespostaTableCompanion> respostas) async {
    AppLogger.d('Salvando ${respostas.length} respostas de checklist',
        tag: 'ChecklistDao');
    await batch((batch) {
      batch.insertAllOnConflictUpdate(checklistRespostaTable, respostas);
    });
  }

  /// Busca respostas da atividade (por checklist preenchido)
  Future<List<ChecklistRespostaTableData>> buscarRespostasPorPreenchido(
      int checklistPreenchidoId) {
    return (select(checklistRespostaTable)
          ..where(
              (tbl) => tbl.checklistPreenchidoId.equals(checklistPreenchidoId)))
        .get();
  }

  /// Remove todas as respostas de um checklist preenchido específico
  Future<void> deletarRespostasPorPreenchido(int checklistPreenchidoId) async {
    await (delete(checklistRespostaTable)
          ..where(
              (tbl) => tbl.checklistPreenchidoId.equals(checklistPreenchidoId)))
        .go();
  }

  /// Verifica se já existe resposta para uma pergunta em um preenchimento
  Future<bool> existeResposta(
      int checklistPreenchidoId, String perguntaId) async {
    final count = await (select(checklistRespostaTable)
          ..where((tbl) =>
              tbl.checklistPreenchidoId.equals(checklistPreenchidoId) &
              tbl.perguntaId.equals(perguntaId)))
        .get();
    return count.isNotEmpty;
  }

  Future<bool> estaVazioChecklistPerguntaRelacionamento() async {
    final count = await select(checklistPerguntaRelacionamentoTable).get();
    return count.isEmpty;
  }

  Future<bool> estaVazioChecklistPergunta() async {
    final count = await select(checklistPerguntaTable).get();
    return count.isEmpty;
  }

  Future<bool> estaVazioChecklist() async {
    final count = await select(checklistTable).get();
    return count.isEmpty;
  }

  Future<void> atualizarDataPreenchimento(
      int checklistPreenchidoId, DateTime data) async {
    await (update(checklistPreenchidoTable)
          ..where((tbl) => tbl.id.equals(checklistPreenchidoId)))
        .write(
      ChecklistPreenchidoTableCompanion(dataPreenchimento: Value(data)),
    );
  }

  Future<ChecklistPreenchidoTableData?> buscarPorAtividade(
      String atividadeId) async {
    final query = select(checklistPreenchidoTable).join([
      innerJoin(
        atividadeTable,
        atividadeTable.uuid.equalsExp(checklistPreenchidoTable.atividadeId),
      ),
    ])
      ..where(checklistPreenchidoTable.atividadeId.equals(atividadeId));

    final result = await query.getSingleOrNull();
    return result?.readTable(checklistPreenchidoTable);
  }

  Future<int> criarChecklistPreenchido(
      ChecklistPreenchidoTableDto checklist) async {
    final id =
        await into(checklistPreenchidoTable).insert(checklist.toCompanion());
    AppLogger.d('Checklist preenchido criado com ID: $id', tag: 'ChecklistDao');
    return id;
  }

  Future<void> deletarChecklistPreenchido(int checklistPreenchidoId) async {
    final deletados = await (delete(checklistPreenchidoTable)
          ..where((tbl) => tbl.id.equals(checklistPreenchidoId)))
        .go();
    AppLogger.d(
        'Checklist preenchido deletado (ID: $checklistPreenchidoId, registros: $deletados)',
        tag: 'ChecklistDao');
  }

  //** === CHECKLIST TIPO ATIVIDADE === */

  Future<void> salvarChecklistTipoAtividade(
      ChecklistTipoAtividadeTableCompanion entry) async {
    AppLogger.d('💾 Salvando ChecklistTipoAtividade: $entry',
        tag: 'ChecklistDao');
    await into(checklistTipoAtividadeTable).insert(entry);
  }

  Future<void> sincronizarChecklistTipoAtividade(
      List<ChecklistTipoAtividadeTableCompanion> entradas) async {
    AppLogger.d(
        '🔄 Sincronizando ${entradas.length} tipos de atividade Checklist',
        tag: 'ChecklistDao');
    await batch((batch) {
      batch.update(
          checklistTipoAtividadeTable,
          const ChecklistTipoAtividadeTableCompanion(
              sincronizado: Value(false)));
      batch.insertAllOnConflictUpdate(checklistTipoAtividadeTable, entradas);
    });
  }

  Future<bool> estaVazioChecklistTipoAtividade() async {
    final query = selectOnly(checklistTipoAtividadeTable)
      ..addColumns([checklistTipoAtividadeTable.id.count()]);
    final row = await query.getSingle();
    return row.read(checklistTipoAtividadeTable.id.count()) == 0;
  }

  Future<void> deletarChecklistTipoAtividade(
      int checklistTipoAtividadeId) async {
    final deletados = await (delete(checklistTipoAtividadeTable)
          ..where((tbl) => tbl.id.equals(checklistTipoAtividadeId)))
        .go();
    AppLogger.d(
        'ChecklistTipoAtividade deletado (ID: $checklistTipoAtividadeId, registros: $deletados)',
        tag: 'ChecklistDao');
  }
}
