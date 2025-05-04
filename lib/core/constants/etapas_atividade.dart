import 'package:sympla_app/core/constants/tipo_atividade_mobile.dart';

enum EtapaAtividade {
  apr,
  checklist,
  resumoAnomalias,
  mpBbForm,
  mpDjForm,
  finalizada,
  // Adicione outras etapas conforme necessário
}

final Map<EtapaAtividade, bool> etapasSempreMostram = {
  EtapaAtividade.apr: true,
  EtapaAtividade.checklist: true,
  EtapaAtividade.resumoAnomalias: true, // ✅ Sempre aparece
  EtapaAtividade.mpBbForm: false,
  EtapaAtividade.mpDjForm: false,
  EtapaAtividade.finalizada: true,
};

final Map<TipoAtividadeMobile, List<EtapaAtividade>> fluxoPorTipoAtividade = {
  TipoAtividadeMobile.ivItIu: [
    EtapaAtividade.apr,
    EtapaAtividade.checklist,
    EtapaAtividade.resumoAnomalias,
    EtapaAtividade.finalizada,
  ],
  TipoAtividadeMobile.prevBcBat: [
    EtapaAtividade.apr,
    EtapaAtividade.checklist,
    EtapaAtividade.resumoAnomalias,
    EtapaAtividade.mpBbForm,
    EtapaAtividade.finalizada,
  ],
  TipoAtividadeMobile.prevDisjuntor: [
    EtapaAtividade.apr,
    EtapaAtividade.checklist,
    EtapaAtividade.resumoAnomalias,
    EtapaAtividade.mpDjForm,
    EtapaAtividade.finalizada,
  ],
  // Adicione outros tipos conforme necessário
};
