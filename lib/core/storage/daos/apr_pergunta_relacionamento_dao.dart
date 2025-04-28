import 'package:drift/drift.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/tables/apr_pergunta_relacionamento_table.dart';

part 'apr_pergunta_relacionamento_dao.g.dart';

@DriftAccessor(tables: [AprPerguntaRelacionamentoTable])
class AprPerguntaRelacionamentoDao extends DatabaseAccessor<AppDatabase>
    with _$AprPerguntaRelacionamentoDaoMixin {
  AprPerguntaRelacionamentoDao(super.db);

  Future<void> sincronizarComApi(
      List<AprPerguntaRelacionamentoTableCompanion> entradas) async {
    AppLogger.d('🔄 Sincronizando ${entradas.length} relações de perguntas',
        tag: 'AprPerguntaRelacionamentoDao');
    await batch((batch) {
      // Atualiza corretamente na tabela relacionamento
      batch.deleteWhere(
          aprPerguntaRelacionamentoTable,
          (tbl) =>
              const Constant(true)); // Opcional: limpa tudo antes se quiser
      batch.insertAllOnConflictUpdate(
        aprPerguntaRelacionamentoTable,
        entradas,
      );
    });
  }
}
