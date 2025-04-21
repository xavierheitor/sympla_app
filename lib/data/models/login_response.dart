class LoginResponse {
  final String token;
  final String refreshToken;
  final String nome;

  LoginResponse({
    required this.token,
    required this.refreshToken,
    required this.nome,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    final usuario = json['usuario'] ?? {};

    return LoginResponse(
      token: json['token'] ?? '',
      refreshToken: json['refreshToken'] ?? '',
      nome: usuario['nome'] ?? '',
    );
  }
}
