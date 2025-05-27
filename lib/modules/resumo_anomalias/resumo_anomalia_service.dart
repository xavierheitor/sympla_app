
import 'package:sympla_app/core/domain/dto/anomalia/anomalia_table_dto.dart';
import 'package:sympla_app/core/domain/dto/grupo_defeito_equipamento/defeito_table_dto.dart';
import 'package:sympla_app/core/domain/dto/grupo_defeito_equipamento/equipamento_table_dto.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/anomalia_repository.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/defeito_repository.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/equipamento_repository.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';

class ResumoAnomaliasService {
  final AnomaliaRepository anomaliaRepository;
  final EquipamentoRepository equipamentoRepository;
  final DefeitoRepository defeitoRepository;

  ResumoAnomaliasService({
    required this.anomaliaRepository,
    required this.equipamentoRepository,
    required this.defeitoRepository,
  });

  Future<List<AnomaliaTableDto>> buscarAnomaliasPorAtividade(
      String atividadeId) async {
    try {
      AppLogger.d(
          '[ResumoAnomaliasService] Buscando anomalias da atividade $atividadeId');
      final lista =
          await anomaliaRepository.buscarAnomaliasPorAtividade(atividadeId);
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

  Future<List<EquipamentoTableDto>> buscarEquipamentos(
      String subestacao) async {
    try {
      AppLogger.d(
          '[ResumoAnomaliasService] Buscando equipamentos da subestação: $subestacao');
      final lista = await equipamentoRepository
          .buscarEquipamentosPorSubestacao(subestacao);
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

  Future<List<DefeitoTableDto>> buscarDefeitos(
      EquipamentoTableDto equipamento) async {
    try {
      AppLogger.d(
          '[ResumoAnomaliasService] Buscando defeitos para equipamento ID: ${equipamento.uuid}, nome: ${equipamento.nome}');
      final lista = await defeitoRepository
          .buscarDefeitosPorEquipamentoCodigo(equipamento.grupoId);
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

  Future<void> salvarAnomalia(AnomaliaTableDto anomalia) async {
    try {
      AppLogger.d('[ResumoAnomaliasService] Salvando nova anomalia: $anomalia');
      await anomaliaRepository.salvarAnomalia(anomalia);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[ResumoAnomaliasService - salvarAnomalia] ${erro.mensagem}',
          error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<void> atualizarAnomalia(AnomaliaTableDto anomalia) async {
    try {
      AppLogger.d(
          '[ResumoAnomaliasService] Atualizando anomalia ID: ${anomalia.id}');
      await anomaliaRepository.salvarAnomalia(anomalia);
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
