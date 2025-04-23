import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/domain/repositories/equipamento_repository.dart';

class EquipamentoSyncService {
  final EquipamentoRepository repository;

  EquipamentoSyncService(this.repository);

  Future<void> sincronizar() async {
    AppLogger.i('🔄 Sincronizando Equipamentos...', tag: 'EquipamentoSync');

    try {
      final lista = await repository.buscarDaApi();
      await repository.salvarNoBanco(lista);

      AppLogger.i('✅ Equipamentos sincronizados com sucesso',
          tag: 'EquipamentoSync');
    } catch (e, s) {
      AppLogger.e('Erro ao sincronizar Equipamentos',
          tag: 'EquipamentoSync', error: e, stackTrace: s);
    }
  }
}
