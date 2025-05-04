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
