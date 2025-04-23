import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/domain/repositories/subgrupo_defeito_repository.dart';

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
      AppLogger.e('Erro ao sincronizar Subgrupos de Defeito',
          tag: 'SubgrupoDefeitoSync', error: e, stackTrace: s);
    }
  }
}
