import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/domain/repositories/tipo_atividade_repository.dart';

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
      AppLogger.e('Erro ao sincronizar Tipos de Atividade',
          tag: 'TipoAtividadeSync', error: e, stackTrace: s);
    }
  }
}
