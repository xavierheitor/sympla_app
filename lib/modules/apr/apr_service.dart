// === apr_service.dart ===
import 'package:get/get.dart' as g;
import 'package:sympla_app/core/domain/dto/apr/apr_assinatura_table_dto.dart';
import 'package:sympla_app/core/domain/dto/apr/apr_preenchida_table_dto.dart';
import 'package:sympla_app/core/domain/dto/apr/apr_question_table_dto.dart';
import 'package:sympla_app/core/domain/dto/apr/apr_resposta_table_dto.dart';
import 'package:sympla_app/core/domain/dto/apr/apr_table_dto.dart';
import 'package:sympla_app/core/domain/dto/tecnico_table_dto.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/apr_repository.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/tecnico_repository.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/core_app/session/session_manager.dart';

class AprService {
  final AprRepository aprRepository;
  final TecnicoRepository tecnicoRepository;

  AprService({
    required this.aprRepository,
    required this.tecnicoRepository,
  });

  Future<AprTableDto> buscarAprPorTipoAtividade(String idTipoAtividade) async {
    try {
      AppLogger.d(
          '[AprService] Buscando APR para tipoAtividade: $idTipoAtividade');
      final apr =
          await aprRepository.buscarModeloPorTipoAtividade(idTipoAtividade);
      AppLogger.d(
          '[AprService] APR encontrada - ID: ${apr.uuid}, Nome: ${apr.nome}');
      return apr;
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AprService - buscarAprPorTipoAtividade] ${erro.mensagem}',
          tag: 'AprService', error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<List<AprQuestionTableDto>> buscarPerguntas(String aprId) async {
    try {
      AppLogger.d('[AprService] Buscando perguntas para APR: $aprId');
      return await aprRepository.buscarPerguntasRelacionadas(aprId);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AprService - buscarPerguntas] ${erro.mensagem}',
          tag: 'AprService', error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<bool> salvarRespostas(List<AprRespostaTableDto> respostas) async {
    try {
      AppLogger.d('[AprService] Salvando ${respostas.length} respostas...');
      return await aprRepository.salvarRespostas(respostas);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AprService - salvarRespostas] ${erro.mensagem}',
          tag: 'AprService', error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<bool> aprJaPreenchida(String atividadeId) async {
    try {
      AppLogger.d(
          '[AprService] Verificando APR preenchida para atividade: $atividadeId');
      final aprPreenchida =
          await aprRepository.buscarAprPreenchida(atividadeId);
      if (aprPreenchida == null) return false;

      final respostas = await aprRepository.buscarRespostas(aprPreenchida.id!);
      return respostas.isNotEmpty;
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AprService - aprJaPreenchida] ${erro.mensagem}',
          tag: 'AprService', error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<int> criarAprPreenchida(String atividadeId, String aprId) async {
    try {
      final dto = AprPreenchidaTableDto(
        atividadeId: atividadeId,
        aprId: aprId,
        dataPreenchimento: DateTime.now(),
        usuarioId: g.Get.find<SessionManager>().usuario!.uuid,
      );
      final id = await aprRepository.criarAprPreenchida(dto);
      AppLogger.d('[AprService] APR preenchida criada: $id');
      return id;
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AprService - criarAprPreenchida] ${erro.mensagem}',
          tag: 'AprService', error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<void> atualizarDataPreenchimentoAprPreenchida(
      int aprPreenchidaId, DateTime dataFinal) async {
    try {
      await aprRepository.atualizarDataPreenchimento(
          aprPreenchidaId, dataFinal);
      AppLogger.d(
          '[AprService] Data de preenchimento atualizada para APR $aprPreenchidaId');
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AprService - atualizarDataPreenchimento] ${erro.mensagem}',
          tag: 'AprService', error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<void> deletarAprPreenchida(int aprPreenchidaId) async {
    try {
      await aprRepository.deletarAprPreenchida(aprPreenchidaId);
      AppLogger.d('[AprService] APR preenchida $aprPreenchidaId deletada');
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AprService - deletarAprPreenchida] ${erro.mensagem}',
          tag: 'AprService', error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<List<AprAssinaturaTableDto>> buscarAssinaturas(
      int aprPreenchidaId) async {
    try {
      AppLogger.d(
          '[AprService] Buscando assinaturas para APR $aprPreenchidaId');
      return await aprRepository.buscarAssinaturas(aprPreenchidaId);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AprService - buscarAssinaturas] ${erro.mensagem}',
          tag: 'AprService', error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<void> salvarAssinatura(AprAssinaturaTableDto assinatura) async {
    try {
      await aprRepository.salvarAssinatura(assinatura);
      AppLogger.d('[AprService] Assinatura salva com sucesso');
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AprService - salvarAssinatura] ${erro.mensagem}',
          tag: 'AprService', error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<List<TecnicoTableDto>> buscarTecnicos() async {
    try {
      AppLogger.d('[AprService] Buscando técnicos');
      final tecnicos = await tecnicoRepository.buscarTodosTecnicos();
      return tecnicos;
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AprService - buscarTecnicos] ${erro.mensagem}',
          tag: 'AprService', error: e, stackTrace: s);
      rethrow;
    }
  }
}
