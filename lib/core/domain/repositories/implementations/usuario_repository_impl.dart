import 'package:sympla_app/core/domain/dto/usuario_table_dto.dart';
import 'package:sympla_app/core/domain/dto/auth/login_response_dto.dart';
import 'package:sympla_app/core/domain/repositories/abstracts/usuario_repository.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/network/dio_client.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/storage/daos/usuario_dao.dart';

class UsuarioRepositoryImpl implements UsuarioRepository {
  final DioClient dio;
  final AppDatabase db;
  final UsuarioDao usuarioDao;

  UsuarioRepositoryImpl(this.db, this.dio) : usuarioDao = db.usuarioDao;

  @override
  Future<List<UsuarioTableDto>> buscarTodosUsuarios() async {
    try {
      final usuarios = await usuarioDao.buscarTodos();
      return usuarios.map((e) => UsuarioTableDto.fromData(e)).toList();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
        '[usuario_repository_impl - buscarTodosUsuarios] ${erro.mensagem}',
        tag: 'UsuarioRepositoryImpl',
        error: e,
        stackTrace: s,
      );
      return [];
    }
  }

  @override
  Future<UsuarioTableDto?> buscarUsuario(String usuarioId) async {
    try {
      final usuario = await usuarioDao.buscarPorMatricula(usuarioId);
      return usuario != null ? UsuarioTableDto.fromData(usuario) : null;
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
        '[usuario_repository_impl - buscarUsuario] ${erro.mensagem}',
        tag: 'UsuarioRepositoryImpl',
        error: e,
        stackTrace: s,
      );
      return null;
    }
  }

  @override
  Future<void> deletarTodosUsuarios() async {
    try {
      await usuarioDao.limparTodos();
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
        '[usuario_repository_impl - deletarTodosUsuarios] ${erro.mensagem}',
        tag: 'UsuarioRepositoryImpl',
        error: e,
        stackTrace: s,
      );
    }
  }

  @override
  Future<void> deletarUsuario(String usuarioId) async {
    try {
      await usuarioDao.deletarPorId(usuarioId);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
        '[usuario_repository_impl - deletarUsuario] ${erro.mensagem}',
        tag: 'UsuarioRepositoryImpl',
        error: e,
        stackTrace: s,
      );
    }
  }

  @override
  Future<LoginResponseDto> login(String matricula, String senha) async {
    try {
      final response = await dio.post('/login', data: {
        'matricula': matricula,
        'senha': senha,
      });
      return LoginResponseDto.fromJson(response.data);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
        '[usuario_repository_impl - login] ${erro.mensagem}',
        tag: 'UsuarioRepositoryImpl',
        error: e,
        stackTrace: s,
      );
      throw erro;
    }
  }

  @override
  Future<LoginResponseDto> refreshToken(String refreshToken) async {
    try {
      final response = await dio.post('/refresh-token', data: {
        'refreshToken': refreshToken,
      });
      return LoginResponseDto.fromJson(response.data);
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
        '[usuario_repository_impl - refreshToken] ${erro.mensagem}',
        tag: 'UsuarioRepositoryImpl',
        error: e,
        stackTrace: s,
      );
      throw erro;
    }
  }
  @override
  Future<void> salvarUsuario(UsuarioTableDto usuario) async {
    try {
      await usuarioDao.salvar(usuario.toCompanion());
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
        '[usuario_repository_impl - salvarUsuario] ${erro.mensagem}',
        tag: 'UsuarioRepositoryImpl',
        error: e,
        stackTrace: s,
      );
    }
  }
  @override
  Future<UsuarioTableDto?> buscarUsuarioPorMatricula(String matricula) async {
    try {
      final usuario = await usuarioDao.buscarPorMatricula(matricula);
      return usuario != null ? UsuarioTableDto.fromData(usuario) : null;
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e(
        '[usuario_repository_impl - buscarUsuarioPorMatricula] ${erro.mensagem}',
        tag: 'UsuarioRepositoryImpl',
        error: e,
        stackTrace: s,
      );
      return null;
    }
  }
}
