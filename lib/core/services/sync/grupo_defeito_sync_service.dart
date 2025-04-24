import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/domain/repositories/grupo_defeito_repository.dart';

class GrupoDefeitoSyncService {
  final GrupoDefeitoRepository repository;

  GrupoDefeitoSyncService(this.repository);

  Future<void> sincronizar() async {
    AppLogger.i('🔄 Sincronizando Grupos de Defeito...',
        tag: 'GrupoDefeitoSync');

    try {
      final lista = await repository.buscarDaApi();
      await repository.salvarNoBanco(lista);

      AppLogger.i('✅ Grupos de Defeito sincronizados com sucesso',
          tag: 'GrupoDefeitoSync');
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[grupo_defeito_sync_service - sincronizar] ${erro.mensagem}',
          tag: 'GrupoDefeitoSync', error: e, stackTrace: s);
      rethrow;
    }
  }
}
