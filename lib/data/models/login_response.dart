import 'package:sympla_app/data/models/usuario_response.dart';

class LoginResponse {
  final String token;
  final String refreshToken;
  final UsuarioResponse usuario;

  LoginResponse({
    required this.token,
    required this.refreshToken,
    required this.usuario,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['token'] ?? '',
      refreshToken: json['refreshToken'] ?? '',
      usuario: UsuarioResponse.fromJson(json['usuario'] ?? {}),
    );
  }
}
