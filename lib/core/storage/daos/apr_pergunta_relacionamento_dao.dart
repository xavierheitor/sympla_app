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
      batch.update(
        aprPerguntaRelacionamentoTable,
        const AprPerguntaRelacionamentoTableCompanion(
            sincronizado: Value(false)),
      );
      batch.insertAllOnConflictUpdate(
        aprPerguntaRelacionamentoTable,
        entradas
            .map((e) => e.copyWith(sincronizado: const Value(true)))
            .toList(),
      );
    });
    final apagados = await (delete(aprPerguntaRelacionamentoTable)
          ..where((tbl) => tbl.sincronizado.equals(false)))
        .go();
    AppLogger.d('🧹 Removidos $apagados relações de perguntas',
        tag: 'AprPerguntaRelacionamentoDao');
  }
}
