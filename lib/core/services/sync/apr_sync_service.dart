import 'package:sympla_app/core/domain/repositories/apr/apr_perguntas_repository.dart';
import 'package:sympla_app/core/domain/repositories/apr/apr_repository.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/errors/error_handler.dart';

class AprSyncService {
  final AprRepository aprRepository;
  final AprPerguntasRepository aprPerguntaRepository;

  AprSyncService({
    required this.aprRepository,
    required this.aprPerguntaRepository,
  });

  Future<void> sincronizarAprs() async {
    try {
      AppLogger.d('🔄 Iniciando sincronização de APRs', tag: 'AprSyncService');
      final lista = await aprRepository.buscarDaApi();
      await aprRepository.sincronizar(lista);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AprSyncService - sincronizar] ${erro.mensagem}',
          tag: 'AprSyncService', error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<void> sincronizarPerguntas() async {
    try {
      AppLogger.d('🔄 Iniciando sincronização de Perguntas',
          tag: 'AprSyncService');
      final lista = await aprPerguntaRepository.buscarDaApi();
      await aprPerguntaRepository.sincronizar(lista);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AprSyncService - sincronizarPerguntas] ${erro.mensagem}',
          tag: 'AprSyncService', error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<void> sincronizarPerguntaRelacionamentos() async {
    try {
      AppLogger.d('🔄 Iniciando sincronização de Pergunta Relacionamentos',
          tag: 'AprSyncService');

      final lista = await aprPerguntaRepository.buscarRelacionamentosDaApi();
      await aprPerguntaRepository.sincronizarRelacionamentos(lista);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
        '[AprSyncService - sincronizarPerguntaRelacionamentos] ${erro.mensagem}',
        tag: 'AprSyncService',
        error: e,
        stackTrace: s,
      );
      rethrow;
    }
  }
}
