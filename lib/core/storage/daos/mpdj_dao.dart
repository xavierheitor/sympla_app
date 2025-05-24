import 'package:drift/drift.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/tables/schema.dart';

part 'mpdj_dao.g.dart';

@DriftAccessor(tables: [
  MpDjFormTable,
  MpDjPressaoSf6Table,
  MpDjResistenciaContatoTable,
  MpDjResistenciaIsolamentoTable,
  MpDjTempoOperacaoTable,
])
class MpdjDao extends DatabaseAccessor<AppDatabase> with _$MpdjDaoMixin {
  MpdjDao(super.db);

  // =============================================================================
  // 🗂️ FORMULÁRIO
  // =============================================================================

  /// 💾 Insere ou atualiza o formulário MPDJ e retorna o ID gerado.
  Future<int> salvarFormulario(MpDjFormTableCompanion data) async {
    AppLogger.d('💾 Salvando formulário MPDJ: $data', tag: 'MpdjDao');

    final existente = await (select(mpDjFormTable)
          ..where((t) => t.atividadeId.equals(data.atividadeId.value)))
        .getSingleOrNull();

    if (existente != null) {
      await (update(mpDjFormTable)..where((t) => t.id.equals(existente.id)))
          .write(data.copyWith(id: Value(existente.id)));

      AppLogger.d('🔁 Atualizou formulário MPDJ existente ID=${existente.id}',
          tag: 'MpdjDao');
      return existente.id;
    } else {
      final id = await into(mpDjFormTable).insert(data);
      AppLogger.d('🆕 Inseriu novo formulário MPDJ ID=$id', tag: 'MpdjDao');
      return id;
    }
  }

  /// 🔍 Busca formulário pelo UUID da atividade
  Future<MpDjFormTableData?> buscarFormularioPorAtividade(
      String atividadeUuid) {
    return (select(mpDjFormTable)
          ..where((t) => t.atividadeId.equals(atividadeUuid)))
        .getSingleOrNull();
  }

  // =============================================================================
  // 🔍 MÉTODOS PARA BUSCAR MEDIÇÕES
  // =============================================================================

  Future<List<MpDjPressaoSf6TableData>> buscarSf6(int formularioId) {
    return (select(mpDjPressaoSf6Table)
          ..where((t) => t.mpDjFormId.equals(formularioId)))
        .get();
  }

  Future<List<MpDjResistenciaContatoTableData>> buscarContato(
      int formularioId) {
    return (select(mpDjResistenciaContatoTable)
          ..where((t) => t.mpDjFormId.equals(formularioId)))
        .get();
  }

  Future<List<MpDjResistenciaIsolamentoTableData>> buscarIsolamento(
      int formularioId) {
    return (select(mpDjResistenciaIsolamentoTable)
          ..where((t) => t.mpDjFormId.equals(formularioId)))
        .get();
  }

  Future<List<MpDjTempoOperacaoTableData>> buscarTempo(int formularioId) {
    return (select(mpDjTempoOperacaoTable)
          ..where((t) => t.mpDjFormId.equals(formularioId)))
        .get();
  }

  // =============================================================================
  // 💾 MÉTODOS PARA SALVAR MEDIÇÕES
  // =============================================================================

  Future<void> salvarMedicoesSf6(
      List<MpDjPressaoSf6TableCompanion> lista) async {
    AppLogger.d('💾 Salvando ${lista.length} medições de Pressão SF6',
        tag: 'MpdjDao');
    await batch((b) {
      b.insertAll(mpDjPressaoSf6Table, lista);
    });
  }

  Future<void> salvarMedicoesContato(
      List<MpDjResistenciaContatoTableCompanion> lista) async {
    AppLogger.d('💾 Salvando ${lista.length} medições de Resistência Contato',
        tag: 'MpdjDao');
    await batch((b) {
      b.insertAll(mpDjResistenciaContatoTable, lista);
    });
  }

  Future<void> salvarMedicoesIsolamento(
      List<MpDjResistenciaIsolamentoTableCompanion> lista) async {
    AppLogger.d('💾 Salvando ${lista.length} medições de Isolamento',
        tag: 'MpdjDao');
    await batch((b) {
      b.insertAll(mpDjResistenciaIsolamentoTable, lista);
    });
  }

  Future<void> salvarMedicoesTempo(
      List<MpDjTempoOperacaoTableCompanion> lista) async {
    AppLogger.d('💾 Salvando ${lista.length} medições de Tempo de Operação',
        tag: 'MpdjDao');
    await batch((b) {
      b.insertAll(mpDjTempoOperacaoTable, lista);
    });
  }

  // =============================================================================
  // 🗑️ MÉTODOS PARA DELETAR
  // =============================================================================

  /// 🔥 Deleta todas as medições vinculadas ao formulário
  Future<void> deletarMedicoesPorFormulario(int formularioId) async {
    AppLogger.w('🧹 Deletando medições do formulário $formularioId',
        tag: 'MpdjDao');

    await batch((b) {
      b.deleteWhere(
          mpDjPressaoSf6Table, (t) => t.mpDjFormId.equals(formularioId));
      b.deleteWhere(mpDjResistenciaContatoTable,
          (t) => t.mpDjFormId.equals(formularioId));
      b.deleteWhere(mpDjResistenciaIsolamentoTable,
          (t) => t.mpDjFormId.equals(formularioId));
      b.deleteWhere(
          mpDjTempoOperacaoTable, (t) => t.mpDjFormId.equals(formularioId));
    });
  }

  /// 🔥 Deleta o formulário e suas medições
  Future<void> deletarFormulario(int formularioId) async {
    AppLogger.w('🗑️ Deletando formulário $formularioId', tag: 'MpdjDao');
    await transaction(() async {
      await deletarMedicoesPorFormulario(formularioId);
      await (delete(mpDjFormTable)..where((t) => t.id.equals(formularioId)))
          .go();
    });
  }

  /// 🔥 Remove tudo do banco relacionado a MPDJ
  Future<void> deletarTudo() async {
    AppLogger.w('🗑️ Limpando todas tabelas do MPDJ', tag: 'MpdjDao');
    await batch((b) {
      b.deleteAll(mpDjFormTable);
      b.deleteAll(mpDjPressaoSf6Table);
      b.deleteAll(mpDjResistenciaContatoTable);
      b.deleteAll(mpDjResistenciaIsolamentoTable);
      b.deleteAll(mpDjTempoOperacaoTable);
    });
  }

  /// 🔍 Verifica se o formulário está vazio
  Future<bool> estaVazio() async {
    final count = await (selectOnly(mpDjFormTable)
          ..addColumns([mpDjFormTable.id.count()]))
        .getSingle();
    final qtd = count.read(mpDjFormTable.id.count()) ?? 0;
    AppLogger.d('📊 Quantidade de formulários MPDJ no banco: $qtd',
        tag: 'MpdjDao');
    return qtd == 0;
  }
}
