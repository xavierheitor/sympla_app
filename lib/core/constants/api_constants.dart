abstract class ApiConstants {
  static const baseUrl = 'http://10.0.2.2:3001/api';

  static const login = '/auth/login';
  static const refreshToken = '/auth/refresh';

  static const tipoAtividade = '/v2/tipo-atividade';
  static const equipamentos = '/v2/equipamentos';
  static const gruposDefeito = '/v2/grupos-defeito';
  static const subgruposDefeito = '/v2/subgrupos-defeito';
  static const atividades = '/v2/atividades';
  static const tecnicos = '/v2/tecnicos';
  static const aprs = '/v2/aprs';
  static const perguntas = '/v2/apr-perguntas';
  static const aprPerguntasRelacionamentos =
      '/v2/apr-perguntas-relacionamentos';

  static const checklist = '/v2/checklists';
  static const checklistGrupos = '/v2/checklist-grupos';
  static const checklistSubgrupos = '/v2/checklist-subgrupos';
  static const checklistPerguntas = '/v2/checklist-perguntas';
  static const checklistPerguntasRelacionamentos =
      '/v2/checklist-perguntas-relacionamentos';
  static const defeitos = '/v2/defeitos';

  // ... adicione mais endpoints conforme necessário
}
