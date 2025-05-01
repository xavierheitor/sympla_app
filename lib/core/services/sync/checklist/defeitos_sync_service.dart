import 'package:sympla_app/core/domain/repositories/checklist/defeito_repository.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';

class DefeitosSyncService {
  final DefeitoRepository repository;

  DefeitosSyncService(this.repository);

  Future<void> sincronizar() async {
    try {
      AppLogger.d('🔄 Iniciando sincronização de Defeitos',
          tag: 'DefeitosSyncService');
      final lista = await repository.buscarDaApi();
      await repository.salvarNoBanco(lista);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[DefeitosSyncService - sincronizar] ${erro.mensagem}',
          tag: 'DefeitosSyncService', error: e, stackTrace: s);
      rethrow;
    }
  }
}
