class LoginResponse {
  final String token;
  final String refreshToken;
  final DateTime expiresAt;
  final DateTime refreshTokenExpiresAt;
  final String? id;
  final String uuid;
  final String nome;
  final String matricula;

  LoginResponse({
    required this.token,
    required this.refreshToken,
    required this.expiresAt,
    required this.refreshTokenExpiresAt,
    required this.uuid,
    required this.nome,
    required this.matricula,
    this.id,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    final usuario = json['usuario'] ?? {};
    return LoginResponse(
      token: json['token'] ?? '',
      refreshToken: json['refreshToken'] ?? '',
      expiresAt: DateTime.parse(json['expiresAt']),
      refreshTokenExpiresAt: DateTime.parse(json['refreshTokenExpiresAt']),
      uuid: usuario['id'] ?? 0,
      nome: usuario['nome'] ?? '',
      matricula: usuario['matricula'] ?? '',
    );
  }
}
