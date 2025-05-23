import 'package:drift/drift.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/tables/schema.dart';
part 'generated/equipamento_dao.g.dart';

@DriftAccessor(tables: [EquipamentoTable])
class EquipamentoDao extends DatabaseAccessor<AppDatabase>
    with _$EquipamentoDaoMixin {
  EquipamentoDao(super.db);

  /// Insere ou atualiza um equipamento com base na chave primária
  Future<void> inserirOuAtualizar(EquipamentoTableCompanion data) async {
    AppLogger.d('🔄 Inserindo/Atualizando Equipamento: \$data',
        tag: 'EquipamentoDao');
    await into(equipamentoTable).insertOnConflictUpdate(data);
  }

  /// Busca todos os equipamentos cadastrados
  Future<List<EquipamentoTableData>> buscarTodos() async {
    final result = await select(equipamentoTable).get();
    AppLogger.d('📄 Listou \${result.length} equipamentos',
        tag: 'EquipamentoDao');
    return result;
  }

  /// Busca equipamentos pela subestação informada
  Future<List<EquipamentoTableData>> buscarPorSubestacao(
      String subestacao) async {
    return await (select(equipamentoTable)
          ..where((tbl) => tbl.subestacao.equals(subestacao)))
        .get();
  }

  /// Verifica se a tabela está vazia
  Future<bool> estaVazioEquipamento() async {
    final result = await select(equipamentoTable).get();
    return result.isEmpty;
  }

  /// Apaga todos os registros da tabela
  Future<void> deletarTudo() async {
    AppLogger.w('🗑️ Apagando todos os equipamentos do banco',
        tag: 'EquipamentoDao');
    await delete(equipamentoTable).go();
  }

  /// Sincroniza os equipamentos com a API:
  /// - Marca todos como nao sincronizados
  /// - Insere ou atualiza os novos
  /// - Remove os não reenviados
  Future<void> sincronizarComApi(
      List<EquipamentoTableCompanion> equipamentosApi) async {
    AppLogger.d(
        '🔄 Iniciando sincronização de \${equipamentosApi.length} equipamentos',
        tag: 'EquipamentoDao');

    await batch((batch) {
      batch.update(
        equipamentoTable,
        const EquipamentoTableCompanion(sincronizado: Value(false)),
      );

      batch.insertAllOnConflictUpdate(
        equipamentoTable,
        equipamentosApi
            .map((e) => e.copyWith(sincronizado: const Value(true)))
            .toList(),
      );
    });

    final apagados = await (delete(equipamentoTable)
          ..where((tbl) => tbl.sincronizado.equals(false)))
        .go();

    AppLogger.d('🧹 Removidos $apagados equipamentos obsoletos',
        tag: 'EquipamentoDao');
  }

  /// Busca um equipamento pelo UUID
  Future<EquipamentoTableData?> buscarPorUuid(String uuid) async {
    return await (select(equipamentoTable)
          ..where((tbl) => tbl.uuid.equals(uuid)))
        .getSingleOrNull();
  }

/// 🔥 Deleta um equipamento com base no UUID
  Future<void> deletarPorUuid(String uuid) async {
    AppLogger.d('[EquipamentoDao] 🗑️ Deletando equipamento com UUID: $uuid');

    final deletados = await (delete(equipamentoTable)
          ..where((tbl) => tbl.uuid.equals(uuid)))
        .go();

    AppLogger.d(
        '[EquipamentoDao] 🗑️ Total de registros deletados: $deletados (UUID: $uuid)');
  }
}
