import 'package:drift/drift.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/tables/apr_resposta_table.dart';

part 'generated/apr_resposta_dao.g.dart';

@DriftAccessor(tables: [AprRespostaTable])
class AprRespostaDao extends DatabaseAccessor<AppDatabase>
    with _$AprRespostaDaoMixin {
  AprRespostaDao(super.db);

  Future<void> inserirOuAtualizar(AprRespostaTableCompanion entry) async {
    AppLogger.d('💾 Salvando Resposta APR: ${entry.toString()}',
        tag: 'AprRespostaDao');
    await into(aprRespostaTable).insertOnConflictUpdate(entry);
  }

  Future<List<AprRespostaTableData>> buscarPorAprPreenchida(
      int aprPreenchidaId) async {
    final result = await (select(aprRespostaTable)
          ..where((t) => t.aprPreenchidaId.equals(aprPreenchidaId)))
        .get();
    AppLogger.d(
        '📄 Listou ${result.length} respostas da aprPreenchidaId=$aprPreenchidaId',
        tag: 'AprRespostaDao');
    return result;
  }

  Future<void> deletarTudo() async {
    AppLogger.w('🗑️ Deletando todas respostas APR', tag: 'AprRespostaDao');
    await delete(aprRespostaTable).go();
  }

  Future<bool> estaVazio() async {
    final result = await select(aprRespostaTable).get();
    return result.isEmpty;
  }
}
