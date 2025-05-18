abstract class ApiConstants {
  static const int maxRefreshAttempts = 3;
  static const baseUrl = 'http://10.0.2.2:3001/api';

  static const login = '/auth/login';
  static const refreshToken = '/auth/refresh';

  static const tipoAtividade = '/atividade/tipo-atividades';
  static const atividades = '/atividade';

  static const gruposDefeito = '/defeito/grupo-defeito';
  static const subgruposDefeito = '/defeito/subgrupo-defeito';
  static const gruposDefeitoCodigo = '/defeito/grupo-defeito-codigo';
  static const defeitos = '/defeito';

  static const equipamentos = '/equipamento';

  static const aprs = '/apr/modelos';
  static const aprPerguntas = '/apr/perguntas';
  static const aprPerguntasRelacionamentos = '/apr/perguntas-relacionamento';

  static const checklist = '/checklist/modelos';
  static const checklistPerguntas = '/checklist/perguntas';
  static const checklistPerguntasRelacionamentos =
      '/checklist/perguntas-relacionamento';

  static const tecnicos = '/tecnico';
  // ... adicione mais endpoints conforme necessário
}
