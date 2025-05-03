import 'package:sympla_app/core/domain/repositories/mp_dj/prev_disj_form_repository.dart';
import 'package:sympla_app/core/domain/repositories/mp_dj/medicao_pressao_sf6_repository.dart';
import 'package:sympla_app/core/domain/repositories/mp_dj/medicao_resistencia_contato_repository.dart';
import 'package:sympla_app/core/domain/repositories/mp_dj/medicao_resistencia_isolamento_repository.dart';
import 'package:sympla_app/core/domain/repositories/mp_dj/medicao_tempo_operacao_repository.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/app_database.dart';

class MpDjFormService {
  final PrevDisjFormRepository formRepository;
  final MedicaoPressaoSf6Repository pressaoSf6Repository;
  final MedicaoResistenciaContatoRepository resistenciaContatoRepository;
  final MedicaoResistenciaIsolamentoRepository resistenciaIsolamentoRepository;
  final MedicaoTempoOperacaoRepository tempoOperacaoRepository;

  MpDjFormService({
    required this.formRepository,
    required this.pressaoSf6Repository,
    required this.resistenciaContatoRepository,
    required this.resistenciaIsolamentoRepository,
    required this.tempoOperacaoRepository,
  });

  // ================== FORMULÁRIO PRINCIPAL ==================
  Future<PrevDisjFormData?> buscarFormulario(int atividadeId) async {
    try {
      AppLogger.d(
          '[MpDjFormService] Buscando formulário da atividade $atividadeId');
      return await formRepository.getByAtividadeId(atividadeId);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[MpDjFormService] Erro ao buscar formulário: ${erro.mensagem}',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }

  Future<int> salvarFormulario(PrevDisjFormCompanion dados) async {
    try {
      AppLogger.d('[MpDjFormService] Salvando formulário base');
      return await formRepository.insert(dados);
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
  Future<List<MedicaoPressaoSf6TableData>> buscarPressaoSf6(
      int formularioId) async {
    try {
      AppLogger.d(
          '[MpDjFormService] Buscando medições de pressão SF6 (formId: $formularioId)');
      return await pressaoSf6Repository.getByFormularioId(formularioId);
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
      int formularioId, List<MedicaoPressaoSf6TableCompanion> entradas) async {
    try {
      AppLogger.d(
          '[MpDjFormService] Salvando ${entradas.length} medições de pressão SF6');
      await pressaoSf6Repository.deleteByFormularioId(formularioId);
      await pressaoSf6Repository.insertAll(entradas);
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
  Future<List<MedicaoResistenciaContatoTableData>> buscarResistenciaContato(
      int formularioId) async {
    try {
      AppLogger.d(
          '[MpDjFormService] Buscando medições de resistência de contato');
      return await resistenciaContatoRepository.getByFormularioId(formularioId);
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
      List<MedicaoResistenciaContatoTableCompanion> entradas) async {
    try {
      AppLogger.d(
          '[MpDjFormService] Salvando ${entradas.length} medições de resistência de contato');
      await resistenciaContatoRepository.deleteByFormularioId(formularioId);
      await resistenciaContatoRepository.insertAll(entradas);
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
  Future<List<MedicaoResistenciaIsolamentoTableData>>
      buscarResistenciaIsolamento(int formularioId) async {
    try {
      AppLogger.d(
          '[MpDjFormService] Buscando medições de resistência de isolamento');
      return await resistenciaIsolamentoRepository
          .getByFormularioId(formularioId);
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
      List<MedicaoResistenciaIsolamentoTableCompanion> entradas) async {
    try {
      AppLogger.d(
          '[MpDjFormService] Salvando ${entradas.length} medições de resistência de isolamento');
      await resistenciaIsolamentoRepository.deleteByFormularioId(formularioId);
      await resistenciaIsolamentoRepository.insertAll(entradas);
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
  Future<List<MedicaoTempoOperacaoTableData>> buscarTempoOperacao(
      int formularioId) async {
    try {
      AppLogger.d('[MpDjFormService] Buscando medições de tempo de operação');
      return await tempoOperacaoRepository.getByFormularioId(formularioId);
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
      List<MedicaoTempoOperacaoTableCompanion> entradas) async {
    try {
      AppLogger.d(
          '[MpDjFormService] Salvando ${entradas.length} medições de tempo de operação');
      await tempoOperacaoRepository.deleteByFormularioId(formularioId);
      await tempoOperacaoRepository.insertAll(entradas);
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
