import 'package:drift/drift.dart';
import 'package:sympla_app/core/constants/api_constants.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/apr_dao.dart';
import 'package:sympla_app/core/domain/repositories/apr_repository.dart';

class AprRepositoryImpl implements AprRepository {
  final AprDao dao;
  final DioClient dio;
  final AppDatabase db;

  AprRepositoryImpl({required this.dio, required this.db}) : dao = db.aprDao;

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
                createdAt: Value(DateTime.now()),
                updatedAt: Value(DateTime.now()),
                sincronizado: const Value(true),
              ))
          .toList();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[apr_repository_impl - buscarDaApi] ${erro.mensagem}',
          tag: 'AprRepositoryImpl', error: e, stackTrace: s);
      return [];
    }
  }

  @override
  Future<AprTableData> buscarPorTipoAtividade(int idTipoAtividade) async {
    try {
      final result = await dao.buscarPorTipoAtividade(idTipoAtividade);
      return result;
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[apr_repository_impl - buscarPorTipoAtividade] ${erro.mensagem}',
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
      final result = await dao.estaVazio();
      return result;
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[apr_repository_impl - estaVazio] ${erro.mensagem}',
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
      AppLogger.e('[apr_repository_impl - salvarNoBanco] ${erro.mensagem}',
          tag: 'AprRepositoryImpl', error: e, stackTrace: s);
    }
  }

  @override
  Future<void> sincronizar(List<AprTableCompanion> lista) async {
    try {
      await dao.sincronizarComApi(lista);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[apr_repository_impl - sincronizar] ${erro.mensagem}',
          tag: 'AprRepositoryImpl', error: e, stackTrace: s);
    }
  }
}
