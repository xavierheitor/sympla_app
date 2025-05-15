import 'package:drift/drift.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/converters/status_atividade_converter.dart';
import 'package:sympla_app/core/storage/tables/schema.dart';

part 'atividade_dao.g.dart';

@DriftAccessor(tables: [AtividadeTable, TipoAtividadeTable, EquipamentoTable])
class AtividadeDao extends DatabaseAccessor<AppDatabase>
    with _$AtividadeDaoMixin {
  AtividadeDao(super.db);

  // ===== ATIVIDADES =====

  /// Insere ou atualiza uma atividade no banco local.
  Future<void> salvarAtividade(AtividadeTableCompanion data) async {
    AppLogger.d('🔄 Salvando Atividade: $data', tag: 'AtividadeDAO');
    await into(atividadeTable).insertOnConflictUpdate(data);
  }

  /// Busca todas as atividades da tabela.
  Future<List<AtividadeTableData>> buscarTodasAtividades() async {
    final result = await select(atividadeTable).get();
    AppLogger.d('📄 Listou ${result.length} atividades', tag: 'AtividadeDAO');
    return result;
  }

  /// Deleta todas as atividades do banco local.
  Future<void> deletarTodasAtividades() async {
    AppLogger.w('🗑️ Apagando todas as atividades', tag: 'AtividadeDAO');
    await delete(atividadeTable).go();
  }

  /// Verifica se a tabela de atividades está vazia.
  Future<bool> estaVazioAtividade() async {
    final count = await (selectOnly(atividadeTable)
          ..addColumns([atividadeTable.id.count()]))
        .map((row) => row.read(atividadeTable.id.count()))
        .getSingle();
    return (count ?? 0) == 0;
  }

  /// Sincroniza atividades com a API, mantendo atividades não pendentes locais intactas.
  Future<void> sincronizarAtividadesComApi(
      List<AtividadeTableCompanion> atividadesApi) async {
    AppLogger.d('🔄 Sincronizando ${atividadesApi.length} atividades',
        tag: 'AtividadeDAO');

    // Marcar como não sincronizado apenas as pendentes
    await (update(atividadeTable)
          ..where((tbl) => tbl.status.equals('pendente')))
        .write(const AtividadeTableCompanion(sincronizado: Value(false)));

    final pendentesDaApi = atividadesApi
        .where((e) => e.status.value == StatusAtividade.pendente)
        .map((e) => e.copyWith(sincronizado: const Value(true)))
        .toList();

    // Atualiza ou insere somente se status local for pendente ou não existir
    for (final nova in pendentesDaApi) {
      final existente = await (select(atividadeTable)
            ..where((tbl) => tbl.id.equals(nova.id.value)))
          .getSingleOrNull();

      if (existente == null || existente.status == StatusAtividade.pendente) {
        await into(atividadeTable).insertOnConflictUpdate(nova);
        AppLogger.d('✅ Atividade ${nova.id.value} salva', tag: 'AtividadeDAO');
      } else {
        AppLogger.w(
            '⛔ Ignorando ${nova.id.value} (status atual: ${existente.status})',
            tag: 'AtividadeDAO');
      }
    }

    // Remove pendentes que não foram sincronizadas novamente
    final removidas = await (delete(atividadeTable)
          ..where((tbl) =>
              tbl.sincronizado.equals(false) & tbl.status.equals('pendente')))
        .go();

    AppLogger.d('🧹 Removidas $removidas atividades pendentes obsoletas',
        tag: 'AtividadeDAO');
  }

  /// Retorna a atividade que estiver em andamento, com o equipamento e tipo relacionados.
  Future<AtividadeTableData?> buscarEmAndamento() async {
    final query = select(atividadeTable).join([
      innerJoin(
        equipamentoTable,
        equipamentoTable.uuid.equalsExp(atividadeTable.equipamentoId),
      ),
      innerJoin(
        tipoAtividadeTable,
        tipoAtividadeTable.uuid.equalsExp(atividadeTable.tipoAtividadeId),
      ),
    ])
      ..where(atividadeTable.status.equals(StatusAtividade.emAndamento.name));

    final row = await query.getSingleOrNull();
    if (row == null) return null;

    return row.readTable(atividadeTable);
  }

  /// Busca todas as atividades com os dados do equipamento e tipo associados.
  Future<List<AtividadeTableData>> buscarComEquipamento() async {
    final query = select(atividadeTable).join([
      innerJoin(
        equipamentoTable,
        equipamentoTable.uuid.equalsExp(atividadeTable.equipamentoId),
      ),
      innerJoin(
        tipoAtividadeTable,
        tipoAtividadeTable.uuid.equalsExp(atividadeTable.tipoAtividadeId),
      ),
    ]);
    final rows = await query.get();
    return rows.map((row) => row.readTable(atividadeTable)).toList();
  }

  /// Busca uma atividade específica pelo ID com os dados do equipamento e tipo.
  Future<AtividadeTableData?> buscarAtividadePorId(String id) async {
    final query = select(atividadeTable).join([
      innerJoin(
        equipamentoTable,
        equipamentoTable.uuid.equalsExp(atividadeTable.equipamentoId),
      ),
      innerJoin(
        tipoAtividadeTable,
        tipoAtividadeTable.uuid.equalsExp(atividadeTable.tipoAtividadeId),
      ),
    ])
      ..where(atividadeTable.uuid.equals(id));

    final row = await query.getSingleOrNull();
    if (row == null) return null;

    return row.readTable(atividadeTable);
  }

  /// Marca uma atividade como "em andamento" e registra a data de início.
  Future<void> iniciarAtividade(AtividadeTableCompanion atividade) async {
    await (update(atividadeTable)
          ..where((tbl) => tbl.uuid.equals(atividade.uuid.value)))
        .write(
      AtividadeTableCompanion(
        status: const Value(StatusAtividade.emAndamento),
        dataInicio: Value(DateTime.now()),
      ),
    );
  }

  /// Marca uma atividade como "concluída" e registra a data de fim.
  Future<void> finalizarAtividade(AtividadeTableCompanion atividade) async {
    await (update(atividadeTable)
          ..where((tbl) => tbl.uuid.equals(atividade.uuid.value)))
        .write(
      AtividadeTableCompanion(
        status: const Value(StatusAtividade.concluido),
        dataFim: Value(DateTime.now()),
      ),
    );
  }

  // ===== TIPO DE ATIVIDADE =====

  /// Insere ou atualiza um tipo de atividade no banco local.
  Future<void> salvarTipoAtividade(TipoAtividadeTableCompanion data) async {
    AppLogger.d('💾 Salvando TipoAtividade: $data', tag: 'TipoAtividadeDAO');
    await into(tipoAtividadeTable).insertOnConflictUpdate(data);
  }

  /// Lista todos os tipos de atividade armazenados.
  Future<List<TipoAtividadeTableData>> buscarTodosTiposAtividade() async {
    final result = await select(tipoAtividadeTable).get();
    AppLogger.d('📄 Listou ${result.length} Tipos de Atividade',
        tag: 'TipoAtividadeDAO');
    return result;
  }

  /// Deleta todos os tipos de atividade do banco local.
  Future<void> deletarTodosTiposAtividade() async {
    AppLogger.w('🗑️ Deletando todos os Tipos de Atividade',
        tag: 'TipoAtividadeDAO');
    await delete(tipoAtividadeTable).go();
  }

  /// Sincroniza os tipos de atividade com a API, removendo os obsoletos.
  Future<void> sincronizarTiposAtividadeComApi(
      List<TipoAtividadeTableCompanion> tiposApi) async {
    AppLogger.d('🔄 Sincronizando ${tiposApi.length} tipos de atividade',
        tag: 'TipoAtividadeDAO');

    await batch((batch) {
      batch.update(
        tipoAtividadeTable,
        const TipoAtividadeTableCompanion(sincronizado: Value(false)),
      );
      batch.insertAllOnConflictUpdate(
        tipoAtividadeTable,
        tiposApi
            .map((e) => e.copyWith(sincronizado: const Value(true)))
            .toList(),
      );
    });

    final removidos = await (delete(tipoAtividadeTable)
          ..where((tbl) => tbl.sincronizado.equals(false)))
        .go();

    AppLogger.d('🧹 Removidos $removidos tipos obsoletos',
        tag: 'TipoAtividadeDAO');
  }

  /// Verifica se a tabela de tipos de atividade está vazia.
  Future<bool> estaVazioTipoAtividade() async {
    final count = await (selectOnly(tipoAtividadeTable)
          ..addColumns([tipoAtividadeTable.id.count()]))
        .map((row) => row.read(tipoAtividadeTable.id.count()))
        .getSingle();
    return (count ?? 0) == 0;
  }

  /// Busca um tipo de atividade pelo ID da atividasde
  Future<TipoAtividadeTableData> buscarTipoAtividadePorId(
      String atividadeId) async {
    final query = (select(atividadeTable)
          ..where((a) => a.uuid.equals(atividadeId)))
        .join([
      innerJoin(tipoAtividadeTable,
          tipoAtividadeTable.uuid.equalsExp(atividadeTable.tipoAtividadeId)),
    ]);

    final result = await query.getSingleOrNull();

    if (result == null) {
      throw Exception(
          'Tipo de atividade para atividade $atividadeId não encontrado.');
    }

    return result.readTable(tipoAtividadeTable);
  }
}
