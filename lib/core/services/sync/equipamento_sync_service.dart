import 'package:sympla_app/core/errors/error_handler.dart';
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
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[equipamento_sync_service - sincronizar] ${erro.mensagem}',
          tag: 'EquipamentoSync', error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<bool> estaVazio() async {
    return await repository.estaVazio();
  }
}
