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
      AppLogger.e('Erro ao sincronizar Grupos de Defeito',
          tag: 'GrupoDefeitoSync', error: e, stackTrace: s);
    }
  }
}
