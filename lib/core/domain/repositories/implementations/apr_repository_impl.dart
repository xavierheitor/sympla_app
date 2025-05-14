import 'package:sympla_app/core/domain/dto/apr/apr_assinatura_table_dto.dart';
import 'package:sympla_app/core/domain/dto/apr/apr_preenchida_table_dto.dart';
import 'package:sympla_app/core/domain/dto/apr/apr_question_table_dto.dart';
import 'package:sympla_app/core/domain/dto/apr/apr_resposta_table_dto.dart';
import 'package:sympla_app/core/domain/dto/apr/apr_table_dto.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/apr_repository.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/apr_dao.dart';

class AprRepositoryImpl implements AprRepository {
  final AppDatabase db;
  final AprDao aprDao;
  final DioClient dio;

  AprRepositoryImpl(this.db, this.dio) : aprDao = db.aprDao;

  @override
  Future<void> atualizarDataPreenchimento(int aprPreenchidaId, DateTime data) {
    // TODO: implement atualizarDataPreenchimento
    throw UnimplementedError();
  }

  @override
  Future<AprPreenchidaTableDto?> buscarAprPreenchida(String atividadeId) async {
    try {
      return await aprDao.buscarPreenchidasPorAtividade(atividadeId).then(
          (value) => value.isNotEmpty
              ? AprPreenchidaTableDto.fromData(value.first)
              : null);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[apr_repository_impl - buscarAprPreenchida] ${erro.mensagem}',
          tag: 'AprRepositoryImpl',
          error: e,
          stackTrace: s);
      return null;
    }
  }

  @override
  Future<List<AprAssinaturaTableDto>> buscarAssinaturas(
      int aprPreenchidaId) async {
    try {
      return await aprDao.buscarAssinaturas(aprPreenchidaId).then((value) =>
          value.map((e) => AprAssinaturaTableDto.fromData(e)).toList());
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[apr_repository_impl - buscarAssinaturas] ${erro.mensagem}',
          tag: 'AprRepositoryImpl', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<AprTableDto> buscarModeloPorTipoAtividade(
      String idTipoAtividade) async {
    try {
      return await aprDao
          .buscarPorTipoAtividade(idTipoAtividade)
          .then((value) => AprTableDto.fromData(value));
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[apr_repository_impl - buscarModeloPorTipoAtividade] ${erro.mensagem}',
          tag: 'AprRepositoryImpl',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<List<AprQuestionTableDto>> buscarPerguntasRelacionadas(
      String aprId) async {
    try {
      return await aprDao.buscarPerguntasPorApr(aprId).then((value) =>
          value.map((e) => AprQuestionTableDto.fromData(e)).toList());
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[apr_repository_impl - buscarPerguntasRelacionadas] ${erro.mensagem}',
          tag: 'AprRepositoryImpl',
          error: e,
          stackTrace: s);
      return [];
    }
  }

  @override
  Future<List<AprRespostaTableDto>> buscarRespostas(int aprPreenchidaId) {
    // TODO: implement buscarRespostas
    throw UnimplementedError();
  }

  @override
  Future<int> contarAssinaturas(int aprPreenchidaId) async {
    try {
      return await aprDao.contarAssinaturas(aprPreenchidaId);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[apr_repository_impl - contarAssinaturas] ${erro.mensagem}',
          tag: 'AprRepositoryImpl', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<int> criarAprPreenchida(AprPreenchidaTableDto apr) async {
    try {
      return await aprDao.inserirAprPreenchida(apr.toCompanion());
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[apr_repository_impl - criarAprPreenchida] ${erro.mensagem}',
          tag: 'AprRepositoryImpl', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<void> deletarAprPreenchida(int aprPreenchidaId) async {
    try {
      await aprDao.deletarAprPreenchida(aprPreenchidaId);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[apr_repository_impl - deletarAprPreenchida] ${erro.mensagem}',
          tag: 'AprRepositoryImpl',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<void> deletarAssinaturas(int aprPreenchidaId) async {
    try {
      await aprDao.deletarAssinaturasDaApr(aprPreenchidaId);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[apr_repository_impl - deletarAssinaturas] ${erro.mensagem}',
          tag: 'AprRepositoryImpl', error: e, stackTrace: s);
    }
  }

  @override
  Future<void> deletarRespostas(int aprPreenchidaId) {
    // TODO: implement deletarRespostas
    throw UnimplementedError();
  }

  @override
  Future<bool> existeAprPreenchida(String atividadeId) async {
    try {
      return await aprDao
          .buscarPreenchidasPorAtividade(atividadeId)
          .then((value) => value.isNotEmpty);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[apr_repository_impl - existeAprPreenchida] ${erro.mensagem}',
          tag: 'AprRepositoryImpl',
          error: e,
          stackTrace: s);
      return false;
    }
  }

  @override
  Future<bool> existeRespostas(int aprPreenchidaId) {
    // TODO: implement existeRespostas
    throw UnimplementedError();
  }

  @override
  Future<void> salvarAssinatura(AprAssinaturaTableDto assinatura) async {
    try {
      await aprDao.salvarAssinatura(assinatura.toCompanion());
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[apr_repository_impl - salvarAssinatura] ${erro.mensagem}',
          tag: 'AprRepositoryImpl', error: e, stackTrace: s);
    }
  }

  @override
  Future<bool> salvarRespostas(List<AprRespostaTableDto> respostas) {
    // TODO: implement salvarRespostas
    throw UnimplementedError();
  }
}
