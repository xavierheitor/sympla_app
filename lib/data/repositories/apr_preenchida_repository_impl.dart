import 'package:drift/drift.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/apr_preenchida_dao.dart';
import 'package:sympla_app/domain/repositories/apr_preenchida_repository.dart';

class AprPreenchidaRepositoryImpl implements AprPreenchidaRepository {
  final AprPreenchidaDao dao;

  AprPreenchidaRepositoryImpl({required this.dao});

  @override
  Future<AprPreenchidaTableData?> buscarAprPreenchida(int atividadeId) async {
    try {
      final preenchida = await dao.buscarPorAtividade(atividadeId);
      return preenchida.isNotEmpty ? preenchida.first : null;
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[apr_preenchida_repository_impl - buscarAprPreenchida] ${erro.mensagem}',
          tag: 'AprPreenchidaRepositoryImpl',
          error: e,
          stackTrace: s);
    }
    return null;
  }

  @override
  Future<void> criarAprPreenchida(
      int atividadeId, int aprId, int usuarioId) async {
    try {
      final preenchida = AprPreenchidaTableCompanion(
        atividadeId: Value(atividadeId),
        aprId: Value(aprId),
        usuarioId: Value(usuarioId),
      );
      await dao.inserir(preenchida);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[apr_preenchida_repository_impl - criarAprPreenchida] ${erro.mensagem}',
          tag: 'AprPreenchidaRepositoryImpl',
          error: e,
          stackTrace: s);
    }
  }

  @override
  Future<bool> existeAprPreenchida(int atividadeId) async {
    try {
      final preenchida = await dao.buscarPorAtividade(atividadeId);
      return preenchida.isNotEmpty;
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[apr_preenchida_repository_impl - existeAprPreenchida] ${erro.mensagem}',
          tag: 'AprPreenchidaRepositoryImpl',
          error: e,
          stackTrace: s);
    }
    return false;
  }
}
