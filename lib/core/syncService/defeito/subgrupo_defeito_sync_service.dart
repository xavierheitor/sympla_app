import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/domain/repositories/subgrupo_defeito_repository.dart';

class SubgrupoDefeitoSyncService {
  final SubgrupoDefeitoRepository repository;

  SubgrupoDefeitoSyncService(this.repository);

  Future<void> sincronizar() async {
    AppLogger.i('🔄 Sincronizando Subgrupos de Defeito...',
        tag: 'SubgrupoDefeitoSync');

    try {
      final lista = await repository.buscarDaApi();
      await repository.salvarNoBanco(lista);

      AppLogger.i('✅ Subgrupos de Defeito sincronizados com sucesso',
          tag: 'SubgrupoDefeitoSync');
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[subgrupo_defeito_sync_service - sincronizar] ${erro.mensagem}',
          tag: 'SubgrupoDefeitoSync',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }

  Future<bool> estaVazio() async {
    return await repository.estaVazio();
  }
}
