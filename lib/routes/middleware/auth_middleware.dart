import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sympla_app/core/constants/route_names.dart';
import 'package:sympla_app/core/core_app/session/session_manager.dart';
import 'package:sympla_app/core/logger/app_logger.dart';

/// Middleware de autenticação.
///
/// Intercepta a navegação e redireciona para `Routes.login`
/// quando não há sessão válida.
class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final sessionManager = Get.find<SessionManager>();

    if (!sessionManager.estaLogado) {
      AppLogger.w(
          '🔐 Acesso negado à rota "$route". Redirecionando para login.',
          tag: 'AuthMiddleware');
      return const RouteSettings(name: Routes.login);
    }

    AppLogger.i('✅ Acesso autorizado à rota "$route"', tag: 'AuthMiddleware');
    return null;
  }
}
