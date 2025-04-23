import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/data/models/login_response.dart';
import 'package:sympla_app/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final DioClient dio;

  AuthRepositoryImpl(this.dio);

  @override
  Future<LoginResponse> login(String matricula, String senha) async {
    try {
      final response = await dio.post(
        'auth/login',
        data: {
          'matricula': matricula,
          'senha': senha,
        },
      );
      return LoginResponse.fromJson(response.data);
    } catch (e) {
      AppLogger.e('Erro ao fazer login: $e');
      rethrow;
    }
  }

  @override
  Future<LoginResponse> refreshToken(String refreshToken) async {
    final response = await dio.post(
      '/auth/refresh',
      data: {'refreshToken': refreshToken},
    );
    return LoginResponse.fromJson(response.data);
  }
}
