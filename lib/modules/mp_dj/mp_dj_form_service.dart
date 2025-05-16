import 'package:sympla_app/core/domain/dto/mpdj/medicao_pressao_sf6_table_dto.dart';
import 'package:sympla_app/core/domain/dto/mpdj/medicao_resistencia_contato_table_dto.dart';
import 'package:sympla_app/core/domain/dto/mpdj/medicao_resistencia_isolamento_table_dto.dart';
import 'package:sympla_app/core/domain/dto/mpdj/medicao_tempo_operacao_table_dto.dart';
import 'package:sympla_app/core/domain/dto/mpdj/prev_disj_form_table_dto.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/mpdj_repository.dart';

class MpDjFormService {
  final MpDjRepository repository;

  MpDjFormService({
    required this.repository,
  });

  // ================== FORMULÁRIO PRINCIPAL ==================
  Future<PrevDisjFormTableDto?> buscarFormulario(String atividadeId) async {
    try {
      AppLogger.d(
          '[MpDjFormService] Buscando formulário da atividade $atividadeId');
      return await repository.getByAtividadeId(atividadeId);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[MpDjFormService] Erro ao buscar formulário: ${erro.mensagem}',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }

  Future<int> salvarFormulario(PrevDisjFormTableDto dados) async {
    try {
      AppLogger.d('[MpDjFormService] Salvando formulário base');
      return await repository.insert(dados);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[MpDjFormService] Erro ao salvar formulário: ${erro.mensagem}',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }

  // ================== PRESSÃO SF6 ==================
  Future<List<MedicaoPressaoSf6TableDto>> buscarPressaoSf6(
      int formularioId) async {
    try {
      AppLogger.d(
          '[MpDjFormService] Buscando medições de pressão SF6 (formId: $formularioId)');
      return await repository.getPressaoSf6ByFormularioId(formularioId);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[MpDjFormService] Erro ao buscar pressão SF6: ${erro.mensagem}',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }

  Future<void> salvarPressaoSf6(
      int formularioId, List<MedicaoPressaoSf6TableDto> entradas) async {
    try {
      AppLogger.d(
          '[MpDjFormService] Salvando ${entradas.length} medições de pressão SF6');
      await repository.deletePressaoSf6ByFormularioId(formularioId);
      await repository.insertPressaoSf6(entradas);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[MpDjFormService] Erro ao salvar pressão SF6: ${erro.mensagem}',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }

  // ================== RESISTÊNCIA DE CONTATO ==================
  Future<List<MedicaoResistenciaContatoTableDto>> buscarResistenciaContato(
      int formularioId) async {
    try {
      AppLogger.d(
          '[MpDjFormService] Buscando medições de resistência de contato');
      return await repository.getResistenciaContatoByFormularioId(formularioId);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[MpDjFormService] Erro ao buscar resistência de contato: ${erro.mensagem}',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }

  Future<void> salvarResistenciaContato(int formularioId,
      List<MedicaoResistenciaContatoTableDto> entradas) async {
    try {
      AppLogger.d(
          '[MpDjFormService] Salvando ${entradas.length} medições de resistência de contato');
      await repository.deleteResistenciaContatoByFormularioId(formularioId);
      await repository.insertResistenciaContato(entradas);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[MpDjFormService] Erro ao salvar resistência de contato: ${erro.mensagem}',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }

  // ================== RESISTÊNCIA DE ISOLAMENTO ==================
  Future<List<MedicaoResistenciaIsolamentoTableDto>>
      buscarResistenciaIsolamento(int formularioId) async {
    try {
      AppLogger.d(
          '[MpDjFormService] Buscando medições de resistência de isolamento');
      return await repository
          .getResistenciaIsolamentoByFormularioId(formularioId);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[MpDjFormService] Erro ao buscar resistência de isolamento: ${erro.mensagem}',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }

  Future<void> salvarResistenciaIsolamento(int formularioId,
      List<MedicaoResistenciaIsolamentoTableDto> entradas) async {
    try {
      AppLogger.d(
          '[MpDjFormService] Salvando ${entradas.length} medições de resistência de isolamento');
      await repository.deleteResistenciaIsolamentoByFormularioId(formularioId);
      await repository.insertResistenciaIsolamento(entradas);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[MpDjFormService] Erro ao salvar resistência de isolamento: ${erro.mensagem}',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }

  // ================== TEMPO DE OPERAÇÃO ==================
  Future<List<MedicaoTempoOperacaoTableDto>> buscarTempoOperacao(
      int formularioId) async {
    try {
      AppLogger.d('[MpDjFormService] Buscando medições de tempo de operação');
      return await repository.getTempoOperacaoByFormularioId(formularioId);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[MpDjFormService] Erro ao buscar tempo de operação: ${erro.mensagem}',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }

  Future<void> salvarTempoOperacao(int formularioId,
      List<MedicaoTempoOperacaoTableDto> entradas) async {
    try {
      AppLogger.d(
          '[MpDjFormService] Salvando ${entradas.length} medições de tempo de operação');
      await repository.deleteTempoOperacaoByFormularioId(formularioId);
      await repository.insertTempoOperacao(entradas);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[MpDjFormService] Erro ao salvar tempo de operação: ${erro.mensagem}',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }
}
