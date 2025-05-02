// resumo_anomalias_service.dart
import 'package:sympla_app/core/domain/repositories/checklist/anomalia_repository.dart';
import 'package:sympla_app/core/domain/repositories/checklist/defeito_repository.dart';
import 'package:sympla_app/core/domain/repositories/equipamento_repository.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/app_database.dart';

class ResumoAnomaliasService {
  final AnomaliaRepository anomaliaRepository;
  final EquipamentoRepository equipamentoRepository;
  final DefeitoRepository defeitoRepository;

  ResumoAnomaliasService({
    required this.anomaliaRepository,
    required this.equipamentoRepository,
    required this.defeitoRepository,
  });

  Future<List<AnomaliaTableData>> buscarAnomaliasPorAtividade(
      int atividadeId) async {
    try {
      AppLogger.d(
          '[ResumoAnomaliasService] Buscando anomalias da atividade $atividadeId');
      return await anomaliaRepository.getByAtividadeId(atividadeId);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[ResumoAnomaliasService - buscarAnomaliasPorAtividade] ${erro.mensagem}',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }

  Future<void> removerAnomalia(int id) async {
    try {
      AppLogger.d('[ResumoAnomaliasService] Removendo anomalia id=$id');
      await anomaliaRepository.deleteById(id);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[ResumoAnomaliasService - removerAnomalia] ${erro.mensagem}',
          error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<void> concluirAtividade() async {
    // TODO: implementar lógica para concluir a atividade
    AppLogger.d('[ResumoAnomaliasService] Concluir atividade chamado');
  }

  Future<List<EquipamentoTableData>> buscarEquipamentos(
      String subestacao) async {
    try {
      return await equipamentoRepository.buscarPorSubestacao(subestacao);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[ResumoAnomaliasService - buscarEquipamentos] ${erro.mensagem}',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }

  Future<List<DefeitoTableData>> buscarDefeitos(
      EquipamentoTableData equipamento) async {
    try {
      return await defeitoRepository.buscarPorEquipamento(equipamento);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[ResumoAnomaliasService - buscarDefeitos] ${erro.mensagem}',
          error: e, stackTrace: s);
      rethrow;
    }
  }

  atualizarAnomalia(AnomaliaTableCompanion anomalia) {
    AppLogger.d(
        '[ResumoAnomaliasService - atualizarAnomalia] FALTA IMPLEMENTAR $anomalia');
  }

  salvarAnomalia(AnomaliaTableCompanion anomalia) {
    AppLogger.d(
        '[ResumoAnomaliasService - salvarAnomalia] FALTA IMPLEMENTAR $anomalia');
  }
}
