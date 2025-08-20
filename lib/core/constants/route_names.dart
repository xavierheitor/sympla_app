/// Rotas nomeadas utilizadas pelo aplicativo.
///
/// Mantenha sincronizado com `AppPages.routes`.
abstract class Routes {
  static const login = '/login';
  static const splash = '/splash';
  static const erroSplash = '/erro-splash';
  static const home = '/home';
  static const apr = '/apr';
  static const checklist = '/checklist';
  static const resumoAnomalias = '/resumo-anomalias';
  static const mpBbForm = '/mp-bb-form';

  static const mpDjForm = '/mp-dj-form';
  static const etapaResistenciaContato = '/etapa-resistencia-contato';
  static const etapaIsolamento = '/etapa-isolamento';
  static const etapaTempoOperacao = '/etapa-tempo-operacao';
  static const etapaPressaoSf6 = '/etapa-pressao-sf6';
  
  // Sincronização
  static const syncStatus = '/sync-status';
  
  // ... futuras rotas
}
