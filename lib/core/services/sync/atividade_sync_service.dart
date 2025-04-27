import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/data/models/atividade_model.dart';
import 'package:sympla_app/domain/repositories/atividade_repository.dart';

class AtividadeSyncService {
  final AtividadeRepository repository;

  AtividadeSyncService(this.repository);

  Future<void> sincronizar() async {
    AppLogger.i('🔄 Sincronizando Atividades...', tag: 'AtividadeSync');

    try {
      final lista = await repository.buscarDaApi();
      await repository.salvarNoBanco(lista);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AtividadeSyncService - sincronizar] ${erro.mensagem}',
          tag: 'AtividadeSync', error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<bool> estaVazio() async {
    try {
      return await repository.estaVazio();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AtividadeSyncService - estaVazio] ${erro.mensagem}',
          tag: 'AtividadeSync', error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<List<AtividadeTableData>> buscarTodas() async {
    try {
      return await repository.buscarTodas();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AtividadeSyncService - buscarTodas] ${erro.mensagem}',
          tag: 'AtividadeSync', error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<List<AtividadeModel>> buscarComEquipamento() async {
    try {
      return await repository.buscarComEquipamento();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[AtividadeSyncService - buscarComEquipamento] ${erro.mensagem}',
          tag: 'AtividadeSync',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }
}
