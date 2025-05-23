import 'package:sympla_app/core/domain/dto/anomalia/anomalia_table_dto.dart';
import 'package:sympla_app/core/domain/dto/checklist/checklist_pergunta_table_dto.dart';
import 'package:sympla_app/core/domain/dto/checklist/checklist_resposta_table_dto.dart';
import 'package:sympla_app/core/domain/dto/checklist/checklist_table_dto.dart';
import 'package:sympla_app/core/domain/dto/checklist/checklist_preenchido_table_dto.dart';
import 'package:sympla_app/core/domain/dto/grupo_defeito_equipamento/defeito_table_dto.dart';
import 'package:sympla_app/core/domain/dto/grupo_defeito_equipamento/equipamento_table_dto.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/anomalia_repository.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/atividade_repository.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/checklist_repository.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/defeito_repository.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/equipamento_repository.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:get/get.dart';
import 'package:sympla_app/core/core_app/session/session_manager.dart';

class ChecklistService {
  final ChecklistRepository checklistRepository;
  final AtividadeRepository atividadeRepository;
  final EquipamentoRepository equipamentoRepository;
  final DefeitoRepository defeitoRepository;
  final AnomaliaRepository anomaliaRepository;

  ChecklistService(
    this.checklistRepository,
    this.atividadeRepository,
    this.equipamentoRepository,
    this.defeitoRepository,
    this.anomaliaRepository,
  );

