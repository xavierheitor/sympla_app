import 'package:drift/drift.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/tables/schema.dart';

part 'mpbb_dao.g.dart';

/// DAO responsável pelas operações do módulo de banco de baterias (MPBB).
@DriftAccessor(tables: [FormularioMpbbTable, MedicaoElementoMpbbTable])
class MpbbDao extends DatabaseAccessor<AppDatabase> with _$MpbbDaoMixin {
  MpbbDao(super.db);

  /// 💾 Insere ou atualiza um formulário de banco de baterias.
  Future<void> salvarFormulario(FormularioMpbbTableCompanion data) async {
    AppLogger.d('💾 Salvando formulário MPBB: $data', tag: 'MpbbDao');
    await into(formularioMpbbTable).insertOnConflictUpdate(data);
  }

  /// 🔍 Busca formulário por ID.
  Future<FormularioMpbbTableData?> buscarFormularioPorId(int id) {
    return (select(formularioMpbbTable)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  /// 🔍 Busca formulários vinculados à atividade.
  Future<List<FormularioMpbbTableData>> buscarFormularioPorAtividade(
      String atividadeId) {
    return (select(formularioMpbbTable)
          ..where((t) => t.atividadeId.equals(atividadeId)))
        .get();
  }

  /// 🗑️ Apaga formulário por ID.
  Future<void> deletarFormularioPorId(int id) async {
    await (delete(formularioMpbbTable)..where((t) => t.id.equals(id))).go();
  }

  /// 🗑️ Apaga formulários vinculados à atividade.
  Future<void> deletarFormularioPorAtividade(String atividadeId) async {
    await (delete(formularioMpbbTable)
          ..where((t) => t.atividadeId.equals(atividadeId)))
        .go();
  }

  /// 💾 Salva todas as medições de elementos de bateria.
  Future<void> salvarMedicoes(
      List<MedicaoElementoMpbbTableCompanion> lista) async {
    AppLogger.d('💾 Salvando ${lista.length} medições MPBB', tag: 'MpbbDao');
    await batch((b) {
      b.insertAll(medicaoElementoMpbbTable, lista);
    });
  }

  /// 🔍 Busca medições vinculadas a um formulário.
  Future<List<MedicaoElementoMpbbTableData>> buscarMedicoesPorFormulario(
      int formularioId) {
    return (select(medicaoElementoMpbbTable)
          ..where((t) => t.formularioMpbbId.equals(formularioId)))
        .get();
  }

  /// 🗑️ Deleta medições por formulário.
  Future<void> deletarMedicoesPorFormulario(int formularioId) async {
    await (delete(medicaoElementoMpbbTable)
          ..where((t) => t.formularioMpbbId.equals(formularioId)))
        .go();
  }

  /// 🗑️ Remove todos os dados (formulários + medições).
  Future<void> deletarTudo() async {
    AppLogger.w('🗑️ Apagando todos dados MPBB', tag: 'MpbbDao');
    await transaction(() async {
      await delete(medicaoElementoMpbbTable).go();
      await delete(formularioMpbbTable).go();
    });
  }

  /// 🔍 Verifica se há formulários salvos no banco.
  Future<bool> estaVazio() async {
    final countQuery = selectOnly(formularioMpbbTable)
      ..addColumns([formularioMpbbTable.id.count()]);
    final result = await countQuery.getSingle();
    return (result.read(formularioMpbbTable.id.count()) ?? 0) == 0;
  }

  Future<int> salvarFormularioRetornandoId(
      FormularioMpbbTableCompanion data) async {
    AppLogger.d('💾 Salvando formulário MPBB (retornando ID): $data',
        tag: 'MpbbDao');
    return await into(formularioMpbbTable).insert(data);
  }
}
