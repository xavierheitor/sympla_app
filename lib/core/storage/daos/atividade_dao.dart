import 'package:drift/drift.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/converters/status_atividade_converter.dart';
import 'package:sympla_app/core/storage/tables/schema.dart';

part 'atividade_dao.g.dart';

@DriftAccessor(tables: [AtividadeTable, TipoAtividadeTable, EquipamentoTable])
class AtividadeDao extends DatabaseAccessor<AppDatabase> with _$AtividadeDaoMixin {
  AtividadeDao(super.db);

  // ===== ATIVIDADES =====

  /// Insere ou atualiza uma atividade no banco local.
  Future<void> salvarAtividade(AtividadeTableCompanion data) async {
    AppLogger.d('🔄 Salvando Atividade: $data', tag: 'AtividadeDAO');

    // Verifica se a atividade já existe pelo UUID
    final existente = await (select(atividadeTable)
          ..where((tbl) => tbl.uuid.equals(data.uuid.value)))
        .getSingleOrNull();

    if (existente != null) {
      // Atualiza atividade existente
      AppLogger.d('♻️ Atualizando atividade existente: ${data.uuid.value}', tag: 'AtividadeDAO');
      await (update(atividadeTable)..where((tbl) => tbl.uuid.equals(data.uuid.value))).write(data);
    } else {
      // Insere nova atividade
      AppLogger.d('➕ Inserindo nova atividade: ${data.uuid.value}', tag: 'AtividadeDAO');
      await into(atividadeTable).insert(data);
    }
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
    final count = await (selectOnly(atividadeTable)..addColumns([atividadeTable.id.count()]))
        .map((row) => row.read(atividadeTable.id.count()))
        .getSingle();
    return (count ?? 0) == 0;
  }

