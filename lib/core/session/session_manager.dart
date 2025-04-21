import 'package:get/get.dart';
import 'package:sympla_app/core/storage/app_database.dart';
import 'package:sympla_app/services/auth_service.dart';
import 'package:sympla_app/core/logger/app_logger.dart';

class SessionManager extends GetxService {
  final AppDatabase db;
  final AuthService authService;

  SessionManager({required this.db, required this.authService});

  UsuarioTableData? _usuario;
  UsuarioTableData? get usuario => _usuario;

  Future<SessionManager> init() async {
    final usuarios = await db.usuarioDao.getAllUsuarios();
    if (usuarios.isNotEmpty) {
      final local = usuarios.first;
      _usuario = local;

      final now = DateTime.now();
      final diff = now.difference(local.ultimoLogin ?? now).inHours;

      AppLogger.i('Último login há $diff horas', tag: 'Sessão');

      // Se tiver refreshToken e ainda estiver dentro do prazo, tenta renovar
      if (local.refreshToken != null && diff < 24) {
        try {
          await authService.refresh(local.refreshToken!);
          final atualizado = await db.usuarioDao.getAllUsuarios();
          _usuario = atualizado.first;
          AppLogger.i('Token renovado com sucesso', tag: 'Sessão');
        } catch (e) {
          AppLogger.w('Falha ao renovar token, mantendo login offline',
              tag: 'Sessão');
          // ainda é considerado logado se estiver dentro de 24h
        }
      }

      // Se passou de 24h sem sucesso no refresh, desloga
      if (diff >= 24) {
        await logout();
      }
    }

    return this;
  }

  bool get estaLogado => _usuario != null;

  Future<void> logout() async {
    await db.usuarioDao.limparUsuarios(); // método que remove tudo
    _usuario = null;
    AppLogger.i('Usuário deslogado', tag: 'Sessão');
  }
}
