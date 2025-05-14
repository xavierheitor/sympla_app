import 'package:drift/drift.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/tables/schema.dart';

part 'mpbb_ddao.g.dart';

/// DAO responsável pelas operações do módulo de banco de baterias (MPBB).
@DriftAccessor(tables: [FormularioBateriaTable, MedicaoElementoBateriaTable])
class MpbbDao extends DatabaseAccessor<AppDatabase> with _$MpbbDaoMixin {
  MpbbDao(super.db);

  /// Insere ou atualiza um formulário de banco de baterias.
  Future<void> salvarFormulario(FormularioBateriaTableCompanion data) async {
    AppLogger.d('💾 Salvando formulário MPBB: $data', tag: 'MpbbDao');
    await into(formularioBateriaTable).insertOnConflictUpdate(data);
  }

  /// Busca formulário por ID.
  Future<FormularioBateriaTableData?> buscarFormularioPorId(int id) {
    return (select(formularioBateriaTable)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  /// Busca formulários vinculados à atividade (UUID).
  Future<List<FormularioBateriaTableData>> buscarFormularioPorAtividade(
      String atividadeId) {
    return (select(formularioBateriaTable)
          ..where((t) => t.atividadeId.equals(atividadeId)))
        .get();
  }

  /// Apaga formulário por ID.
  Future<void> deletarFormularioPorId(int id) async {
    await (delete(formularioBateriaTable)..where((t) => t.id.equals(id))).go();
  }

  /// Apaga formulários vinculados à atividade.
  Future<void> deletarFormularioPorAtividade(String atividadeId) async {
    await (delete(formularioBateriaTable)
          ..where((t) => t.atividadeId.equals(atividadeId)))
        .go();
  }

  /// Salva todas as medições de elementos de bateria.
  Future<void> salvarMedicoes(
      List<MedicaoElementoBateriaTableCompanion> lista) async {
    AppLogger.d('💾 Salvando ${lista.length} medições MPBB', tag: 'MpbbDao');
    await batch((b) {
      b.insertAll(medicaoElementoBateriaTable, lista);
    });
  }

  /// Busca medições vinculadas a um formulário.
  Future<List<MedicaoElementoBateriaTableData>> buscarMedicoesPorFormulario(
      int formularioId) {
    return (select(medicaoElementoBateriaTable)
          ..where((t) => t.formularioBateriaId.equals(formularioId)))
        .get();
  }

  /// Deleta medições por formulário.
  Future<void> deletarMedicoesPorFormulario(int formularioId) async {
    await (delete(medicaoElementoBateriaTable)
          ..where((t) => t.formularioBateriaId.equals(formularioId)))
        .go();
  }

  /// Remove todos os dados (formulários + medições).
  Future<void> deletarTudo() async {
    AppLogger.w('🗑️ Apagando todos dados MPBB', tag: 'MpbbDao');
    await transaction(() async {
      await delete(medicaoElementoBateriaTable).go();
      await delete(formularioBateriaTable).go();
    });
  }

  /// Verifica se há formulários salvos no banco.
  Future<bool> estaVazio() async {
    final countQuery = selectOnly(formularioBateriaTable)
      ..addColumns([formularioBateriaTable.id.count()]);
    final result = await countQuery.getSingle();
    return (result.read(formularioBateriaTable.id.count()) ?? 0) == 0;
  }
}