  /// Sincroniza atividades com a API.
  /// ✅ Mantém atividades locais que não são pendentes intactas.
  /// ✅ Insere ou atualiza somente pendentes.
  /// ✅ Remove pendentes locais que não vieram mais da API.
  Future<void> sincronizarAtividadesComApi(List<AtividadeTableCompanion> atividadesApi) async {
    AppLogger.d('🔄 Sincronizando ${atividadesApi.length} atividades', tag: 'AtividadeDAO');

    await transaction(() async {
      await (update(atividadeTable)
            ..where((tbl) => tbl.status.equals(StatusAtividade.pendente.name)))
          .write(const AtividadeTableCompanion(sincronizado: Value(false)));

      for (final nova in atividadesApi) {
        final uuid = nova.uuid.value;

        if (uuid.isEmpty) {
          AppLogger.e('❌ Atividade sem UUID válido, ignorando.', tag: 'AtividadeDAO');
          continue;
        }

        final existentes =
            await (select(atividadeTable)..where((tbl) => tbl.uuid.equals(uuid))).get();

        final statusNova = nova.status.value;

        final isPendente = statusNova == StatusAtividade.pendente;

        if (existentes.isEmpty) {
          if (isPendente) {
            AppLogger.d('➕ Inserindo nova atividade pendente $uuid', tag: 'AtividadeDAO');
            await into(atividadeTable).insert(nova.copyWith(sincronizado: const Value(true)));
          } else {
            AppLogger.w('⚠️ Atividade $uuid não foi inserida (status API: $statusNova)',
                tag: 'AtividadeDAO');
          }
        } else {
          final existente = existentes.first;

          if (existente.status == StatusAtividade.pendente) {
            AppLogger.d('♻️ Atualizando atividade pendente $uuid', tag: 'AtividadeDAO');
            await into(atividadeTable)
                .insertOnConflictUpdate(nova.copyWith(sincronizado: const Value(true)));
          } else {
            AppLogger.w(
              '⛔ Ignorando $uuid (status local: ${existente.status})',
              tag: 'AtividadeDAO',
            );
          }
        }
      }

      final removidas = await (delete(atividadeTable)
            ..where((tbl) =>
                tbl.sincronizado.equals(false) & tbl.status.equals(StatusAtividade.pendente.name)))
          .go();

      AppLogger.d('🧹 Removidas $removidas atividades pendentes obsoletas', tag: 'AtividadeDAO');
    });
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
  Future<List<TypedResult>> buscarComEquipamento() async {
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
    return query.get(); // ← Retorna TypedResult com as 3 tabelas
  }

  /// Busca atividades por status específico
  Future<List<AtividadeTableData>> buscarPorStatus(StatusAtividade status) async {
    final query = select(atividadeTable)..where((tbl) => tbl.status.equals(status.name));

    final result = await query.get();
    AppLogger.d('📄 Encontradas ${result.length} atividades com status ${status.name}',
        tag: 'AtividadeDAO');
    return result;
  }

  /// Busca atividades por múltiplos status
  Future<List<AtividadeTableData>> buscarPorStatuses(List<StatusAtividade> statuses) async {
    if (statuses.isEmpty) {
      AppLogger.w('⚠️ Lista de status vazia, retornando lista vazia', tag: 'AtividadeDAO');
      return [];
    }

    final query = select(atividadeTable);

    if (statuses.length == 1) {
      query.where((tbl) => tbl.status.equals(statuses.first.name));
    } else {
      // Para múltiplos status, usar whereIn
      final statusNames = statuses.map((s) => s.name).toList();
      query.where((tbl) => tbl.status.isIn(statusNames));
    }

    final result = await query.get();
    AppLogger.d(
        '📄 Encontradas ${result.length} atividades com status: ${statuses.map((s) => s.name).join(', ')}',
        tag: 'AtividadeDAO');
    return result;
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
    await (update(atividadeTable)..where((tbl) => tbl.uuid.equals(atividade.uuid.value))).write(
      AtividadeTableCompanion(
        status: const Value(StatusAtividade.emAndamento),
        dataInicio: Value(DateTime.now()),
      ),
    );
  }

  /// Marca uma atividade como "concluída" e registra a data de fim.
  Future<void> finalizarAtividade(AtividadeTableCompanion atividade) async {
    await (update(atividadeTable)..where((tbl) => tbl.uuid.equals(atividade.uuid.value))).write(
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
    AppLogger.d('📄 Listou ${result.length} Tipos de Atividade', tag: 'TipoAtividadeDAO');
    return result;
  }

  /// Deleta todos os tipos de atividade do banco local.
  Future<void> deletarTodosTiposAtividade() async {
    AppLogger.w('🗑️ Deletando todos os Tipos de Atividade', tag: 'TipoAtividadeDAO');
    await delete(tipoAtividadeTable).go();
  }

  /// Sincroniza os tipos de atividade com a API, removendo os obsoletos.
  Future<void> sincronizarTiposAtividadeComApi(List<TipoAtividadeTableCompanion> tiposApi) async {
    AppLogger.d('🔄 Sincronizando ${tiposApi.length} tipos de atividade', tag: 'TipoAtividadeDAO');

    await batch((batch) {
      batch.update(
        tipoAtividadeTable,
        const TipoAtividadeTableCompanion(sincronizado: Value(false)),
      );
      batch.insertAllOnConflictUpdate(
        tipoAtividadeTable,
        tiposApi.map((e) => e.copyWith(sincronizado: const Value(true))).toList(),
      );
    });

    final removidos =
        await (delete(tipoAtividadeTable)..where((tbl) => tbl.sincronizado.equals(false))).go();

    AppLogger.d('🧹 Removidos $removidos tipos obsoletos', tag: 'TipoAtividadeDAO');
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
  Future<TipoAtividadeTableData> buscarTipoAtividadePorId(String atividadeId) async {
    final query = (select(atividadeTable)..where((a) => a.uuid.equals(atividadeId))).join([
      innerJoin(
          tipoAtividadeTable, tipoAtividadeTable.uuid.equalsExp(atividadeTable.tipoAtividadeId)),
    ]);

    final result = await query.getSingleOrNull();

    if (result == null) {
      throw Exception('Tipo de atividade para atividade $atividadeId não encontrado.');
    }

    return result.readTable(tipoAtividadeTable);
  }
}
