import 'package:sympla_app/core/domain/dto/usuario_table_dto.dart';
import 'package:sympla_app/core/domain/dto/auth/login_response_dto.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/usuario_repository.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/usuario_dao.dart';

class UsuarioRepositoryImpl implements UsuarioRepository {
  final DioClient dio;
  final AppDatabase db;
  final UsuarioDao usuarioDao;

  UsuarioRepositoryImpl(this.db, this.dio) : usuarioDao = db.usuarioDao;

  @override
  Future<List<UsuarioTableDto>> buscarTodosUsuarios() {
    // TODO: implement buscarTodosUsuarios
    throw UnimplementedError();
  }

  @override
  Future<UsuarioTableDto> buscarUsuario(String usuarioId) {
    // TODO: implement buscarUsuario
    throw UnimplementedError();
  }

  @override
  Future<void> deletarTodosUsuarios() {
    // TODO: implement deletarTodosUsuarios
    throw UnimplementedError();
  }

  @override
  Future<void> deletarUsuario(String usuarioId) {
    // TODO: implement deletarUsuario
    throw UnimplementedError();
  }

  @override
  Future<bool> estaVazio() {
    // TODO: implement estaVazio
    throw UnimplementedError();
  }

  @override
  Future<LoginResponseDto> login(String matricula, String senha) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<LoginResponseDto> refreshToken(String refreshToken) {
    // TODO: implement refreshToken
    throw UnimplementedError();
  }

  @override
  Future<void> salvarUsuario(UsuarioTableDto usuario) {
    // TODO: implement salvarUsuario
    throw UnimplementedError();
  }

  @override
  Future<UsuarioTableDto?> buscarUsuarioPorMatricula(String matricula) {
    // TODO: implement buscarUsuarioPorMatricula
    throw UnimplementedError();
  }
}
