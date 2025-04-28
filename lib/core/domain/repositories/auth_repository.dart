import 'package:sympla_app/core/data/models/login_response.dart';

abstract class AuthRepository {
  Future<LoginResponse> login(String matricula, String senha);
  Future<LoginResponse> refreshToken(String refreshToken);
}
