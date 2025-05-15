import 'package:get/get.dart';
import 'package:sympla_app/core/core_app/services/auth_service.dart';
import 'package:sympla_app/core/domain/dto/usuario_table_dto.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';

class SessionManager extends GetxService {
  final AuthService authService;

  SessionManager({required this.authService});

  UsuarioTableDto? _usuario;
  bool _inicializado = false;
  bool _refreshing = false;

  UsuarioTableDto? get usuario => _usuario;
  bool get estaLogado {
    if (!_inicializado) return false;
    if (_usuario == null) return false;
    final login = _usuario!.ultimoLogin;
    if (login == null) return false;
    return DateTime.now().difference(login).inHours < 24;
  }

  String? get tokenSync => _usuario?.token;
  Future<String?> get token async => _usuario?.token;

  Future<void> init() async {
    AppLogger.d('[SessionManager] Inicializando sessão...');
    try {
      final usuarios = await authService.getUsuarios();
      if (usuarios.isEmpty) return;

      _usuario = usuarios.first;
      AppLogger.i('Usuário local encontrado: ${_usuario!.nome}', tag: 'Sessão');

      final diff = DateTime.now().difference(_usuario!.ultimoLogin!).inHours;
      AppLogger.d('Último login há $diff horas', tag: 'Sessão');

      if (diff >= 24) {
        await logout();
        return;
      }

      if (_usuario!.refreshToken?.isNotEmpty == true) {
        try {
          await renovarToken();
        } catch (_) {
          AppLogger.w('Falha ao renovar token. Sessão offline permitida.',
              tag: 'Sessão');
        }
      }
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('Erro ao inicializar sessão',
          tag: 'SessionManager', error: erro.mensagem, stackTrace: s);
      rethrow;
    } finally {
      _inicializado = true;
    }
  }

  Future<void> renovarToken() async {
    if (_refreshing) return;

    final token = _usuario?.refreshToken;
    if (token == null || token.isEmpty) {
      throw Exception('Refresh token ausente');
    }

    _refreshing = true;
    try {
      await authService.refresh(token);
      _usuario = (await authService.getUsuarios()).first;
      AppLogger.i('Token renovado com sucesso', tag: 'Sessão');
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('Erro ao renovar token',
          tag: 'SessionManager', error: erro.mensagem, stackTrace: s);
      rethrow;
    } finally {
      _refreshing = false;
    }
  }

  Future<bool> logout() async {
    try {
      final result = await authService.logout();
      if (result) {
        _usuario = null;
        AppLogger.i('Sessão encerrada com sucesso', tag: 'Sessão');
        return true;
      }
      return false;
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('Erro ao encerrar sessão',
          tag: 'SessionManager', error: erro.mensagem, stackTrace: s);
      return false;
    }
  }
}
