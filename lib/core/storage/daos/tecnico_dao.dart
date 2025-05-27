import 'package:drift/drift.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/tables/schema.dart';

part 'tecnico_dao.g.dart';

@DriftAccessor(tables: [TecnicoTable])
class TecnicoDao extends DatabaseAccessor<AppDatabase> with _$TecnicoDaoMixin {
  TecnicoDao(super.db);

  /// Insere ou atualiza um técnico no banco local.
  Future<void> salvar(TecnicoTableCompanion tecnico) async {
    AppLogger.d('💾 Salvando Técnico: $tecnico', tag: 'TecnicosDao');
    await into(tecnicoTable).insertOnConflictUpdate(tecnico);
  }

  /// Retorna todos os técnicos armazenados.
  Future<List<TecnicoTableData>> buscarTodos() async {
    final result = await select(tecnicoTable).get();
    AppLogger.d('📄 Listou ${result.length} Técnicos', tag: 'TecnicosDao');
    return result;
  }

  /// Remove todos os técnicos armazenados localmente.
  Future<void> deletarTodos() async {
    AppLogger.w('🗑️ Deletando todos os Técnicos', tag: 'TecnicosDao');
    await delete(tecnicoTable).go();
  }

  /// Verifica se a tabela de técnicos está vazia.
  Future<bool> estaVazio() async {
    final count = await (selectOnly(tecnicoTable)
          ..addColumns([tecnicoTable.id.count()]))
        .map((row) => row.read(tecnicoTable.id.count()))
        .getSingle();
    return (count ?? 0) == 0;
  }

  /// Sincroniza a lista de técnicos com os dados da API.
  ///
  /// - Marca todos os técnicos como `sincronizado = false`.
  /// - Insere/atualiza os técnicos recebidos, marcando `sincronizado = true`.
  /// - Remove os técnicos que não vieram da API.
  Future<void> sincronizarComApi(List<TecnicoTableCompanion> tecnicos) async {
    AppLogger.d('🔄 Iniciando sincronização de ${tecnicos.length} Técnicos',
        tag: 'TecnicosDao');

    // 1. Resetar sincronização
    await batch((batch) {
      batch.update(
        tecnicoTable,
        const TecnicoTableCompanion(sincronizado: Value(false)),
      );
    });

    // 2. Inserir atualizados da API com sincronizado = true
    await batch((batch) {
      final atualizados = tecnicos
          .map((e) => e.copyWith(sincronizado: const Value(true)))
          .toList();
      batch.insertAllOnConflictUpdate(tecnicoTable, atualizados);
    });

    // 3. Remover técnicos que não vieram na resposta da API
    final apagados = await (delete(tecnicoTable)
          ..where((tbl) => tbl.sincronizado.equals(false)))
        .go();

    AppLogger.d('🧹 Removidos $apagados Técnicos obsoletos', tag: 'TecnicoDao');
  }

  Future<TecnicoTableData?> buscarPorId(String tecnicoId) async {
    final result = await (select(tecnicoTable)
          ..where((tbl) => tbl.uuid.equals(tecnicoId)))
        .getSingleOrNull();
    return result;
  }
}
