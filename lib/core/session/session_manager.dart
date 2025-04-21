import 'package:get/get.dart';
import 'package:sympla_app/core/logger/app_logger.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/services/auth_service.dart';

class SessionManager extends GetxService {
  final AppDatabase db;
  final AuthService authService;

  SessionManager({required this.db, required this.authService});

  UsuarioTableData? _usuario;
  UsuarioTableData? get usuario => _usuario;

  Future<void> init() async {
    final usuarios = await db.usuarioDao.getAllUsuarios();
    if (usuarios.isNotEmpty) {
      final local = usuarios.first;
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
  }

  bool get estaLogado {
    if (_usuario == null) return false;

    final ultimoLogin = _usuario!.ultimoLogin;
    if (ultimoLogin == null) return false;

    final diff = DateTime.now().difference(ultimoLogin).inHours;
    return diff < 24;
  }

  Future<void> logout() async {
    await db.usuarioDao.limparUsuarios();
    _usuario = null;
    AppLogger.i('Usuário deslogado', tag: 'Sessão');
  }
}
