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
    return LoginResponse(
      token: json['token'],
      refreshToken: json['refreshToken'],
      nome: json['nome'],
    );
  }
}
