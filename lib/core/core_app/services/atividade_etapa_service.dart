import 'package:get/get.dart';
import 'package:sympla_app/core/constants/etapas_atividade.dart';
import 'package:sympla_app/core/constants/route_names.dart';
import 'package:sympla_app/core/constants/tipo_atividade_mobile.dart';
import 'package:sympla_app/core/domain/dto/atividade/atividade_table_dto.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/atividade_repository.dart';
import 'package:sympla_app/core/logger/app_logger.dart';

class AtividadeEtapaService {
  final AtividadeRepository atividadeRepository;

  AtividadeEtapaService(this.atividadeRepository);

  /// 🔍 Retorna o tipoAtividadeMobile da atividade
  Future<TipoAtividadeMobile> tipoAtividadeMobileDo(
      AtividadeTableDto atividade) async {
    final tipo = await atividadeRepository
        .buscarTipoAtividadePorAtividadeId(atividade.uuid);
    final tipoResult = tipo?.tipoAtividadeMobile ?? TipoAtividadeMobile.ivItIu;
    AppLogger.d('🔍 TipoAtividadeMobile: $tipoResult', tag: 'EtapaService');
    return tipoResult;
  }

  /// 🚀 Retorna a etapa inicial do fluxo
  Future<EtapaAtividade> etapaInicial(AtividadeTableDto atividade) async {
    final tipo = await tipoAtividadeMobileDo(atividade);
    final fluxo = fluxoPorTipoAtividade[tipo];
    if (fluxo == null || fluxo.isEmpty) {
      throw Exception('🚫 Nenhum fluxo definido para o tipo $tipo');
    }
    AppLogger.d('🎯 Etapa inicial: ${fluxo.first}', tag: 'EtapaService');
    return fluxo.first;
  }

  /// ➡️ Retorna a próxima etapa, ou null se acabou
  Future<EtapaAtividade?> proximaEtapa(
      AtividadeTableDto atividade, EtapaAtividade atual) async {
    final tipo = await tipoAtividadeMobileDo(atividade);
    final fluxo = fluxoPorTipoAtividade[tipo] ?? [];
    final idx = fluxo.indexOf(atual);
    final proxima =
        (idx >= 0 && idx + 1 < fluxo.length) ? fluxo[idx + 1] : null;
    AppLogger.d('🔄 Próxima etapa após $atual: ${proxima ?? "finalizada"}',
        tag: 'EtapaService');
    return proxima;
  }

  /// 🎯 Executa a etapa atual (com navegação)
  Future<void> executar(
      AtividadeTableDto atividade, EtapaAtividade etapa) async {
    AppLogger.d('🚀 Executando etapa: $etapa', tag: 'EtapaService');

    final sempreMostra = etapasSempreMostram[etapa] ?? false;
    if (!sempreMostra) {
      final pular = await desejaPularEtapa(etapa);
      if (pular) {
        AppLogger.d('⏭️ Etapa pulada: $etapa', tag: 'EtapaService');
        return;
      }
    }

    switch (etapa) {
      case EtapaAtividade.apr:
        Get.toNamed(Routes.apr);
        break;
      case EtapaAtividade.checklist:
        Get.toNamed(Routes.checklist);
        break;
      case EtapaAtividade.resumoAnomalias:
        Get.toNamed(Routes.resumoAnomalias);
        break;
      case EtapaAtividade.mpBbForm:
        Get.toNamed(Routes.mpBbForm);
        break;
      case EtapaAtividade.mpDjForm:
        Get.toNamed(Routes.mpDjForm);
        break;
      case EtapaAtividade.finalizada:
        AppLogger.d('✅ Atividade finalizada.', tag: 'EtapaService');
        break;
    }
  }

  /// 🔧 Define se deve pular etapa (poderá futuramente abrir dialog, config, etc)
  Future<bool> desejaPularEtapa(EtapaAtividade etapa) async {
    AppLogger.d('🤔 Verificando se deve pular etapa $etapa',
        tag: 'EtapaService');
    return false;
  }
}
