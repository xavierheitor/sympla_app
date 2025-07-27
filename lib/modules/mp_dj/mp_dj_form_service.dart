import 'package:sympla_app/core/domain/dto/mpdj/medicao_pressao_sf6_table_dto.dart';
import 'package:sympla_app/core/domain/dto/mpdj/medicao_resistencia_contato_table_dto.dart';
import 'package:sympla_app/core/domain/dto/mpdj/medicao_resistencia_isolamento_table_dto.dart';
import 'package:sympla_app/core/domain/dto/mpdj/medicao_tempo_operacao_table_dto.dart';
import 'package:sympla_app/core/domain/dto/mpdj/prev_disj_form_table_dto.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/mpdj_repository.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';

/// 🚀 Service que abstrai operações sobre o formulário MPDJ e suas medições.
///
/// Responsabilidades:
/// - Busca o formulário de uma atividade
/// - Salva o formulário de disjuntores
/// - Deleta o formulário de disjuntores
/// - Busca as medições de um formulário
class MpDjFormService {
  final MpDjRepository repository;

  MpDjFormService({required this.repository});

  // ================== 🔍 FORMULÁRIO ==================
  Future<MpdjFormTableDto?> buscarFormulario(String atividadeId) {
    return _executar(() {
      return repository.getByAtividadeId(atividadeId);
    }, '[Form] buscarFormulario');
  }

  Future<int> salvarFormulario(MpdjFormTableDto dados) {
    return _executar(() {
      return repository.insert(dados);
    }, '[Form] salvarFormulario');
  }

  // ================== 🔍 PRESSÃO SF6 ==================
  Future<List<MedicaoPressaoSf6TableDto>> buscarPressaoSf6(int formularioId) {
    return _executar(() {
      return repository.getPressaoSf6ByFormularioId(formularioId);
    }, '[SF6] buscar');
  }

  Future<void> salvarPressaoSf6(
      int formularioId, List<MedicaoPressaoSf6TableDto> entradas) {
    return _executar(() async {
      await repository.deletePressaoSf6ByFormularioId(formularioId);
      await repository.insertPressaoSf6(entradas);
    }, '[SF6] salvar');
  }

  // ================== 🔍 RESISTÊNCIA CONTATO ==================
  Future<List<MedicaoResistenciaContatoTableDto>> buscarResistenciaContato(
      int formularioId) {
    return _executar(() {
      return repository.getResistenciaContatoByFormularioId(formularioId);
    }, '[ResistenciaContato] buscar');
  }

  Future<void> salvarResistenciaContato(
      int formularioId, List<MedicaoResistenciaContatoTableDto> entradas) {
    return _executar(() async {
      await repository.deleteResistenciaContatoByFormularioId(formularioId);
      await repository.insertResistenciaContato(entradas);
    }, '[ResistenciaContato] salvar');
  }

  // ================== 🔍 RESISTÊNCIA ISOLAMENTO ==================
  Future<List<MedicaoResistenciaIsolamentoTableDto>>
      buscarResistenciaIsolamento(int formularioId) {
    return _executar(() {
      return repository.getResistenciaIsolamentoByFormularioId(formularioId);
    }, '[Isolamento] buscar');
  }

  Future<void> salvarResistenciaIsolamento(
      int formularioId, List<MedicaoResistenciaIsolamentoTableDto> entradas) {
    return _executar(() async {
      await repository.deleteResistenciaIsolamentoByFormularioId(formularioId);
      await repository.insertResistenciaIsolamento(entradas);
    }, '[Isolamento] salvar');
  }

  // ================== 🔍 TEMPO OPERAÇÃO ==================
  Future<List<MedicaoTempoOperacaoTableDto>> buscarTempoOperacao(
      int formularioId) {
    return _executar(() {
      return repository.getTempoOperacaoByFormularioId(formularioId);
    }, '[Tempo] buscar');
  }

  Future<void> salvarTempoOperacao(
      int formularioId, List<MedicaoTempoOperacaoTableDto> entradas) {
    return _executar(() async {
      await repository.deleteTempoOperacaoByFormularioId(formularioId);
      await repository.insertTempoOperacao(entradas);
    }, '[Tempo] salvar');
  }

  // ================== 🔧 Handler ==================
  Future<T> _executar<T>(Future<T> Function() callback, String tag) async {
    try {
      AppLogger.d('[MpDjFormService] $tag');
      return await callback();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[MpDjFormService] Erro $tag: ${erro.mensagem}',
          error: e, stackTrace: s);
      rethrow;
    }
  }
}
