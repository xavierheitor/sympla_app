import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/domain/repositories/apr_assinatura_repository.dart';

class AprAssinaturaService {
  final AprAssinaturaRepository aprAssinaturaRepository;

  AprAssinaturaService({required this.aprAssinaturaRepository});

  Future<void> salvarAssinatura(AprAssinaturaTableCompanion assinatura) async {
    try {
      AppLogger.d('🖋️ Salvando assinatura APR', tag: 'AprAssinaturaService');
      await aprAssinaturaRepository.salvarAssinatura(assinatura);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AprAssinaturaService - salvarAssinatura] ${erro.mensagem}',
          tag: 'AprAssinaturaService', error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<int> contarAssinaturas(int aprPreenchidaId) async {
    try {
      AppLogger.d('🔍 Contando assinaturas da APR preenchida: $aprPreenchidaId',
          tag: 'AprAssinaturaService');
      return await aprAssinaturaRepository
          .contarAssinaturasPorAprPreenchida(aprPreenchidaId);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AprAssinaturaService - contarAssinaturas] ${erro.mensagem}',
          tag: 'AprAssinaturaService', error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<List<AprAssinaturaTableData>> buscarAssinaturas(
      int aprPreenchidaId) async {
    try {
      AppLogger.d(
          '🔍 Buscando assinaturas para aprPreenchidaId: $aprPreenchidaId',
          tag: 'AprAssinaturaService');
      return await aprAssinaturaRepository
          .buscarAssinaturasPorAprPreenchida(aprPreenchidaId);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AprAssinaturaService - buscarAssinaturas] ${erro.mensagem}',
          tag: 'AprAssinaturaService', error: e, stackTrace: s);
      rethrow;
    }
  }
}
