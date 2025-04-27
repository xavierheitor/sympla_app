import 'package:drift/drift.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/converters/status_atividade_converter.dart';
import 'package:sympla_app/core/storage/tables/atividade_table.dart';
import 'package:sympla_app/data/models/atividade_model.dart';

part 'generated/atividade_dao.g.dart';

@DriftAccessor(tables: [AtividadeTable])
class AtividadeDao extends DatabaseAccessor<AppDatabase>
    with _$AtividadeDaoMixin {
  AtividadeDao(super.db);

  Future<void> inserirOuAtualizar(AtividadeTableCompanion data) async {
    AppLogger.d('🔄 Inserindo/Atualizando Atividade: ${data.toString()}',
        tag: 'AtividadeDAO');
    await into(atividadeTable).insertOnConflictUpdate(data);
  }

  Future<List<AtividadeTableData>> buscarTodas() async {
    final result = await select(atividadeTable).get();
    AppLogger.d('📄 Listou ${result.length} atividades', tag: 'AtividadeDAO');
    return result;
  }

  Future<void> sincronizarComApi(
      List<AtividadeTableCompanion> atividadesApi) async {
    AppLogger.d(
        '🔄 Iniciando sincronização de ${atividadesApi.length} atividades',
        tag: 'AtividadeDAO');

    await batch((batch) {
      // Marcar todas como não sincronizadas
      batch.update(
        atividadeTable,
        const AtividadeTableCompanion(sincronizado: Value(false)),
      );

      // Inserir ou atualizar todas as que vieram da API com sincronizado = true
      batch.insertAllOnConflictUpdate(
        atividadeTable,
        atividadesApi
            .map((e) => e.copyWith(sincronizado: const Value(true)))
            .toList(),
      );
    });

    // Deletar as que não foram sincronizadas
    final apagadas = await (delete(atividadeTable)
          ..where((tbl) => tbl.sincronizado.equals(false)))
        .go();
    AppLogger.d('🧹 Removidas $apagadas atividades obsoletas',
        tag: 'AtividadeDAO');
  }

  Future<void> deletarTudo() async {
    AppLogger.w('🗑️ Apagando todas as atividades do banco',
        tag: 'AtividadeDAO');
    await delete(atividadeTable).go();
  }

  Future<bool> estaVazio() async {
    final result = await select(atividadeTable).get();
    return result.isEmpty;
  }

  Future<List<AtividadeModel>> buscarComEquipamento() async {
    final query = select(atividadeTable).join([
      innerJoin(
        equipamentoTable,
        equipamentoTable.id.equalsExp(atividadeTable.equipamentoId),
      ),
    ]);

    final results =
        await query.get(); // <-- Espera trazer todos os dados primeiro

    return results.map((row) {
      final atividade = row.readTable(atividadeTable);
      final equipamento = row.readTable(equipamentoTable);

      return AtividadeModel.fromJoin(
        atividade: atividade,
        equipamento: equipamento,
      );
    }).toList(); // <-- transforma a lista de objetos mapeados em uma lista final
  }

  Future<AtividadeModel?> buscarEmAndamento() async {
    final query = select(atividadeTable).join([
      innerJoin(
        equipamentoTable,
        equipamentoTable.id.equalsExp(atividadeTable.equipamentoId),
      ),
    ])
      ..where(atividadeTable.status.equals(StatusAtividade.emAndamento.name));

    final row = await query.getSingleOrNull();

    if (row == null) {
      return null;
    }

    final atividade = row.readTable(atividadeTable);
    final equipamento = row.readTable(equipamentoTable);

    return AtividadeModel.fromJoin(
      atividade: atividade,
      equipamento: equipamento,
    );
  }

  Future<void> iniciarAtividade(AtividadeModel atividade) async {
    await (update(atividadeTable)..where((tbl) => tbl.id.equals(atividade.id)))
        .write(
      AtividadeTableCompanion(
        status: const Value(StatusAtividade.emAndamento),
        dataInicio: Value(DateTime.now()),
      ),
    );
  }
}
