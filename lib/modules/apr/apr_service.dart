// === apr_service.dart ===

import 'package:get/get.dart' as g;
import 'package:sympla_app/core/domain/dto/apr/apr_question_table_dto.dart';
import 'package:sympla_app/core/domain/dto/apr/apr_assinatura_table_dto.dart';
import 'package:sympla_app/core/domain/dto/apr/apr_preenchida_table_dto.dart';
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
          '🔍 [AprService] Buscando APR para tipoAtividade: \$idTipoAtividade',
          tag: 'AprService');
      final apr =
          await aprRepository.buscarModeloPorTipoAtividade(idTipoAtividade);
      AppLogger.d(
          '✅ [AprService] APR encontrada - ID: \${apr.id}, Nome: \${apr.nome}',
          tag: 'AprService');
      return apr;
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AprService - buscarAprPorTipoAtividade] \${erro.mensagem}',
          tag: 'AprService', error: erro.mensagem, stackTrace: erro.stack);
      rethrow;
    }
  }

  Future<List<AprQuestionTableDto>> buscarPerguntas(String aprId) async {
    try {
      AppLogger.d('🔍 [AprService] Buscando perguntas para APR: \$aprId',
          tag: 'AprService');
      return await aprRepository.buscarPerguntasRelacionadas(aprId);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AprService - buscarPerguntas] \${erro.mensagem}',
          tag: 'AprService', error: erro.mensagem, stackTrace: erro.stack);
      rethrow;
    }
  }

  Future<bool> salvarRespostas(List<AprRespostaTableDto> respostas) async {
    try {
      AppLogger.d(
          '💾 [AprService] Iniciando salvamento de \${respostas.length} respostas',
          tag: 'AprService');
      AppLogger.d(
          '📋 [AprService] IDs das perguntas: \${respostas.map((r) => r.perguntaId.value).join(',
          tag: 'AprService');
      final sucesso = await aprRepository.salvarRespostas(respostas);
      AppLogger.d('✅ [AprService] Respostas salvas com sucesso: \$sucesso',
          tag: 'AprService');
      return sucesso;
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AprService - salvarRespostas] \${erro.mensagem}',
          tag: 'AprService', error: erro.mensagem, stackTrace: erro.stack);
      rethrow;
    }
  }

  Future<bool> aprJaPreenchida(String atividadeId) async {
    try {
      AppLogger.d(
          '🔍 [AprService] Verificando se atividade $atividadeId já tem APR preenchida',
          tag: 'AprService');

      final aprPreenchida =
          await aprRepository.buscarAprPreenchida(atividadeId);

      if (aprPreenchida == null) {
        AppLogger.d(
            '❌ Nenhuma APR preenchida encontrada para atividade $atividadeId',
            tag: 'AprService');
        return false;
      }

      final respostas = await aprRepository.buscarRespostas(aprPreenchida.id!);

      final preenchida = respostas.isNotEmpty;
      AppLogger.d(
          '📊 [AprService] APR ${preenchida ? "já preenchida" : "não preenchida"} para atividade $atividadeId',
          tag: 'AprService');

      return preenchida;
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AprService - aprJaPreenchida] ${erro.mensagem}',
          tag: 'AprService', error: erro.mensagem, stackTrace: erro.stack);
      rethrow;
    }
  }

  Future<List<TecnicoTableDto>> buscarTecnicos() async {
    try {
      AppLogger.d('🔍 [AprService] Buscando técnicos', tag: 'AprService');
      final tecnicos = await tecnicoRepository.buscarTodosTecnicos();
      AppLogger.d('✅ [AprService] \${tecnicos.length} técnicos encontrados',
          tag: 'AprService');
      return tecnicos;
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AprService - buscarTecnicos] \${erro.mensagem}',
          tag: 'AprService', error: erro.mensagem, stackTrace: erro.stack);
      rethrow;
    }
  }

  Future<int> criarAprPreenchida(String atividadeId, String aprId) async {
    try {
      final id = await aprRepository.criarAprPreenchida(
        AprPreenchidaTableDto(
          atividadeId: atividadeId,
          aprId: aprId,
          dataPreenchimento: DateTime.now(),
          usuarioId: g.Get.find<SessionManager>().usuario!.uuid,
        ),
      );
      AppLogger.d('✅ [AprService] APR Preenchida criada - ID: \$id',
          tag: 'AprService');
      return id;
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AprService - criarAprPreenchida] \${erro.mensagem}',
          tag: 'AprService', error: erro.mensagem, stackTrace: erro.stack);
      rethrow;
    }
  }

  Future<void> atualizarDataPreenchimentoAprPreenchida(
      int aprPreenchidaId, DateTime dataFinal) async {
    try {
      await aprRepository.atualizarDataPreenchimento(
          aprPreenchidaId, dataFinal);
      AppLogger.d(
          '✅ [AprService] Data de preenchimento atualizada para APR Preenchida \$aprPreenchidaId',
          tag: 'AprService');
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[AprService - atualizarDataPreenchimentoAprPreenchida] \${erro.mensagem}',
          tag: 'AprService',
          error: erro.mensagem,
          stackTrace: erro.stack);
      rethrow;
    }
  }

  Future<void> deletarAprPreenchida(int aprPreenchidaId) async {
    try {
      await aprRepository.deletarAprPreenchida(aprPreenchidaId);
      AppLogger.d('✅ [AprService] APR Preenchida \$aprPreenchidaId deletada',
          tag: 'AprService');
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AprService - deletarAprPreenchida] \${erro.mensagem}',
          tag: 'AprService', error: erro.mensagem, stackTrace: erro.stack);
      rethrow;
    }
  }

  Future<void> deletarAprPreenchidaComDependencias(int aprPreenchidaId) async {
    try {
      AppLogger.d(
          '🗑️ Deletando dependências da APR preenchida $aprPreenchidaId',
          tag: 'AprService');

      // Deletar respostas
      await aprRepository.deletarAprPreenchida(aprPreenchidaId);

      // Deletar assinaturas
      await deletarAssinaturasDaApr(aprPreenchidaId);

      // Agora deletar a própria apr_preenchida
      await aprRepository.deletarAprPreenchida(aprPreenchidaId);

      AppLogger.d('✅ APR preenchida e suas dependências deletadas com sucesso',
          tag: 'AprService');
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[AprService - deletarAprPreenchidaComDependencias] ${erro.mensagem}',
          tag: 'AprService',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }

  Future<void> salvarAssinatura(AprAssinaturaTableDto assinatura) async {
    try {
      AppLogger.d('🖋️ Salvando assinatura APR', tag: 'AprAssinaturaService');
      await aprRepository.salvarAssinatura(assinatura);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AprAssinaturaService - salvarAssinatura] ${erro.mensagem}',
          tag: 'AprAssinaturaService', error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<int> contarAssinaturas(int aprPreenchidaId) async {
    try {
      AppLogger.d('🔍 Contando assinaturas da APR preenchida: $aprPreenchidaId',
          tag: 'AprAssinaturaService');
      return await aprRepository.contarAssinaturas(aprPreenchidaId);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AprAssinaturaService - contarAssinaturas] ${erro.mensagem}',
          tag: 'AprAssinaturaService', error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<List<AprAssinaturaTableDto>> buscarAssinaturas(
      int aprPreenchidaId) async {
    try {
      AppLogger.d(
          '🔍 Buscando assinaturas para aprPreenchidaId: $aprPreenchidaId',
          tag: 'AprAssinaturaService');
      return await aprRepository.buscarAssinaturas(aprPreenchidaId);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[AprAssinaturaService - buscarAssinaturas] ${erro.mensagem}',
          tag: 'AprAssinaturaService', error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<void> deletarAssinaturasDaApr(int aprPreenchidaId) async {
    try {
      await aprRepository.deletarAssinaturas(aprPreenchidaId);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[AprAssinaturaService - deletarAssinaturasDaApr] ${erro.mensagem}',
          tag: 'AprAssinaturaService',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }
}
