import 'package:sympla_app/core/constants/api_constants.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
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
        ApiConstants.login,
        data: {
          'matricula': matricula,
          'senha': senha,
        },
      );
      return LoginResponse.fromJson(response.data);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[auth_repository_impl - login] ${erro.mensagem}',
          tag: 'AuthRepositoryImpl', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<LoginResponse> refreshToken(String refreshToken) async {
    try {
      final response = await dio.post(
        ApiConstants.refreshToken,
        data: {'refreshToken': refreshToken},
      );
      return LoginResponse.fromJson(response.data);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[auth_repository_impl - refreshToken] ${erro.mensagem}',
          tag: 'AuthRepositoryImpl', error: e, stackTrace: s);
      rethrow;
    }
  }
}
