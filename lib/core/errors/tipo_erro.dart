enum TipoErro {
  api, // Falhas de requisição (timeout, 500, 401 etc.)
  dados, // Problemas de parsing, campos ausentes etc.
  credenciais, // Erros de autenticação
  banco, // Falhas no banco de dados
  desconhecido, // Erros não classificados
}
