import 'package:drift/drift.dart';
import 'package:sympla_app/core/constants/api_constants.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/apr/apr_dao.dart';
import 'package:sympla_app/core/storage/daos/apr/apr_preenchida_dao.dart';
import 'package:sympla_app/core/domain/repositories/apr/apr_repository.dart';

class AprRepositoryImpl implements AprRepository {
  final AprDao dao;
  final AprPreenchidaDao preenchidaDao;
  final DioClient dio;
  final AppDatabase db;

  AprRepositoryImpl({required this.dio, required this.db})
      : dao = db.aprDao,
        preenchidaDao = db.aprPreenchidaDao;

  @override
  Future<List<AprTableCompanion>> buscarDaApi() async {
    try {
      final response = await dio.get(ApiConstants.aprs);
      final dados = response.data as List;
      return dados
          .map((json) => AprTableCompanion(
                id: Value(json['id']),
                uuid: Value(json['uuid']),
                nome: Value(json['nome']),
                descricao: Value(json['descricao']),
                createdAt: Value(DateTime.parse(json['createdAt'])),
                updatedAt: Value(DateTime.parse(json['updatedAt'])),
                sincronizado: const Value(true),
              ))
          .toList();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AprRepositoryImpl - buscarDaApi] ${erro.mensagem}',
          tag: 'AprRepositoryImpl', error: e, stackTrace: s);
      return [];
    }
  }

  @override
  Future<AprTableData> buscarPorTipoAtividade(int idTipoAtividade) async {
    try {
      return await dao.buscarPorTipoAtividade(idTipoAtividade);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[AprRepositoryImpl - buscarPorTipoAtividade] ${erro.mensagem}',
          tag: 'AprRepositoryImpl',
          error: e,
          stackTrace: s);
      throw Exception(
          'Não foi possível encontrar a APR para o tipo de atividade $idTipoAtividade');
    }
  }

  @override
  Future<bool> estaVazio() async {
    try {
      return await dao.estaVazio();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AprRepositoryImpl - estaVazio] ${erro.mensagem}',
          tag: 'AprRepositoryImpl', error: e, stackTrace: s);
      return false;
    }
  }

  @override
  Future<void> salvarNoBanco(AprTableCompanion apr) async {
    try {
      await dao.inserirOuAtualizar(apr);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AprRepositoryImpl - salvarNoBanco] ${erro.mensagem}',
          tag: 'AprRepositoryImpl', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<void> sincronizar(List<AprTableCompanion> lista) async {
    try {
      final aprs = await buscarDaApi();
      await dao.sincronizarComApi(aprs);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AprRepositoryImpl - sincronizar] ${erro.mensagem}',
          tag: 'AprRepositoryImpl', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<int> criarAprPreenchida(AprPreenchidaTableCompanion apr) async {
    try {
      return await preenchidaDao.inserir(apr);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AprRepositoryImpl - criarAprPreenchida] ${erro.mensagem}',
          tag: 'AprRepositoryImpl', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<void> atualizarDataPreenchimento(
      int aprPreenchidaId, DateTime dataPreenchimento) async {
    try {
      await preenchidaDao.atualizarDataPreenchimento(
          aprPreenchidaId, dataPreenchimento);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[AprRepositoryImpl - atualizarDataPreenchimento] ${erro.mensagem}',
          tag: 'AprRepositoryImpl',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<void> deletarAprPreenchida(int aprPreenchidaId) async {
    try {
      await preenchidaDao.deletarPorId(aprPreenchidaId);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AprRepositoryImpl - deletarAprPreenchida] ${erro.mensagem}',
          tag: 'AprRepositoryImpl', error: e, stackTrace: s);
      rethrow;
    }
  }
}
