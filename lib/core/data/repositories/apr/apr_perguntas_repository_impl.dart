import 'package:drift/drift.dart';
import 'package:sympla_app/core/constants/api_constants.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/apr/apr_pergunta_dao.dart';
import 'package:sympla_app/core/storage/daos/apr/apr_pergunta_relacionamento_dao.dart';
import 'package:sympla_app/core/domain/repositories/apr/apr_perguntas_repository.dart';

class AprPerguntasRepositoryImpl implements AprPerguntasRepository {
  final AprPerguntaDao dao;
  final AprPerguntaRelacionamentoDao daoRelacionamento;
  final DioClient dio;
  final AppDatabase db;

  AprPerguntasRepositoryImpl({required this.dio, required this.db})
      : dao = db.aprPerguntaDao,
        daoRelacionamento = db.aprPerguntaRelacionamentoDao;

  @override
  Future<List<AprQuestionTableCompanion>> buscarDaApi() async {
    try {
      final response = await dio.get(ApiConstants.perguntas);
      final dados = response.data as List;

      AppLogger.d('🔍 Recebidas ${dados.length} perguntas APR da API',
          tag: 'AprPerguntasRepositoryImpl');

      return dados.map<AprQuestionTableCompanion>((json) {
        return AprQuestionTableCompanion(
          id: Value(json['id']),
          uuid: Value(json['uuid']),
          texto: Value(json['texto']),
          createdAt: Value(DateTime.parse(json['createdAt'])),
          updatedAt: Value(DateTime.parse(json['updatedAt'])),
          sincronizado: const Value(true),
        );
      }).toList();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AprPerguntasRepositoryImpl - buscarDaApi] ${erro.mensagem}',
          tag: 'AprPerguntasRepositoryImpl', error: e, stackTrace: s);
      return [];
    }
  }

  @override
  Future<void> sincronizar(List<AprQuestionTableCompanion> lista) async {
    try {
      await dao.sincronizarComApi(lista);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AprPerguntasRepositoryImpl - sincronizar] ${erro.mensagem}',
          tag: 'AprPerguntasRepositoryImpl', error: e, stackTrace: s);
    }
  }

  @override
  Future<bool> estaVazio() async {
    try {
      return await dao.estaVazio();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AprPerguntasRepositoryImpl - estaVazio] ${erro.mensagem}',
          tag: 'AprPerguntasRepositoryImpl', error: e, stackTrace: s);
      return true;
    }
  }

  @override
  Future<List<AprQuestionTableData>> buscarTodos(int idApr) async {
    try {
      return await dao.buscarPerguntasPorApr(idApr);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AprPerguntasRepositoryImpl - buscarTodos] ${erro.mensagem}',
          tag: 'AprPerguntasRepositoryImpl', error: e, stackTrace: s);
      return [];
    }
  }

  @override
  Future<void> sincronizarRelacionamentos(
      List<AprPerguntaRelacionamentoTableCompanion> lista) async {
    try {
      await daoRelacionamento.sincronizarComApi(lista);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[AprPerguntasRepositoryImpl - sincronizarRelacionamentos] ${erro.mensagem}',
          tag: 'AprPerguntasRepositoryImpl',
          error: e,
          stackTrace: s);
    }
  }

  @override
  Future<List<AprPerguntaRelacionamentoTableCompanion>>
      buscarRelacionamentosDaApi() async {
    try {
      final response = await dio.get(ApiConstants.aprPerguntasRelacionamentos);
      final dados = response.data as List;

      AppLogger.d(
          '🔍 Recebidas ${dados.length} relacionamentos de perguntas da API',
          tag: 'AprPerguntasRepositoryImpl');

      return dados.map<AprPerguntaRelacionamentoTableCompanion>((json) {
        return AprPerguntaRelacionamentoTableCompanion(
          id: Value(json['id']),
          uuid: Value(json['uuid']),
          perguntaId: Value(json['perguntaId']),
          aprId: Value(json['aprId']),
          ordem: Value(json['ordem']),
          createdAt: Value(DateTime.parse(json['createdAt'])),
          updatedAt: Value(DateTime.parse(json['updatedAt'])),
          sincronizado: const Value(true),
        );
      }).toList();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[AprPerguntasRepositoryImpl - buscarRelacionamentosDaApi] ${erro.mensagem}',
          tag: 'AprPerguntasRepositoryImpl',
          error: e,
          stackTrace: s);
      return [];
    }
  }
}
