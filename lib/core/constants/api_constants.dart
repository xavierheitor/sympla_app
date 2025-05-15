abstract class ApiConstants {
  static const baseUrl = 'http://10.0.2.2:3001/api';

  static const login = '/auth/login';
  static const refreshToken = '/auth/refresh';

  static const tipoAtividade = '/tipo-atividade';
  static const atividades = '/atividades';

  static const equipamentos = '/equipamentos';
  static const gruposDefeito = '/grupos-defeito';
  static const subgruposDefeito = '/subgrupos-defeito';
  static const gruposDefeitoCodigo = '/grupos-defeito-codigo';
  static const defeitos = '/v2/defeitos';

  static const aprs = '/aprs';
  static const perguntas = '/apr-perguntas';
  static const aprPerguntasRelacionamentos = '/apr-perguntas-relacionamentos';

  static const checklist = '/checklists';
  static const checklistPerguntas = '/checklist-perguntas';
  static const checklistPerguntasRelacionamentos =
      '/v2/checklist-perguntas-relacionamentos';

  static const tecnicos = '/tecnicos';
  // ... adicione mais endpoints conforme necessário
}
