import 'package:sympla_app/core/constants/tipo_atividade_mobile.dart';

/// 🎯 Enum que define todas as etapas possíveis de uma atividade
///
/// 🔧 COMO ADICIONAR NOVA ETAPA:
/// 1. Adicione o novo valor aqui
/// 2. Configure se é obrigatória em `etapasSempreMostram`
/// 3. Adicione no fluxo desejado em `fluxoPorTipoAtividade`
/// 4. Implemente a navegação em `AtividadeEtapaService.executar()`
/// 5. Crie a tela correspondente
enum EtapaAtividade {
  apr, // 📋 Análise Preliminar de Risco
  checklist, // ✅ Checklist de inspeção
  resumoAnomalias, // 🚨 Resumo de anomalias encontradas
  mpBbForm, // 🔋 Medições de baterias
  mpDjForm, // ⚡ Medições de disjuntores
  finalizada, // ✅ Atividade concluída
  // 🔧 ADICIONE NOVAS ETAPAS AQUI:
  // novaEtapa,           // 📝 Descrição da nova etapa
}

/// 🎛️ Define quais etapas são sempre mostradas (não podem ser puladas)
///
/// 🔧 COMO ALTERAR:
/// - `true`: Etapa sempre aparece (obrigatória)
/// - `false`: Etapa pode ser pulada (opcional)
///
/// 💡 DICA: Etapas opcionais podem ser puladas automaticamente
/// baseado em configurações ou dados existentes
final Map<EtapaAtividade, bool> etapasSempreMostram = {
  EtapaAtividade.apr: true, // ✅ Sempre aparece
  EtapaAtividade.checklist: true, // ✅ Sempre aparece
  EtapaAtividade.resumoAnomalias: true, // ✅ Sempre aparece
  EtapaAtividade.mpBbForm: false, // ⚠️ Pode ser pulada
  EtapaAtividade.mpDjForm: false, // ⚠️ Pode ser pulada
  EtapaAtividade.finalizada: true, // ✅ Sempre aparece
  // 🔧 ADICIONE NOVAS ETAPAS AQUI:
  // EtapaAtividade.novaEtapa: true,  // ✅ ou false
};

/// 🛣️ Define o fluxo de etapas para cada tipo de atividade
///
/// 🔧 COMO ALTERAR A ORDEM DAS ETAPAS:
/// 1. Reordene os itens na lista do tipo desejado
/// 2. A ordem define a sequência de execução
///
/// 🔧 COMO ADICIONAR NOVO TIPO DE ATIVIDADE:
/// 1. Adicione o novo tipo em `TipoAtividadeMobile`
/// 2. Crie uma nova entrada aqui com as etapas desejadas
///
/// 🔧 COMO REMOVER ETAPA DE UM TIPO:
/// 1. Remova a etapa da lista do tipo desejado
///
/// 💡 EXEMPLO: Para inverter ordem de APR e Checklist no MPDJ:
/// ```dart
/// TipoAtividadeMobile.mpdj: [
///   EtapaAtividade.checklist,        // ← Agora vem primeiro
///   EtapaAtividade.apr,              // ← Agora vem depois
///   EtapaAtividade.resumoAnomalias,
///   EtapaAtividade.mpDjForm,
///   EtapaAtividade.finalizada,
/// ],
/// ```
final Map<TipoAtividadeMobile, List<EtapaAtividade>> fluxoPorTipoAtividade = {
  // 🔍 Inspeção Visual/Inspeção Térmica/Inspeção Ultrassônica
  TipoAtividadeMobile.ivItIu: [
    EtapaAtividade.apr,
    EtapaAtividade.checklist,
    EtapaAtividade.resumoAnomalias,
    EtapaAtividade.finalizada,
  ],

  // 🔋 Medições de Baterias
  TipoAtividadeMobile.mpbb: [
    EtapaAtividade.apr,
    EtapaAtividade.checklist,
    EtapaAtividade.resumoAnomalias,
    EtapaAtividade.mpBbForm,
    EtapaAtividade.finalizada,
  ],

  // ⚡ Medições de Disjuntores
  TipoAtividadeMobile.mpdj: [
    EtapaAtividade.apr,
    EtapaAtividade.checklist,
    EtapaAtividade.resumoAnomalias,
    EtapaAtividade.mpDjForm,
    EtapaAtividade.finalizada,
  ],

  // 🔧 ADICIONE NOVOS TIPOS AQUI:
  // TipoAtividadeMobile.novoTipo: [
  //   EtapaAtividade.apr,
  //   EtapaAtividade.novaEtapa,
  //   EtapaAtividade.finalizada,
  // ],
};
