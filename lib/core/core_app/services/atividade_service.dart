// lib/modules/atividade/atividade_service.dart
import 'package:get/get.dart';
import 'package:sympla_app/core/constants/etapas_atividade.dart';
import 'package:sympla_app/core/constants/route_names.dart';
import 'package:sympla_app/core/constants/tipo_atividade_mobile.dart';
import 'package:sympla_app/core/domain/dto/atividade/atividade_table_dto.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/atividade_repository.dart';

class AtividadeService {
  final AtividadeRepository atividadeRepository;

  AtividadeService(this.atividadeRepository);

  Future<void> iniciar(AtividadeTableDto atividade) async {
    await atividadeRepository.iniciarAtividade(atividade);
  }

  Future<void> finalizar(AtividadeTableDto atividade) async {
    await atividadeRepository.finalizarAtividade(atividade);
  }

  Future<TipoAtividadeMobile> tipoAtividadeMobileDo(
      AtividadeTableDto atividade) async {
    final tipo = await atividadeRepository
        .buscarTipoAtividadePorAtividadeId(atividade.uuid);
    return tipo?.tipoAtividadeMobile ?? TipoAtividadeMobile.ivItIu;
  }

  Future<EtapaAtividade?> proximaEtapa(
      AtividadeTableDto atividade, EtapaAtividade atual) async {
    final tipo = await tipoAtividadeMobileDo(atividade);
    final fluxo = fluxoPorTipoAtividade[tipo] ?? [];
    final idx = fluxo.indexOf(atual);
    return (idx >= 0 && idx + 1 < fluxo.length) ? fluxo[idx + 1] : null;
  }

  Future<void> executar(
      AtividadeTableDto atividade, EtapaAtividade etapa) async {
    AppLogger.d('➡️ Executando etapa: $etapa', tag: 'AtividadeService');

    final sempreMostra = etapasSempreMostram[etapa] ?? false;
    if (!sempreMostra) {
      final pular = await desejaPularEtapa(etapa);
      if (pular) {
        AppLogger.d('⏭️ Etapa pulada: $etapa', tag: 'AtividadeService');
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
        await finalizar(atividade);
        break;
    }
  }

  Future<bool> desejaPularEtapa(EtapaAtividade etapa) async {
    return false;
  }

  buscarComEquipamento() {
    return atividadeRepository.buscarAtividadesComEquipamento();
  }

  sincronizar() {}

  buscarAtividadeEmAndamento() {
    return atividadeRepository.buscarAtividadeEmAndamento();
  }

Future<EtapaAtividade> etapaInicial(AtividadeTableDto atividade) async {
    final tipo = await tipoAtividadeMobileDo(atividade);
    final fluxo = fluxoPorTipoAtividade[tipo];
    if (fluxo == null || fluxo.isEmpty) {
      throw Exception('Nenhum fluxo definido para o tipo de atividade $tipo');
    }
    return fluxo.first;
  }

Future<void> navegarParaEtapa(EtapaAtividade etapa) async {
    AppLogger.d('🔀 Navegando para etapa: $etapa', tag: 'AtividadeService');

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
        // ⚠️ Deve ser tratado no controller.
        break;
    }
  }
}