  Future<ChecklistTableDto> buscarChecklistPorTipoAtividade(
      String tipoAtividadeId) async {
    try {
      AppLogger.d(
          '🔍 Buscando checklist por tipoAtividadeId: $tipoAtividadeId');
      final checklist = await checklistRepository
          .buscarModeloPorTipoAtividade(tipoAtividadeId);
      if (checklist == null) {
        throw Exception(
            'Checklist não encontrado para tipoAtividadeId: $tipoAtividadeId');
      }
      return checklist;
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[ChecklistService - buscarChecklistPorTipoAtividade] ${erro.mensagem}',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }

  Future<List<ChecklistPerguntaTableDto>> buscarPerguntasRelacionadas(
      String checklistId) async {
    try {
      AppLogger.d(
          '📋 Buscando perguntas relacionadas ao checklist $checklistId');

      return await checklistRepository.buscarPerguntasRelacionadas(checklistId);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[ChecklistService - buscarPerguntasRelacionadas] ${erro.mensagem}',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }

  Future<void> salvarRespostas(
      List<ChecklistRespostaTableDto> respostas) async {
    try {
      AppLogger.d('💾 Salvando ${respostas.length} respostas de checklist');

      await checklistRepository.salvarRespostas(respostas);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[ChecklistService - salvarRespostas] ${erro.mensagem}',
          error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<List<ChecklistRespostaTableDto>> buscarRespostas(
      int atividadeId) async {
    try {
      AppLogger.d('🔍 Buscando respostas para atividade $atividadeId');
      return await checklistRepository.buscarRespostas(atividadeId);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[ChecklistService - buscarRespostas] ${erro.mensagem}',
          error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<void> deletarRespostas(String atividadeId) async {
    try {
      await checklistRepository.deletarRespostas(atividadeId);
      AppLogger.d(
          '🗑️ Respostas do checklist da atividade $atividadeId removidas');
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[ChecklistService - deletarRespostas] ${erro.mensagem}',
          error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<ChecklistTableDto> buscarChecklistDaAtividade(String id) async {
    try {
      AppLogger.d('🔍 Buscando checklist da atividade $id (atividade: $id)',
          tag: 'ChecklistService');

      final checklist =
          await checklistRepository.buscarModeloPorTipoAtividade(id);
      if (checklist == null) {
        throw Exception('Checklist não encontrado para a atividade $id');
      }
      return checklist;
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[ChecklistService - buscarChecklistDaAtividade] ${erro.mensagem}',
          tag: 'ChecklistService',
          error: erro.mensagem,
          stackTrace: erro.stack);
      rethrow;
    }
  }

  Future<EquipamentoTableDto> buscarEquipamento(String subestacao) async {
    try {
      return await equipamentoRepository
          .buscarEquipamentoPorSubestacao(subestacao);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[ChecklistService - buscarEquipamentos] ${erro.mensagem}',
          error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<List<DefeitoTableDto>> buscarDefeitos(
      EquipamentoTableDto equipamento) async {
    try {
      AppLogger.d(
          '[ChecklistService] Buscando defeitos para equipamento: ${equipamento.uuid} com o grupoDefeitoCodigo:  (${equipamento.grupoDefeitoCodigo})');
      return await defeitoRepository
          .buscarDefeitosPorEquipamentoCodigo(equipamento.grupoDefeitoCodigo);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[ChecklistService - buscarDefeitos] ${erro.mensagem}',
          error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<void> salvarAnomalias(List<AnomaliaTableDto> anomalias) async {
    try {
      await anomaliaRepository.salvarAnomalias(anomalias);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[ChecklistService - salvarAnomalias] ${erro.mensagem}',
          error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<void> salvarAnomalia(AnomaliaTableDto anomalia) async {
    try {
      await anomaliaRepository.salvarAnomalia(anomalia);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[ChecklistService - salvarAnomalia] ${erro.mensagem}',
          error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<bool> checklistJaRespondido(String atividadeId) async {
    try {
      AppLogger.d(
          '[ChecklistService - checklistJaRespondido] Buscando checklist preenchido para atividade $atividadeId');
      final checklistPreenchido =
          await checklistRepository.buscarChecklistPreenchido(atividadeId);
      if (checklistPreenchido == null) {
        AppLogger.d(
            '[ChecklistService - checklistJaRespondido] Não encontrei checklist preenchido para atividade $atividadeId');
        return false;
      }
      AppLogger.d(
          '[ChecklistService - checklistJaRespondido] Encontrei checklist preenchido para atividade $atividadeId');
      return true;
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[ChecklistService - checklistJaRespondido] ${erro.mensagem}',
          error: e, stackTrace: s);
      return false;
    }
  }

  Future<List<EquipamentoTableDto>> buscarEquipamentos(String sub) {
    try {
      return equipamentoRepository.buscarEquipamentosPorSubestacao(sub);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[ChecklistService - buscarEquipamentos] ${erro.mensagem}',
          error: e, stackTrace: s);
      return Future.value(<EquipamentoTableDto>[]);
    }
  }

  Future<int> criarChecklistPreenchido(
      String atividadeId, String checklistId) async {
    try {
      final dto = ChecklistPreenchidoTableDto(
        atividadeId: atividadeId,
        checklistId: checklistId,
        dataPreenchimento: DateTime.now(),
        usuarioId: Get.find<SessionManager>().usuario!.uuid,
      );
      final id = await checklistRepository.criarChecklistPreenchido(dto);
      AppLogger.d('[ChecklistService] Checklist preenchido criado: $id');
      return id;
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[ChecklistService - criarChecklistPreenchido] ${erro.mensagem}',
          tag: 'ChecklistService',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }

  Future<void> atualizarDataPreenchimentoChecklistPreenchido(
      int checklistPreenchidoId, DateTime dataFinal) async {
    try {
      await checklistRepository.atualizarDataPreenchimento(
          checklistPreenchidoId, dataFinal);
      AppLogger.d(
          '[ChecklistService] Data de preenchimento atualizada para checklist $checklistPreenchidoId');
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[ChecklistService - atualizarDataPreenchimento] ${erro.mensagem}',
          tag: 'ChecklistService',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }

  Future<void> deletarChecklistPreenchido(int checklistPreenchidoId) async {
    try {
      await checklistRepository
          .deletarChecklistPreenchido(checklistPreenchidoId);
      AppLogger.d(
          '[ChecklistService] Checklist preenchido $checklistPreenchidoId deletado');
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[ChecklistService - deletarChecklistPreenchido] ${erro.mensagem}',
          tag: 'ChecklistService',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }
}
