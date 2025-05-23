import 'package:sympla_app/core/domain/dto/anomalia/anomalia_table_dto.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/anomalia_repository.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/anomalia_dao.dart';

class AnomaliaRepositoryImpl implements AnomaliaRepository {
  final AppDatabase db;
  final AnomaliaDao anomaliaDao;

  AnomaliaRepositoryImpl(this.db) : anomaliaDao = db.anomaliaDao;

  @override
  Future<void> salvarAnomalias(List<AnomaliaTableDto> anomalias) async {
    try {
      final lista = anomalias.map((e) => e.toCompanion()).toList();
      await anomaliaDao.inserirAnomaliasEmLote(lista);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AnomaliaRepositoryImpl - salvarAnomalias] ${erro.mensagem}',
          error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<void> deleteById(int id) async {
    try {
      await anomaliaDao.deleteById(id);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AnomaliaRepositoryImpl - deleteById] ${erro.mensagem}',
          error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<void> salvarAnomalia(AnomaliaTableDto anomalia) async {
    try {
      await anomaliaDao.inserirOuAtualizar(anomalia.toCompanion());
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AnomaliaRepositoryImpl - salvarAnomalia] ${erro.mensagem}',
          error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<void> deletarAnomalias(List<AnomaliaTableDto> anomalias) async {
    try {
      final lista = anomalias.map((e) => e.toCompanion()).toList();
      await anomaliaDao.deletarAnomalias(lista);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[AnomaliaRepositoryImpl - deletarAnomalias] ${erro.mensagem}',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<List<AnomaliaTableDto>> buscarAnomaliasPorAtividade(
      String atividadeId) async {
    try {
      final rows = await anomaliaDao.buscarComIncludesPorAtividade(atividadeId);
      return rows.map((row) {
        final anomalia = row.readTable(db.anomaliaTable);
        final equipamento = row.readTable(db.equipamentoTable);
        final defeito = row.readTable(db.defeitoTable);
        return AnomaliaTableDto.fromJoin(
          anomalia: anomalia,
          equipamento: equipamento,
          defeito: defeito,
        );
      }).toList();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[AnomaliaRepositoryImpl - buscarAnomaliasPorAtividade] ${erro.mensagem}',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }
}
