import 'package:drift/drift.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/tables/apr_preenchida_table.dart';

part 'generated/apr_preenchida_dao.g.dart';

@DriftAccessor(tables: [AprPreenchidaTable])
class AprPreenchidaDao extends DatabaseAccessor<AppDatabase>
    with _$AprPreenchidaDaoMixin {
  AprPreenchidaDao(super.db);

  Future<int> inserir(AprPreenchidaTableCompanion entry) async {
    AppLogger.d('💾 Salvando AprPreenchida: ${entry.toString()}',
        tag: 'AprPreenchidaDao');
    return into(aprPreenchidaTable).insert(entry);
  }

  Future<List<AprPreenchidaTableData>> buscarPorAtividade(
      int atividadeId) async {
    final result = await (select(aprPreenchidaTable)
          ..where((t) => t.atividadeId.equals(atividadeId)))
        .get();
    AppLogger.d(
        '📄 Listou ${result.length} APR Preenchidas da atividade $atividadeId',
        tag: 'AprPreenchidaDao');
    return result;
  }

  Future<bool> existeAprPreenchidaParaAtividade(int atividadeId) async {
    final query = selectOnly(aprPreenchidaTable)
      ..addColumns([aprPreenchidaTable.id])
      ..where(aprPreenchidaTable.atividadeId.equals(atividadeId));
    final result = await query.get();
    return result.isNotEmpty;
  }

  Future<void> deletarTudo() async {
    AppLogger.w('🗑️ Deletando todas AprPreenchida', tag: 'AprPreenchidaDao');
    await delete(aprPreenchidaTable).go();
  }
}
