// mpdj_dao.dart
import 'package:drift/drift.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/tables/schema.dart';
part 'mpdj_dao.g.dart';

@DriftAccessor(tables: [
  PrevDisjForm,
  MedicaoPressaoSf6Table,
  MedicaoResistenciaContatoTable,
  MedicaoResistenciaIsolamentoTable,
  MedicaoTempoOperacaoTable,
])
class MpdjDao extends DatabaseAccessor<AppDatabase> with _$MpdjDaoMixin {
  MpdjDao(super.db);

  /// Salva o formulario principal (cria ou atualiza)
  Future<int> salvarFormulario(PrevDisjFormCompanion entry) async {
    final existente = await (select(prevDisjForm)
          ..where((t) => t.atividadeId.equals(entry.atividadeId.value)))
        .getSingleOrNull();

    if (existente != null) {
      await (update(prevDisjForm)..where((t) => t.id.equals(existente.id)))
          .write(entry.copyWith(id: Value(existente.id)));
      AppLogger.d('🔁 Atualizou formulário MPDJ existente', tag: 'MpdjDao');
      return existente.id;
    } else {
      final id = await into(prevDisjForm).insert(entry);
      AppLogger.d('🆕 Inseriu novo formulário MPDJ', tag: 'MpdjDao');
      return id;
    }
  }

  /// Retorna o formulário pelo ID da atividade
  Future<PrevDisjFormData?> buscarFormularioPorAtividade(String atividadeUuid) {
    return (select(prevDisjForm)
          ..where((t) => t.atividadeId.equals(atividadeUuid)))
        .getSingleOrNull();
  }

  /// Insere todas as medições de pressão SF6
  Future<void> salvarMedicoesSf6(
      List<MedicaoPressaoSf6TableCompanion> lista) async {
    await batch((b) {
      b.insertAll(medicaoPressaoSf6Table, lista);
    });
  }

  /// Insere todas as medições de resistência de contato
  Future<void> salvarMedicoesContato(
      List<MedicaoResistenciaContatoTableCompanion> lista) async {
    await batch((b) {
      b.insertAll(medicaoResistenciaContatoTable, lista);
    });
  }

  /// Insere todas as medições de resistência de isolamento
  Future<void> salvarMedicoesIsolamento(
      List<MedicaoResistenciaIsolamentoTableCompanion> lista) async {
    await batch((b) {
      b.insertAll(medicaoResistenciaIsolamentoTable, lista);
    });
  }

  /// Insere todas as medições de tempo de operação
  Future<void> salvarMedicoesTempo(
      List<MedicaoTempoOperacaoTableCompanion> lista) async {
    await batch((b) {
      b.insertAll(medicaoTempoOperacaoTable, lista);
    });
  }

  /// Busca medições por formulário
  Future<List<MedicaoPressaoSf6TableData>> buscarSf6(int formularioId) =>
      (select(medicaoPressaoSf6Table)
            ..where((t) => t.formularioDisjuntorId.equals(formularioId)))
          .get();

  Future<List<MedicaoResistenciaContatoTableData>> buscarContato(
          int formularioId) =>
      (select(medicaoResistenciaContatoTable)
            ..where((t) => t.formularioDisjuntorId.equals(formularioId)))
          .get();

  Future<List<MedicaoResistenciaIsolamentoTableData>> buscarIsolamento(
          int formularioId) =>
      (select(medicaoResistenciaIsolamentoTable)
            ..where((t) => t.formularioDisjuntorId.equals(formularioId)))
          .get();

  Future<List<MedicaoTempoOperacaoTableData>> buscarTempo(int formularioId) =>
      (select(medicaoTempoOperacaoTable)
            ..where((t) => t.formularioDisjuntorId.equals(formularioId)))
          .get();

  /// Deleta todas as medições por formulário
  Future<void> deletarMedicoesPorFormulario(int formularioId) async {
    await batch((b) {
      b.deleteWhere(medicaoPressaoSf6Table,
          (t) => t.formularioDisjuntorId.equals(formularioId));
      b.deleteWhere(medicaoResistenciaContatoTable,
          (t) => t.formularioDisjuntorId.equals(formularioId));
      b.deleteWhere(medicaoResistenciaIsolamentoTable,
          (t) => t.formularioDisjuntorId.equals(formularioId));
      b.deleteWhere(medicaoTempoOperacaoTable,
          (t) => t.formularioDisjuntorId.equals(formularioId));
    });
    AppLogger.w('🧹 Apagou todas as medições do formulário $formularioId',
        tag: 'MpdjDao');
  }

  /// Remove tudo do banco
  Future<void> deletarTudo() async {
    AppLogger.w('🧹 Limpando todas tabelas do MPDJ', tag: 'MpdjDao');
    await batch((b) {
      b.deleteAll(prevDisjForm);
      b.deleteAll(medicaoPressaoSf6Table);
      b.deleteAll(medicaoResistenciaContatoTable);
      b.deleteAll(medicaoResistenciaIsolamentoTable);
      b.deleteAll(medicaoTempoOperacaoTable);
    });
  }

  /// Verifica se a tabela do formulário está vazia
  Future<bool> estaVazio() async {
    final count = await (selectOnly(prevDisjForm)
          ..addColumns([prevDisjForm.id.count()]))
        .getSingle();
    return (count.read(prevDisjForm.id.count()) ?? 0) == 0;
  }
}
