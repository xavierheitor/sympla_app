import 'package:drift/drift.dart';
import 'package:sympla_app/core/constants/api_constants.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/apr_dao.dart';
import 'package:sympla_app/core/domain/repositories/apr_repository.dart';
import 'package:sympla_app/core/storage/daos/apr_preenchida_dao.dart';

class AprRepositoryImpl implements AprRepository {
  final DioClient dio;
  final AppDatabase db;
  final AprDao dao;
  final AprPreenchidaDao preenchidaDao;

  AprRepositoryImpl({required this.dio, required this.db})
      : dao = db.aprDao,
        preenchidaDao = db.aprPreenchidaDao;

  @override
  Future<List<AprTableCompanion>> buscarDaApi() async {
    try {
      AppLogger.d('🔄 Buscando APRs da API', tag: 'AprRepositoryImpl');
      final response = await dio.get(ApiConstants.aprs);
      final dados = response.data as List;
      AppLogger.d('📥 Recebido \${dados.length} APRs da API',
          tag: 'AprRepositoryImpl');

      final aprs = dados.map<AprTableCompanion>((json) {
        AppLogger.d('📋 Processando APR - ${json['id']}',
            tag: 'AprRepositoryImpl');
        return AprTableCompanion(
          id: Value(json['id']),
          uuid: Value(json['uuid']),
          nome: Value(json['nome']),
          descricao: Value(json['descricao']),
          createdAt: Value(DateTime.parse(json['createdAt'])),
          updatedAt: Value(DateTime.parse(json['updatedAt'])),
          sincronizado: const Value(true),
        );
      }).toList();

      AppLogger.d(
          '✅ Processamento concluído - \${aprs.length} APRs convertidas',
          tag: 'AprRepositoryImpl');
      return aprs;
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AprRepositoryImpl - buscarDaApi] \${erro.mensagem}',
          tag: 'AprRepositoryImpl',
          error: erro.mensagem,
          stackTrace: erro.stack);
      return [];
    }
  }

  @override
  Future<void> sincronizar(List<AprTableCompanion> entradas) async {
    try {
      AppLogger.d('🔄 Iniciando sincronização de \${entradas.length} APRs',
          tag: 'AprRepositoryImpl');
      await dao.sincronizarComApi(entradas);
      AppLogger.d('✅ Sincronização concluída', tag: 'AprRepositoryImpl');
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AprRepositoryImpl - sincronizar] \${erro.mensagem}',
          tag: 'AprRepositoryImpl',
          error: erro.mensagem,
          stackTrace: erro.stack);
      rethrow;
    }
  }

  @override
  Future<AprTableData> buscarPorTipoAtividade(int idTipoAtividade) async {
    try {
      AppLogger.d('🔍 Buscando APR para tipoAtividade: \$idTipoAtividade',
          tag: 'AprRepositoryImpl');
      final result = await dao.buscarPorTipoAtividade(idTipoAtividade);
      AppLogger.d('✅ APR encontrada - ID: \${result.id}, Nome: \${result.nome}',
          tag: 'AprRepositoryImpl');
      return result;
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[AprRepositoryImpl - buscarPorTipoAtividade] \${erro.mensagem}',
          tag: 'AprRepositoryImpl',
          error: erro.mensagem,
          stackTrace: erro.stack);
      rethrow;
    }
  }

  @override
  Future<void> salvarNoBanco(AprTableCompanion apr) async {
    try {
      AppLogger.d(
          '💾 Salvando APR no banco - ID: \${apr.id.value}, Nome: \${apr.nome.value}',
          tag: 'AprRepositoryImpl');
      await dao.inserirOuAtualizar(apr);
      AppLogger.d('✅ APR salva com sucesso', tag: 'AprRepositoryImpl');
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AprRepositoryImpl - salvarNoBanco] \${erro.mensagem}',
          tag: 'AprRepositoryImpl',
          error: erro.mensagem,
          stackTrace: erro.stack);
      rethrow;
    }
  }

  @override
  Future<bool> estaVazio() async {
    try {
      AppLogger.d('🔍 Verificando se existem APRs no banco',
          tag: 'AprRepositoryImpl');
      final result = await dao.estaVazio();
      AppLogger.d('📊 Banco \${result ? "vazio" : "contém APRs"}',
          tag: 'AprRepositoryImpl');
      return result;
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AprRepositoryImpl - estaVazio] \${erro.mensagem}',
          tag: 'AprRepositoryImpl',
          error: erro.mensagem,
          stackTrace: erro.stack);
      return false;
    }
  }

  @override
  Future<int> criarAprPreenchida(AprPreenchidaTableCompanion apr) {
    return preenchidaDao.inserir(apr);
  }

  @override
  Future<void> atualizarDataPreenchimento(
      int aprPreenchidaId, DateTime dataPreenchimento) async {
    await preenchidaDao.atualizarDataPreenchimento(
        aprPreenchidaId, dataPreenchimento);
  }

  @override
  Future<void> deletarAprPreenchida(int aprPreenchidaId) async {
    await preenchidaDao.deletarPorId(aprPreenchidaId);
  }
}
