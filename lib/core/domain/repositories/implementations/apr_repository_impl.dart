import 'package:sympla_app/core/domain/dto/apr/apr_assinatura_table_dto.dart';
import 'package:sympla_app/core/domain/dto/apr/apr_preenchida_table_dto.dart';
import 'package:sympla_app/core/domain/dto/apr/apr_question_table_dto.dart';
import 'package:sympla_app/core/domain/dto/apr/apr_resposta_table_dto.dart';
import 'package:sympla_app/core/domain/dto/apr/apr_table_dto.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/apr_repository.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/repository_helper.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/apr_dao.dart';

/// 🗂️ Implementação concreta do [AprRepository].
///
/// Gerencia operações locais da APR:
/// - Modelo de APR
/// - Perguntas
/// - Preenchimento
/// - Respostas
/// - Assinaturas
class AprRepositoryImpl with RepositoryHelper implements AprRepository {
  final AppDatabase db;
  final AprDao aprDao;
  final DioClient dio;

  AprRepositoryImpl(this.db, this.dio) : aprDao = db.aprDao;

  // 🔥 Métodos privados de uso interno
  Future<List<AprPreenchidaTableData>> _buscarPreenchidas(String atividadeId) {
    return aprDao.buscarPreenchidasPorAtividade(atividadeId);
  }

  // ------------------- APR -------------------

  @override
  Future<AprTableDto> buscarModeloPorTipoAtividade(String tipoAtividadeId) {
    return executar('buscarModeloPorTipoAtividade', () async {
      final data = await aprDao.buscarPorTipoAtividade(tipoAtividadeId);
      return AprTableDto.fromData(data);
    });
  }

  @override
  Future<List<AprQuestionTableDto>> buscarPerguntasRelacionadas(String aprId) {
    return executar('buscarPerguntasRelacionadas', () async {
      final list = await aprDao.buscarPerguntasPorApr(aprId);
      return list.map(AprQuestionTableDto.fromData).toList();
    }, onErrorReturn: []);
  }

  // ------------------- APR Preenchida -------------------

  @override
  Future<int> criarAprPreenchida(AprPreenchidaTableDto apr) {
    return executar('criarAprPreenchida', () {
      return aprDao.inserirAprPreenchida(apr.toCompanion());
    });
  }

  @override
  Future<void> atualizarDataPreenchimento(int aprPreenchidaId, DateTime data) {
    return executar(
      'atualizarDataPreenchimento',
      () => aprDao.atualizarDataPreenchimento(aprPreenchidaId, data),
    );
  }

  @override
  Future<void> deletarAprPreenchida(int aprPreenchidaId) {
    return executar(
      'deletarAprPreenchida',
      () => aprDao.deletarAprPreenchida(aprPreenchidaId),
    );
  }

  @override
  Future<AprPreenchidaTableDto?> buscarAprPreenchida(String atividadeId) {
    return executar('buscarAprPreenchida', () async {
      final list = await _buscarPreenchidas(atividadeId);
      return list.isNotEmpty
          ? AprPreenchidaTableDto.fromData(list.first)
          : null;
    });
  }

  @override
  Future<bool> existeAprPreenchida(String atividadeId) {
    return executar('existeAprPreenchida', () async {
      final list = await _buscarPreenchidas(atividadeId);
      return list.isNotEmpty;
    }, onErrorReturn: false);
  }

  // ------------------- Respostas -------------------

  @override
  Future<bool> salvarRespostas(List<AprRespostaTableDto> respostas) {
    return executar('salvarRespostas', () async {
      await aprDao
          .salvarRespostas(respostas.map((e) => e.toCompanion()).toList());
      return true;
    }, onErrorReturn: false);
  }

  @override
  Future<List<AprRespostaTableDto>> buscarRespostas(int aprPreenchidaId) {
    return executar('buscarRespostas', () async {
      final list = await aprDao.buscarRespostas(aprPreenchidaId);
      return list.map(AprRespostaTableDto.fromData).toList();
    }, onErrorReturn: []);
  }

  @override
  Future<void> deletarRespostas(int aprPreenchidaId) {
    return executar(
      'deletarRespostas',
      () => aprDao.deletarRespostas(aprPreenchidaId),
    );
  }

  @override
  Future<bool> existeRespostas(int aprPreenchidaId) {
    return executar('existeRespostas', () async {
      final list = await aprDao.buscarRespostas(aprPreenchidaId);
      return list.isNotEmpty;
    }, onErrorReturn: false);
  }

  // ------------------- Assinaturas -------------------

  @override
  Future<void> salvarAssinatura(AprAssinaturaTableDto assinatura) {
    return executar(
      'salvarAssinatura',
      () => aprDao.salvarAssinatura(assinatura.toCompanion()),
    );
  }

  @override
  Future<List<AprAssinaturaTableDto>> buscarAssinaturas(int aprPreenchidaId) {
    return executar('buscarAssinaturas', () async {
      final list = await aprDao.buscarAssinaturas(aprPreenchidaId);
      return list.map(AprAssinaturaTableDto.fromData).toList();
    }, onErrorReturn: []);
  }

  @override
  Future<int> contarAssinaturas(int aprPreenchidaId) {
    return executar(
      'contarAssinaturas',
      () => aprDao.contarAssinaturas(aprPreenchidaId),
    );
  }

  @override
  Future<void> deletarAssinaturas(int aprPreenchidaId) {
    return executar(
      'deletarAssinaturas',
      () => aprDao.deletarAssinaturasDaApr(aprPreenchidaId),
    );
  }
}
