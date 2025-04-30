import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/domain/repositories/apr/apr_assinatura_repository.dart';
import 'package:sympla_app/core/storage/daos/apr/apr_assinatura_dao.dart';

class AprAssinaturaRepositoryImpl implements AprAssinaturaRepository {
  final AppDatabase db;
  final AprAssinaturaDao dao;

  AprAssinaturaRepositoryImpl(this.db) : dao = db.aprAssinaturaDao;

  @override
  Future<void> salvarAssinatura(AprAssinaturaTableCompanion assinatura) async {
    try {
      await db.aprAssinaturaDao.inserir(assinatura);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[apr_assinatura_repository_impl - salvarAssinatura] ${erro.mensagem}',
          tag: 'AprAssinaturaRepositoryImpl',
          error: e,
          stackTrace: s);
    }
  }

  @override
  Future<List<AprAssinaturaTableData>> buscarAssinaturasPorAprPreenchida(
      int aprPreenchidaId) async {
    try {
      return await db.aprAssinaturaDao.buscarPorAprPreenchida(aprPreenchidaId);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[apr_assinatura_repository_impl - buscarAssinaturasPorAprPreenchida] ${erro.mensagem}',
          tag: 'AprAssinaturaRepositoryImpl',
          error: e,
          stackTrace: s);
    }
    return [];
  }

  @override
  Future<int> contarAssinaturasPorAprPreenchida(int aprPreenchidaId) async {
    try {
      return await db.aprAssinaturaDao.contarPorAprPreenchida(aprPreenchidaId);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[apr_assinatura_repository_impl - contarAssinaturasPorAprPreenchida] ${erro.mensagem}',
          tag: 'AprAssinaturaRepositoryImpl',
          error: e,
          stackTrace: s);
    }
    return 0;
  }

  @override
  Future<void> deletarAssinaturasPorAprPreenchida(int aprPreenchidaId) async {
    try {
      await db.aprAssinaturaDao.deletarPorAprPreenchida(aprPreenchidaId);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[apr_assinatura_repository_impl - deletarAssinaturasPorAprPreenchida] ${erro.mensagem}',
          tag: 'AprAssinaturaRepositoryImpl',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }
}
