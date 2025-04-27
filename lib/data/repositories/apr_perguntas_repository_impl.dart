import 'package:drift/drift.dart';
import 'package:sympla_app/core/constants/api_constants.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/apr_pergunta_dao.dart';
import 'package:sympla_app/domain/repositories/apr_perguntas_repository.dart';

class AprPerguntasRepositoryImpl implements AprPerguntasRepository {
  final AprPerguntaDao dao;
  final DioClient dio;
  AprPerguntasRepositoryImpl({required this.dao, required this.dio});

  @override
  Future<List<AprQuestionTableCompanion>> buscarDaApi() async {
    try {
      final response = await dio.get(ApiConstants.aprs);
      final dados = response.data as List;
      return dados
          .map((json) => AprQuestionTableCompanion(
                id: Value(json['id']),
                uuid: Value(json['uuid']),
                texto: Value(json['texto']),
                createdAt: Value(DateTime.now()),
                updatedAt: Value(DateTime.now()),
                sincronizado: const Value(true),
              ))
          .toList();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[apr_perguntas_repository_impl - buscarDaApi] ${erro.mensagem}',
          tag: 'AprPerguntasRepositoryImpl',
          error: e,
          stackTrace: s);
      return [];
    }
  }

  @override
  Future<void> sincronizar() async {
    try {
      final perguntas = await buscarDaApi();
      await dao.sincronizarComApi(perguntas);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[apr_perguntas_repository_impl - sincronizar] ${erro.mensagem}',
          tag: 'AprPerguntasRepositoryImpl',
          error: e,
          stackTrace: s);
    }
  }

  @override
  Future<bool> estaVazio() async {
    return await dao.estaVazio();
  }

  @override
  Future<List<AprQuestionTableData>> buscarTodos(int idApr) async {
    return await dao.buscarPerguntasPorApr(idApr);
  }
}
