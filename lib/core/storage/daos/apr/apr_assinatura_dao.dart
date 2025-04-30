import 'package:drift/drift.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/tables/apr_assinatura_table.dart';

part 'apr_assinatura_dao.g.dart';

@DriftAccessor(tables: [AprAssinaturaTable])
class AprAssinaturaDao extends DatabaseAccessor<AppDatabase>
    with _$AprAssinaturaDaoMixin {
  AprAssinaturaDao(super.db);

  Future<void> inserir(AprAssinaturaTableCompanion entry) async {
    AppLogger.d('✍️ Salvando Assinatura: ${entry.toString()}',
        tag: 'AprAssinaturaDao');
    await into(aprAssinaturaTable).insert(entry);
  }

  Future<List<AprAssinaturaTableData>> buscarPorAprPreenchida(
      int aprPreenchidaId) async {
    final result = await (select(aprAssinaturaTable)
          ..where((t) => t.aprPreenchidaId.equals(aprPreenchidaId)))
        .get();
    AppLogger.d(
        '📄 Listou ${result.length} assinaturas da aprPreenchidaId=$aprPreenchidaId',
        tag: 'AprAssinaturaDao');
    return result;
  }

  Future<int> contarPorAprPreenchida(int aprPreenchidaId) async {
    final query = selectOnly(aprAssinaturaTable)
      ..addColumns([aprAssinaturaTable.id.count()])
      ..where(aprAssinaturaTable.aprPreenchidaId.equals(aprPreenchidaId));

    final result = await query.getSingle();
    final count = result.read(aprAssinaturaTable.id.count()) ?? 0;

    AppLogger.d(
        '🔢 Contou $count assinaturas da aprPreenchidaId=$aprPreenchidaId',
        tag: 'AprAssinaturaDao');
    return count;
  }

  Future<void> deletarTudo() async {
    AppLogger.w('🗑️ Deletando todas Assinaturas', tag: 'AprAssinaturaDao');
    await delete(aprAssinaturaTable).go();
  }

  Future<void> deletarPorAprPreenchida(int aprPreenchidaId) async {
    AppLogger.w('🗑️ Deletando assinaturas da aprPreenchidaId=$aprPreenchidaId',
        tag: 'AprAssinaturaDao');
    await (delete(aprAssinaturaTable)
          ..where((t) => t.aprPreenchidaId.equals(aprPreenchidaId)))
        .go();
  }
}
