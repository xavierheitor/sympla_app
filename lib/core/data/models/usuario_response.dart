class UsuarioResponse {
  final int id;
  final String nome;
  final String matricula;
  final String email;
  final String funcao;

  UsuarioResponse({
    required this.id,
    required this.nome,
    required this.matricula,
    required this.email,
    required this.funcao,
  });

  factory UsuarioResponse.fromJson(Map<String, dynamic> json) {
    return UsuarioResponse(
      id: json['id'] ?? 0,
      nome: json['nome'] ?? '',
      matricula: json['matricula'] ?? '',
      email: json['email'] ?? '',
      funcao: json['funcao'] ?? '',
    );
  }
}
