import 'package:sympla_app/core/domain/dto/mpbb/formulario_bateria_table_dto.dart';
import 'package:sympla_app/core/domain/dto/mpbb/medicao_elemento_table_dto.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/mpbb_repository.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';

/// 🔥 Service responsável pela orquestração das operações do formulário MPBB
class MpBbFormService {
  final MpbbRepository mpbbRepository;

  MpBbFormService({required this.mpbbRepository});

  // ---------------------------------------------------------------------------
  // 🗂️ FORMULÁRIO
  // ---------------------------------------------------------------------------

  /// 🔍 Busca o formulário de uma atividade.
  Future<FormularioBateriaTableDto?> buscarPorAtividade(
      String atividadeId) async {
    try {
      return await mpbbRepository.buscarFormulario(atividadeId);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[MpBbFormService - buscarPorAtividade] ${erro.mensagem}',
          error: e, stackTrace: s);
      rethrow;
    }
  }

  /// 🔍 Busca as medições de um formulário pelo ID.
  Future<List<MedicaoElementoMpbbTableDto>> buscarMedicoes(
      int formularioId) async {
    try {
      return await mpbbRepository.getByFormularioId(formularioId);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[MpBbFormService - buscarMedicoes] ${erro.mensagem}',
          error: e, stackTrace: s);
      rethrow;
    }
  }

  /// 💾 Salva um formulário e suas medições associadas.
  ///
  /// ⚠️ Se já houver um formulário para essa atividade, ele será deletado antes.
  Future<void> salvarFormulario(
    FormularioBateriaTableDto formulario,
    List<MedicaoElementoMpbbTableDto> medicoes,
  ) async {
    try {
      AppLogger.d(
          '[MpBbFormService] Salvando formulário da atividade ${formulario.atividadeId} e ${medicoes.length} medições.');

      // 🔥 Remove dados antigos para garantir consistência.
      await mpbbRepository.deleteByAtividadeId(formulario.atividadeId);

      // 💾 Salva o formulário.
      await mpbbRepository.salvarFormulario(formulario);

      // 💾 Salva as medições associadas.
      await mpbbRepository.insertAll(medicoes);

      AppLogger.d(
          '[MpBbFormService] Formulário e medições salvos com sucesso.');
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[MpBbFormService - salvarFormulario] ${erro.mensagem}',
          error: e, stackTrace: s);
      rethrow;
    }
  }

  /// 🗑️ Deleta o formulário vinculado à atividade.
  Future<void> deletarFormulario(String atividadeId) async {
    try {
      AppLogger.d(
          '[MpBbFormService] Deletando formulário da atividade $atividadeId');
      await mpbbRepository.deleteByAtividadeId(atividadeId);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[MpBbFormService - deletarFormulario] ${erro.mensagem}',
          error: e, stackTrace: s);
      rethrow;
    }
  }
}
