import 'package:sympla_app/core/domain/dto/sync/anomalias_sync_dto.dart';
import 'package:sympla_app/core/domain/dto/sync/apr_sync_dto.dart';
import 'package:sympla_app/core/domain/dto/sync/atividade_sync_dto.dart';
import 'package:sympla_app/core/domain/dto/sync/checklist_sync_dto.dart';
import 'package:sympla_app/core/domain/dto/sync/mpbb_sync_dto.dart';
import 'package:sympla_app/core/domain/dto/sync/mpdj_sync_dto.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/anomalia_repository.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/apr_repository.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/atividade_repository.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/checklist_repository.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/mpbb_repository.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/mpdj_repository.dart';
import 'package:sympla_app/core/logger/app_logger.dart';

/// 🔄 Serviço de upload
///
/// Responsabilidades:
/// - Monta o AtividadeSyncDto completo
/// - Gerencia a montagem de dados relacionados
/// - Trata erros de montagem
class UploadService {
  final AtividadeRepository _atividadeRepository;
  final ChecklistRepository _checklistRepository;
  final AprRepository _aprRepository;
  final AnomaliaRepository _anomaliaRepository;
  final MpDjRepository _mpdjRepository;
  final MpbbRepository _mpbbRepository;

  UploadService({
    required AtividadeRepository atividadeRepository,
    required ChecklistRepository checklistRepository,
    required AprRepository aprRepository,
    required AnomaliaRepository anomaliaRepository,
    required MpDjRepository mpdjRepository,
    required MpbbRepository mpbbRepository,
  })  : _atividadeRepository = atividadeRepository,
        _checklistRepository = checklistRepository,
        _aprRepository = aprRepository,
        _anomaliaRepository = anomaliaRepository,
        _mpdjRepository = mpdjRepository,
        _mpbbRepository = mpbbRepository;

  /// Monta o AtividadeSyncDto completo com todos os dados correlatos
  Future<AtividadeSyncDto?> montarAtividadeSync(String atividadeId) async {
    try {
      AppLogger.d('🔧 Montando AtividadeSyncDto para atividade: $atividadeId');

      // 1. Buscar atividade principal
      final atividade = await _atividadeRepository.buscarAtividade(atividadeId);
      if (atividade == null) {
        AppLogger.e('❌ Atividade não encontrada: $atividadeId');
        return null;
      }

      // 2. Criar DTO base
      final atividadeSync = AtividadeSyncDto.fromAtividadeDto(atividade);

      // 3. Buscar e adicionar checklist
      final checklistSync = await _montarChecklistSync(atividadeId);

      // 4. Buscar e adicionar APR
      final aprSync = await _montarAprSync(atividadeId);

      // 5. Buscar e adicionar anomalias
      final anomaliasSync = await _montarAnomaliasSync(atividadeId);

      // 6. Buscar e adicionar MPDJ
      final mpdjSync = await _montarMpdjSync(atividadeId);

      // 7. Buscar e adicionar MPBB
      final mpbbSync = await _montarMpbbSync(atividadeId);

      // 8. Montar DTO completo
      final atividadeCompleta = atividadeSync.copyWith(
        checklist: checklistSync,
        apr: aprSync,
        anomalias: anomaliasSync,
        mpdj: mpdjSync,
        mpbb: mpbbSync,
      );

      AppLogger.d('✅ AtividadeSyncDto montado com sucesso para: $atividadeId');
      return atividadeCompleta;
    } catch (e, s) {
      AppLogger.e('❌ Erro ao montar AtividadeSyncDto para $atividadeId', error: e, stackTrace: s);
      return null;
    }
  }

  /// Monta o ChecklistSyncDto
  Future<ChecklistSyncDto?> _montarChecklistSync(String atividadeId) async {
    try {
      // Buscar checklist preenchido
      final checklistPreenchido = await _checklistRepository.buscarChecklistPreenchido(atividadeId);
      if (checklistPreenchido == null) return null;

      // Buscar respostas usando o ID do checklist preenchido
      final respostas = await _checklistRepository.buscarRespostas(checklistPreenchido.id!);

      return ChecklistSyncDto.fromChecklistPreenchidoDto(checklistPreenchido, respostas);
    } catch (e, s) {
      AppLogger.e('❌ Erro ao montar ChecklistSyncDto', error: e, stackTrace: s);
      return null;
    }
  }

  /// Monta o AprSyncDto
  Future<AprSyncDto?> _montarAprSync(String atividadeId) async {
    try {
      // Buscar APR preenchida
      final aprPreenchida = await _aprRepository.buscarAprPreenchida(atividadeId);
      if (aprPreenchida == null) return null;

      // Buscar respostas
      final respostas = await _aprRepository.buscarRespostas(aprPreenchida.id!);

      // Buscar assinaturas
      final assinaturas = await _aprRepository.buscarAssinaturas(aprPreenchida.id!);

      return AprSyncDto.fromAprPreenchidaDto(aprPreenchida, respostas, assinaturas);
    } catch (e, s) {
      AppLogger.e('❌ Erro ao montar AprSyncDto', error: e, stackTrace: s);
      return null;
    }
  }

  /// Monta a lista de AnomaliaSyncDto
  Future<List<AnomaliaSyncDto>> _montarAnomaliasSync(String atividadeId) async {
    try {
      // Buscar anomalias
      final anomalias = await _anomaliaRepository.buscarAnomaliasPorAtividade(atividadeId);

      return anomalias.map(AnomaliaSyncDto.fromAnomaliaDto).toList();
    } catch (e, s) {
      AppLogger.e('❌ Erro ao montar AnomaliasSyncDto', error: e, stackTrace: s);
      return [];
    }
  }

  /// Monta o MpDjSyncDto
  Future<MpDjSyncDto?> _montarMpdjSync(String atividadeId) async {
    try {
      // Buscar formulário principal
      final formulario = await _mpdjRepository.getByAtividadeId(atividadeId);
      if (formulario == null) return null;

      // Buscar medições
      final medicoesContato =
          await _mpdjRepository.getResistenciaContatoByFormularioId(formulario.id!);
      final medicoesIsolamento =
          await _mpdjRepository.getResistenciaIsolamentoByFormularioId(formulario.id!);
      final medicoesPressao = await _mpdjRepository.getPressaoSf6ByFormularioId(formulario.id!);
      final medicoesTempo = await _mpdjRepository.getTempoOperacaoByFormularioId(formulario.id!);

      return MpDjSyncDto.fromMpdjFormDto(
        formulario,
        medicoesContato,
        medicoesIsolamento,
        medicoesPressao,
        medicoesTempo,
      );
    } catch (e, s) {
      AppLogger.e('❌ Erro ao montar MpDjSyncDto', error: e, stackTrace: s);
      return null;
    }
  }

  /// Monta o MpBbSyncDto
  Future<MpBbSyncDto?> _montarMpbbSync(String atividadeId) async {
    try {
      // Buscar formulário principal
      final formulario = await _mpbbRepository.buscarFormulario(atividadeId);
      if (formulario == null) return null;

      // Buscar medições de elementos
      final medicoesElementos = await _mpbbRepository.getByFormularioId(formulario.id!);

      return MpBbSyncDto.fromFormularioBateriaDto(formulario, medicoesElementos);
    } catch (e, s) {
      AppLogger.e('❌ Erro ao montar MpBbSyncDto', error: e, stackTrace: s);
      return null;
    }
  }
}
