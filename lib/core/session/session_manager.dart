import 'package:get/get.dart';
import 'package:sympla_app/core/errors/error_handler.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/core/services/auth_service.dart';

class SessionManager extends GetxService {
  final AppDatabase db;
  final AuthService authService;

  SessionManager(AppDatabase find,
      {required this.db, required this.authService});

  UsuarioTableData? _usuario;
  UsuarioTableData? get usuario => _usuario;
  bool _inicializado = false;

  Future<void> init() async {
    AppLogger.d('[session_manager - init] Buscando usuários locais...');
    try {
      final usuarios = await db.usuarioDao.getAllUsuarios();
      AppLogger.d(
          '[session_manager - init] Encontrado ${usuarios.length} usuário(s)');

      if (usuarios.isNotEmpty) {
        final local = usuarios.first;
        AppLogger.d('📋 Usuário carregado: ${local.nome}');
        _usuario = local;

        final now = DateTime.now();
        final diff = now.difference(local.ultimoLogin ?? now).inHours;

        AppLogger.i('Último login há $diff horas', tag: 'Sessão');

        if (local.refreshToken != null && diff < 24) {
          try {
            await authService.refresh(local.refreshToken!);
            final atualizado = await db.usuarioDao.getAllUsuarios();
            _usuario = atualizado.first;
            AppLogger.i('Token renovado com sucesso', tag: 'Sessão');
          } catch (e) {
            AppLogger.w('Falha ao renovar token, mantendo login offline',
                tag: 'Sessão');
          }
        }

        if (diff >= 24) {
          await logout();
        }
      }
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[session_manager - init] ${erro.mensagem}',
          tag: 'SessionManager', error: e, stackTrace: s);
      rethrow;
    }
    _inicializado = true;
  }

  bool get estaLogado {
    if (!_inicializado) {
      AppLogger.d('⚠️ estaLogado acessado antes de init!');
      return false;
    }

    if (_usuario == null) {
      AppLogger.d('🔐 Nenhum usuário encontrado');
      return false;
    }

    final ultimoLogin = _usuario!.ultimoLogin;
    if (ultimoLogin == null) {
      AppLogger.d('🔐 Nenhum login encontrado');
      return false;
    }

    final diff = DateTime.now().difference(ultimoLogin).inHours;
    AppLogger.d('🔐 Diferença de tempo: $diff horas');
    return diff < 24;
  }

  Future<bool> logout() async {
    try {
      final result = await db.usuarioDao.limparUsuarios();
      AppLogger.i('Usuário deslogado', tag: 'Sessão');
      if (result) {
        _usuario = null;
        return true;
      }
      return false;
    } catch (e, s) {
      final erro = ErrorHandler.tratar(e, s);
      AppLogger.e('[session_manager - logout] ${erro.mensagem}',
          tag: 'SessionManager', error: e, stackTrace: s);
      return false;
    }
  }

  Future<String?> get token async {
    return usuario?.token ?? '';
  }

  String? get tokenSync => _usuario?.token;
}
