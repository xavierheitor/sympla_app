import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/domain/repositories/atividade/atividade_repository.dart';

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
}
