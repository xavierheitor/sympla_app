import 'package:drift/drift.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/tables/tipo_atividade_table.dart';

part 'tipo_atividade_dao.g.dart';

@DriftAccessor(tables: [TipoAtividadeTable])
class TipoAtividadeDao extends DatabaseAccessor<AppDatabase>
    with _$TipoAtividadeDaoMixin {
  TipoAtividadeDao(super.db);

  Future<void> inserirOuAtualizar(TipoAtividadeTableCompanion data) async {
    AppLogger.d('Inserindo/Atualizando TipoAtividade: ${data.toString()}',
        tag: 'TipoAtividadeDAO');

    await into(tipoAtividadeTable).insertOnConflictUpdate(data);
  }

  Future<List<TipoAtividadeTableData>> buscarTodos() async {
    final result = await select(tipoAtividadeTable).get();

    AppLogger.d('Listou ${result.length} TipoAtividades',
        tag: 'TipoAtividadeDAO');
    return result;
  }

  Future<void> deletarTudo() async {
    AppLogger.w('Deletando todas as TipoAtividades', tag: 'TipoAtividadeDAO');
    await delete(tipoAtividadeTable).go();
  }
}
