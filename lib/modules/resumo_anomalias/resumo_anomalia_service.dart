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
      final lista = await anomaliaRepository.getByAtividadeId(atividadeId);
      AppLogger.d(
          '[ResumoAnomaliasService] ${lista.length} anomalias encontradas');
      return lista;
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
      AppLogger.d('[ResumoAnomaliasService] Removendo anomalia ID: $id');
      await anomaliaRepository.deleteById(id);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[ResumoAnomaliasService - removerAnomalia] ${erro.mensagem}',
          error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<List<EquipamentoTableData>> buscarEquipamentos(
      String subestacao) async {
    try {
      AppLogger.d(
          '[ResumoAnomaliasService] Buscando equipamentos da subestação: $subestacao');
      final lista = await equipamentoRepository.buscarPorSubestacao(subestacao);
      AppLogger.d(
          '[ResumoAnomaliasService] ${lista.length} equipamentos encontrados');
      return lista;
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
      AppLogger.d(
          '[ResumoAnomaliasService] Buscando defeitos para equipamento ID: ${equipamento.id}, nome: ${equipamento.nome}');
      final lista = await defeitoRepository.buscarPorEquipamento(equipamento);
      AppLogger.d(
          '[ResumoAnomaliasService] ${lista.length} defeitos encontrados');
      return lista;
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[ResumoAnomaliasService - buscarDefeitos] ${erro.mensagem}',
          error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<void> salvarAnomalia(AnomaliaTableCompanion anomalia) async {
    try {
      AppLogger.d('[ResumoAnomaliasService] Salvando nova anomalia: $anomalia');
      await anomaliaRepository.insert(anomalia);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[ResumoAnomaliasService - salvarAnomalia] ${erro.mensagem}',
          error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<void> atualizarAnomalia(AnomaliaTableCompanion anomalia) async {
    try {
      AppLogger.d(
          '[ResumoAnomaliasService] Atualizando anomalia ID: ${anomalia.id.value}');
      final dados = AnomaliaTableData(
        id: anomalia.id.value,
        perguntaId: anomalia.perguntaId.value,
        atividadeId: anomalia.atividadeId.value,
        equipamentoId: anomalia.equipamentoId.value,
        defeitoId: anomalia.defeitoId.value,
        fase: anomalia.fase.value,
        lado: anomalia.lado.value,
        delta: anomalia.delta.value,
        observacao: anomalia.observacao.value,
        foto: anomalia.foto.present ? anomalia.foto.value : null,
        corrigida: false,
      );
      await anomaliaRepository.update(dados);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
          '[ResumoAnomaliasService - atualizarAnomalia] ${erro.mensagem}',
          error: e,
          stackTrace: s);
      rethrow;
    }
  }

  Future<void> concluirAtividade(int atividadeId) async {
    // Caso precise implementar lógica futura, aqui vai a estrutura:
    AppLogger.d('[ResumoAnomaliasService] concluindo atividade $atividadeId');
  }
}
