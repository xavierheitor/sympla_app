import 'package:sympla_app/core/domain/dto/usuario_table_dto.dart';
import 'package:sympla_app/core/domain/dto/auth/login_response_dto.dart';

abstract class UsuarioRepository {
  Future<UsuarioTableDto?> buscarUsuario(String usuarioId);
  Future<List<UsuarioTableDto>> buscarTodosUsuarios();
  Future<void> salvarUsuario(UsuarioTableDto usuario);
  Future<void> deletarUsuario(String usuarioId);
  Future<void> deletarTodosUsuarios();
  Future<LoginResponseDto> login(String matricula, String senha);
  Future<LoginResponseDto> refreshToken(String refreshToken);
  Future<UsuarioTableDto?> buscarUsuarioPorMatricula(String matricula);
}
