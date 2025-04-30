import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/domain/repositories/atividade/tipo_atividade_repository.dart';

class TipoAtividadeSyncService {
  final TipoAtividadeRepository repository;

  TipoAtividadeSyncService(this.repository);

  Future<void> sincronizar() async {
    AppLogger.i('🔄 Sincronizando Tipos de Atividade...',
        tag: 'TipoAtividadeSync');

    try {
      final lista = await repository.buscarDaApi();
      await repository.salvarNoBanco(lista);

      AppLogger.i('✅ Tipos de Atividade sincronizados com sucesso',
          tag: 'TipoAtividadeSync');
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[tipo_atividade_sync_service - sincronizar] ${erro.mensagem}',
          tag: 'TipoAtividadeSync',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }

  Future<bool> estaVazio() async {
    return await repository.estaVazio();
  }
}
